package com.DronaPay.UIServer.repository.MyBatiesMapper;

import com.DronaPay.UIServer.model.CamundaModels.AccountWithCount;
import com.DronaPay.UIServer.model.CamundaModels.AccountWithTaskID;
import com.DronaPay.UIServer.response.TaskResponse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface AccountWithCountMapper {

        @Select("select text_ as \"account\",count(t.proc_inst_id_) as \"count\"   from \n" +
                        "${camundaschema}.act_ru_task t \n" +
                        "left join ${camundaschema}.act_ru_variable v on v.proc_inst_id_ = t.proc_inst_id_\n" +
                        "where (v.name_='payeeAccount' or v.name_='payerAccount') and t.assignee_ is null  group by text_\n"
                        +
                        "order by count desc")
        List<AccountWithCount> findAllActiveTickets(@Param("camundaschema") String camundaSchema);

        @Select("<script>" +
                        "select text_ as \"account\", t.id_ as \"taskid\", t.proc_inst_id_ as \"processid\", t.tenant_id_ as \"tenantid\"\n" +
                        "from \n" +
                        "${camundaschema}.act_ru_task t \n" +
                        "join ${camundaschema}.act_re_procdef p on t.proc_def_id_ = p.id_\n" +
                        "left join ${camundaschema}.act_ru_variable v on v.proc_inst_id_ = t.proc_inst_id_\n" +
                        "where v.name_ in " +
                        "<foreach item='item' index='index' collection='nameList'" +
                        " open='(' separator=',' close=')'>" +
                        " #{item}" +
                        "</foreach>" +
                        "and p.key_ in " +
                        "<foreach item='item' index='index' collection='keyList'" +
                        " open='(' separator=',' close=')'>" +
                        " #{item}" +
                        "</foreach>" +
                        "and t.tenant_id_ in " +
                        "<foreach item='item' index='index' collection='tenantList'" +
                        " open='(' separator=',' close=')'>" +
                        " #{item}" +
                        "</foreach>" +
                        " and t.assignee_ is null  \n" +
                        "group by text_ , t.id_, t.proc_inst_id_" +
                        "</script>")
        List<AccountWithTaskID> findAllOpenTicketsByVariableNames(@Param("nameList") List<String> nameList,
                        @Param("camundaschema") String camundaSchema,
                        @Param("keyList") List<String> keys, @Param("tenantList") List<String> tenantids);

        @Select("select text_ as \"account\", t.id_ as \"taskid\"\n" +
                        "from \n" +
                        "${camundaschema}.act_ru_task t \n" +
                        "left join ${camundaschema}.act_ru_variable v on v.proc_inst_id_ = t.proc_inst_id_\n" +
                        "where v.name_=#{value1} and t.assignee_ is null  \n" +
                        "group by text_ , t.id_")
        List<AccountWithTaskID> findAllOpenTicketsByVariableName(@Param("value1") String value1,
                        @Param("camundaschema") String camundaSchema);

        @Select("<script>" +
                        "Select t.id as \"processInstanceId\",taskinst.id_ as \"id\"," +
                        "procinst.start_time_ as \"created\",procinst.state_ as \"state\"," +
                        "procinst.proc_def_key_ as \"defKey\",taskinst.name_ as \"name\"," +
                        "taskinst.assignee_ as \"assignee\",t.\"RiskScore\"::bigint as \"RiskScore\"," +
                        "t.\"TicketID\"::bigint as \"TicketID\",t.\"TransactionAmount\"::double precision as \"TransactionAmount\","
                        +
                        "t.\"WorkflowName\" as \"WorkflowName\",t.\"userActivity\",t.\"payee\" as \"payee\",t.\"payer\" as \"payer\",t.\"payeeAccount\" as \"payeAccount\",t.\"payerAccount\" as \"payerAccount\",t.\"failedRules\" as \"failedRules\""
                        + "from public.act_hi_procinst as procinst inner join (	SELECT id, COALESCE(\"RiskScore\", null) AS \"RiskScore\",     COALESCE(\"TicketID\", null) AS \"TicketID\" ,     COALESCE(\"TransactionAmount\", null) AS \"TransactionAmount\",     COALESCE(\"WorkflowName\", null) AS \"WorkflowName\",	COALESCE(\"userActivity\", null) AS \"userActivity\", COALESCE(\"payee\", null) AS \"payee\",	COALESCE(\"payer\", null) AS \"payer\",	COALESCE(\"payeeAccount\", null) AS \"payeeAccount\",	COALESCE(\"payerAccount\", null) AS \"payerAccount\",	COALESCE(\"failedRules\", null) AS \"failedRules\"      FROM crosstab(	  $$select distinct on (varinst.proc_inst_id_,varinst.name_) varinst.proc_inst_id_::text,varinst.name_::text,	case varinst.var_type_ when 'double' then varinst.double_::text else varinst.text_::text end as value_ 	from public.act_hi_varinst as varinst inner join public.act_hi_procinst procinst on varinst.proc_inst_id_=procinst.proc_inst_id_	where varinst.name_ in ('TicketID','WorkflowName','TransactionAmount','RiskScore','userActivity','payee','payer','payeeAccount','payerAccount','failedRules')    AND procinst.state_='ACTIVE' "
                        + "<if test=\"userc != null\"> AND procinst.proc_inst_id_ in (Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where (name_='userActivity' and text_::json->>'action'=\'Claim\' and text_::json->>'user'=\'${userc}\' )<if test=\"riskscore != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='RiskScore' and long_>=${riskscore}</if> <if test=\"minamount != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='TransactionAmount' and double_>=${minamount} </if> <if test=\"maxamount != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='TransactionAmount' and double_ &lt;=${maxamount} </if> <if test=\"failedrule != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_=\'${failedrule}\' </if> <if test=\"ticketid != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='TicketID' and long_::text=\'${ticketid}\' </if> <if test=\"usertask != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_ru_task where task_def_key_ in <foreach item='tasks' index='index' collection='usertask' open='(' separator=',' close=')' >\'${tasks}\'</foreach> </if>"
                        + " <if test=\"address !=null\"><if test=\"level =='Account'\"> "
                        + " <if test=\"type =='Payer'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='payerAccount' and text_=\'${address}\'</if>"
                        + " <if test=\"type =='Payee'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='payeeAccount' and text_=\'${address}\'</if>"
                        + " <if test=\"type =='Both'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where (name_='payeeAccount' or name_='payerAccount') and text_=\'${address}\' </if> "
                        + " </if>"
                        + " <if test=\"level =='VPA'\"> "
                        + " <if test=\"type=='Payer'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='payer' and text_=\'${address}\'</if>"
                        + " <if test=\"type=='Payee'\"> Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='payee' and text_=\'${address}\'</if>"
                        + " <if test=\"type=='Both'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where (name_='payee' or name_='payer') and text_=\'${address}\' </if> "
                        + " </if> </if>"
                        + ") </if>"
                        + "<if test=\"userc == null\"> AND procinst.proc_inst_id_ in (Select DISTINCT(proc_inst_id_) from public.act_ru_task where assignee_ is null <if test=\"riskscore != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='RiskScore' and long_>=${riskscore} </if>"
                        + "<if test=\"minamount != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='TransactionAmount' and double_>=${minamount} </if>"
                        + " <if test=\"maxamount != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='TransactionAmount' and double_ &lt;=${maxamount} </if> "
                        + "<if test=\"ticketid != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='TicketID' and long_::text=\'${ticketid}\' </if>"
                        + "<if test=\"failedrule != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_=\'${failedrule}\' </if>"
                        + " <if test=\"usertask != null\">  Intersect Select DISTINCT(proc_inst_id_) from public.act_ru_task where task_def_key_ in <foreach item='tasks' index='index' collection='usertask' open='(' separator=',' close=')' >\'${tasks}\'</foreach> </if>"
                        + " <if test=\"address !=null\"><if test=\"level =='Account'\"> "
                        + " <if test=\"type =='Payer'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='payerAccount' and text_=\'${address}\'</if>"
                        + " <if test=\"type =='Payee'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='payeeAccount' and text_=\'${address}\'</if>"
                        + " <if test=\"type =='Both'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where (name_='payeeAccount' or name_='payerAccount') and text_=\'${address}\' </if> "
                        + " </if>"
                        + " <if test=\"level =='VPA'\"> "
                        + " <if test=\"type=='Payer'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='payer' and text_=\'${address}\'</if>"
                        + " <if test=\"type=='Payee'\"> Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where name_='payee' and text_=\'${address}\'</if>"
                        + " <if test=\"type=='Both'\" > Intersect Select DISTINCT(proc_inst_id_) from public.act_hi_varinst where (name_='payee' or name_='payer') and text_=\'${address}\' </if> "
                        + " </if> </if>"
                        + "<if test=\"startdate !=null\"> Intersect Select  DISTINCT(proc_inst_id_) from public.act_hi_procinst where start_time_ &gt;= \'${startdate}\' and start_time_ &lt;= \'${enddate}\' </if>) </if>"
                        + "<if test=\"defs !=null\"> And procinst.proc_def_key_ IN <foreach item='item' index='index' collection='defs' open='(' separator=',' close=')' >\'${item}\'</foreach></if>"
                        + "order by varinst.proc_inst_id_,varinst.name_,varinst.create_time_ Desc NULLS Last$$,	$$VALUES ('RiskScore'),('TicketID'),('TransactionAmount'),('WorkflowName'),('userActivity'),('payee'),('payer'),('payeeAccount'),('payerAccount'),('failedRules')$$     ) AS     ct(id text,\"RiskScore\" text ,\"TicketID\" text,\"TransactionAmount\" text,\"WorkflowName\" text,\"userActivity\" text,\"payee\" text,\"payer\" text,\"payeeAccount\" text,\"payerAccount\" text,\"failedRules\" text) ) t on procinst.proc_inst_id_ = t.id left join public.act_ru_task  taskinst  on procinst.proc_inst_id_= taskinst.proc_inst_id_ "
                        +
                        "where t.id is not null "
                        + "<if test=\"orderby == 'starttime'\"> order by procinst.start_time_ </if>"
                        + "<if test=\"orderby =='riskscore'\"> order by t.\"RiskScore\"::bigint </if>"
                        + "<if test=\"orderby =='amount'\"> order by t.\"TransactionAmount\"::double precision </if>"
                        + "<if test=\"order == true\"> ASC</if>"
                        + "<if test=\"order == false\"> DESC</if>"
                        + "LIMIT #{limit};" +
                        "</script>")
        List<TaskResponse> findAllTaskNew(@Param("userc") String user, @Param("riskscore") Integer riskScore,
                        @Param("order") Boolean order, @Param("orderby") String orderBy,
                        @Param("defs") List<String> def, @Param("limit") Integer limit,
                        @Param("minamount") Double minAmount, @Param("maxamount") Double maxAmount,
                        @Param("failedrule") String failedRule, @Param("usertask") List<String> userTask,
                        @Param("level") String level, @Param("type") String type, @Param("address") String address,
                        @Param("startdate") String startDate, @Param("enddate") String endDate,
                        @Param("ticketid") String ticketId);
}
