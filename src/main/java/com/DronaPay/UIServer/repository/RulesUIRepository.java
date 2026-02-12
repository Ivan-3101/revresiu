package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.Rules;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RulesUIRepository extends JpaRepository<Rules, Integer> {

    // @Query("SELECT r from Rules r where r.idecisionID.iDecisionID = :idecisionid
    // and r.bcustom=true and r.bdelete = false ")
    // public List<Rules> findAllByIDecisionID(@Param("idecisionid") int
    // iDecisionID);

    public Optional<Rules> findByiRuleIDAndItenantId(Integer ruleid, Integer tenantid);

    public List<Rules> findByIdecisionIDAndItenantIdAndBdeleteFalseAndBactiveTrue(Integer decisionid, Integer tenantid);

    public List<Rules> findByIdecisionIDAndItenantIdAndBcustomTrueAndBdeleteFalse(Integer iDecisionID, Integer tenantid);

    public Rules findByiRuleIDAndBactiveTrueAndBapicallTrue(Integer iRuleID);


    public List<Rules> findByIdecisionIDAndBdeleteFalseAndBactiveFalse(Integer iDecisionID);

    public List<Rules> findByIdecisionIDAndBdeleteFalseAndBactiveTrue(Integer iDecisionID);

    // @Query("SELECT r from Rules r where r.idecisionID.iDecisionID = :idecisionid
    // and r.bdelete = false ")
    // public List<Rules> findAllDefaultByIDecisionID(@Param("idecisionid") int
    // iDecisionID);
    public List<Rules> findByIdecisionIDAndItenantIdAndBdeleteFalse(Integer iDecisionID, Integer tenantid);

    // @Query("SELECT DISTINCT r.vcRuleName from Rules r where r.bactive=true AND
    // r.bdelete = false ")
    // public List<String> findAllActiveNonDeletedRuleNames();
    public List<Rules> findDistinctByBactiveTrueAndBdeleteFalse();

    public List<Rules> findAllByBactiveTrueAndBdeleteFalseAndItenantIdIn(List<Integer> tenants);

    // @Query("select r from Rules r where r.iDecisionID.iDecisionID= :idecisionid
    // and r.bCustom = true and r.bActive = true and JSON_VALUE(r.vcRuleOrder,
    // '$.SuccessRule') = -1")
    // @Query(value = "select * from ui.rules where idecisionid = :idecisionid and
    // bdelete = false and cast(cast(vcruleorder as json) ->> 'SuccessRule' as
    // Integer) = -1", nativeQuery = true)
    // public Rules findLastDefaultRuleByIDecisionID(@Param("idecisionid") int
    // iDecisionID);

    // @Query("select r from Rules r where r.iDecisionID.iDecisionID= :idecisionid
    // and r.bCustom = true and r.bActive = true and JSON_VALUE(r.vcRuleOrder,
    // '$.SuccessRule') = :iruleid")
    // @Query(value = "select * from ui.rules where idecisionid = :idecisionid and
    // bdelete = false and cast(cast(vcruleorder as json) ->> 'SuccessRule' as
    // Integer) = :iruleid", nativeQuery = true)
    // public Rules findDefaultRuleBySuccessRuleAndIDecisionID(@Param("iruleid") int
    // iRuleID,
    // @Param("idecisionid") int iDecisionID);

    // Default Rule methods
    // @Query("SELECT r from Rules r where r.idecisionID.iDecisionID = :idecisionid
    // and r.bcustom=false and r.bdelete = false ")
    // public List<Rules> findAllDefaultRulesByIDecisionID(@Param("idecisionid") int
    // iDecisionID);
    public List<Rules> findByIdecisionIDAndBcustomFalseAndBdeleteFalse(Integer iDecisionID);

    // @Query("SELECT COUNT(r.iRuleID) from Rules r where
    // r.iruleAvailableID.iRuleAvailableID = :iruleavailableid and r.bdelete = false
    // ")
    // public Integer getCountByIRuleAvailableID(@Param("iruleavailableid") int
    // iRuleAvailableID);
    public Integer countByIruleAvailableIDAndBdeleteFalse(Integer iRuleAvailableID);

    // @Query("SELECT COUNT(r.iRuleID) from Rules r where
    // r.iruleAvailableID.iRuleAvailableID = :iruleavailableid and
    // r.idecisionID.iDecisionID = :idecisionid and r.bdelete = false ")
    // public Integer
    // getCountByIRuleAvailableIDAndIDecisionId(@Param("iruleavailableid") int
    // iRuleAvailableID,@Param("idecisionid") int iDecisionId);
    public Integer countByIruleAvailableIDAndIdecisionIDAndBdeleteFalse(
            Integer iRuleAvailableID, Integer iDecisionId);

}