package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.RulesAudit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RuleAuditRepository extends JpaRepository<RulesAudit, Integer> {

    // @Query("select r from Rules r where r.iDecisionID.iDecisionID= :idecisionid
    // and r.bCustom = true and r.bActive = true and JSON_VALUE(r.vcRuleOrder,
    // '$.SuccessRule') = -1")
    // @Query(value = "select * from ui.rulestempaudit where idecisionid =
    // :idecisionid and bdelete = false and bclosed=false and cast(cast(vcruleorder
    // as json) ->> 'SuccessRule' as Integer) = -1 ", nativeQuery = true)
    // public RulesAudit findLastDefaultRuleByIDecisionID(@Param("idecisionid") int
    // iDecisionID);
    public List<RulesAudit> findByIdecisionIDAndBdeleteFalseAndBclosedFalse(Integer iDecisionID);

    public RulesAudit findByiRuleIDAuditAndItenantIdAndBdeleteFalseAndBclosedFalse(Integer iDecisionID,
                                                                                   Integer tenantid);

    public List<RulesAudit> findByIdecisionIDAndItenantIdAndBclosedFalseAndIstatusIsNull(Integer iDecisionID,
                                                                                         Integer tenantid);

    public List<RulesAudit> findByIdecisionIDAndItenantIdAndBdeleteFalseAndBclosedFalse(
            Integer iDecisionID, Integer tenantid);

    public List<RulesAudit> findByIdecisionIDAndBdeleteFalseAndBclosedFalseAndBactiveFalse(Integer iDecisionID);
    // @Query("select r from Rules r where r.iDecisionID.iDecisionID= :idecisionid
    // and r.bCustom = true and r.bActive = true and JSON_VALUE(r.vcRuleOrder,
    // '$.SuccessRule') = :iruleid")
    // @Query(value = "select * from ui.rulestempaudit where idecisionid =
    // :idecisionid and bdelete = false and bclosed=false and cast(cast(vcruleorder
    // as json) ->> 'SuccessRule' as Integer) = :iruleid", nativeQuery = true)
    // public RulesAudit
    // findDefaultRuleBySuccessRuleAndIDecisionID(@Param("iruleid") int iRuleID,
    // @Param("idecisionid") int iDecisionID);

    // @Query("SELECT COUNT(r.iRuleIDAudit) from RulesAudit r where
    // r.iRuleAvailableID.iRuleAvailableID = :iruleavailableid and
    // r.iDecisionID.iDecisionID = :idecisionid and r.bdelete = false and r.bclosed
    // = false and r.istatus=null ")
    // public Integer
    // getCountByIRuleAvailableIDAndIDecisionId(@Param("iruleavailableid") int
    // iRuleAvailableID,@Param("idecisionid") int iDecisionId);
    public Integer countByIruleAvailableIDAndIdecisionIDAndBdeleteFalseAndBclosedFalseAndIstatusIsNull(
            Integer iRuleAvailableID, Integer iDecisionId);

    // @Query("SELECT r from RulesAudit r where r.iDecisionID.iDecisionID =
    // :idecisionid and r.bCustom=true and r.bDelete = false and r.bclosed = false
    // and r.istatus=null ")
    // public List<RulesAudit> findAllByCustomIDecisionID(@Param("idecisionid") int
    // iDecisionID);
    public List<RulesAudit> findByIdecisionIDAndBcustomTrueAndBdeleteFalseAndBclosedFalseAndIstatusIsNull(
            Integer iDecisionID);

    // @Query("SELECT r from RulesAudit r where r.iDecisionID.iDecisionID =
    // :idecisionid and r.bDelete = false and r.bclosed = false and r.istatus=null
    // ")
    // public List<RulesAudit> findAllByIDecisionID(@Param("idecisionid") int
    // iDecisionID);
    public List<RulesAudit> findByIdecisionIDAndBdeleteFalseAndBclosedFalseAndIstatusIsNull(Integer iDecisionID);

    // @Query("SELECT r from RulesAudit r where r.iDecisionID.iDecisionID =
    // :idecisionid and r.bclosed = false and r.istatus=null ")
    // public List<RulesAudit> findPendingEntriesByIDecisionID(@Param("idecisionid")
    // int iDecisionID);
    public List<RulesAudit> findByIdecisionIDAndBclosedFalseAndIstatusIsNull(Integer iDecisionID);

public boolean existsByiRuleIDAuditInAndIdecisionIDAndItenantIdAndBclosedFalseAndIstatusIsNull(List<Integer> iRuleIDAudit, Integer idecisionID, Integer itenantId);

}
