UPDATE ui.dashboardquery SET
vcdashboardquery = 'with callbackbyte as (
select jsonb_array_elements(convert_from(callBackResponsebyte.bytes_, ''UTF8'')::jsonb->''riskTransactions'')->>''status'' as status ,  
jsonb_array_elements(convert_from(callBackResponsebyte.bytes_, ''UTF8'')::jsonb->''riskTransactions'')->''error''->>''message'' as error,
jsonb_array_elements(convert_from(callBackResponsebyte.bytes_, ''UTF8'')::jsonb->''riskTransactions'')->''riskTransaction''->>''status'' as type 
from camunda.act_hi_varinst callBackResponse
left join camunda.act_ge_bytearray callBackResponsebyte on callBackResponsebyte.id_ = callBackResponse.bytearray_id_
where callBackResponse.name_ = ''callBackResponse''
and  callBackResponse.var_type_ = ''json''
and callBackResponse.create_time_ between cast((current_date - 1) as timestamp) and cast(current_date  as timestamp)
and callBackResponse.tenant_id_ = ''10''
), callback as (
select  case 
    when error = ''Transaction already released to merchant''
    then type ||  '' Transaction already released to merchant''
    else type ||  '' ''|| status 
    end as status from callbackbyte
)
select ''Release Hold - Success'' as "Status", coalesce((select count(1) from callback where status = ''RELEASE SUCCESS'' group by status), 0) as "Count"
union 
select ''Hold - Success'' as "Status", coalesce((select count(1) from callback where status = ''HOLD SUCCESS'' group by status), 0) as "Count" 
union 
select ''Release Hold - Failed'' as "Status", coalesce((select count(1) from callback where status = ''RELEASE FAILED'' group by status), 0) as "Count"
union 
select ''Hold - Failed'' as "Status", coalesce((select count(1) from callback where status = ''HOLD FAILED'' group by status), 0) as "Count" 
union 
select ''Release Hold - Transaction already released to merchant'' as "Status", coalesce((select count(1) from callback where status = ''RELEASE Transaction already released to merchant'' group by status), 0) as "Count"
union 
select ''Hold - Transaction already released to merchant'' as "Status", coalesce((select count(1) from callback where status = ''HOLD Transaction already released to merchant'' group by status), 0) as "Count"'::text WHERE
idashboardqueryid = 130 AND itenantid = 10;