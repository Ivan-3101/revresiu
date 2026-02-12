package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.RulesMasters;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RulesRepository extends JpaRepository<RulesMasters, Integer> {

    // @Query("SELECT r from RulesMasters r where r.idecisionID.iDecisionID = :idecisionid and r.bcustom=true and r.bdelete = false ")
    // public List<RulesMasters> findAllByIDecisionID(@Param("idecisionid") int iDecisionID);

    public List<RulesMasters> findByIdecisionID_iDecisionIDAndBcustomTrueAndBdeleteFalse(int iDecisionID);

    // @Query("select r from Rules r where r.iDecisionID.iDecisionID= :idecisionid
    // and r.bCustom = true and r.bActive = true and JSON_VALUE(r.vcRuleOrder,
    // '$.SuccessRule') = -1")
    // @Query(value = "select * from masters.rules where  idecisionid = :idecisionid and bcustom = true and bactive = true and bdelete = false and cast(cast(vcruleorder as json) ->> 'SuccessRule' as Integer) = -1", nativeQuery = true)
    // public RulesMasters findLastCustomRuleByIDecisionID(@Param("idecisionid") int iDecisionID);
    public List<RulesMasters> findByIdecisionID_iDecisionIDAndBcustomTrueAndBactiveTrueAndBdeleteFalse(Integer iDecisionID);


    // @Query("select r from Rules r where r.iDecisionID.iDecisionID= :idecisionid
    // and r.bCustom = true and r.bActive = true and JSON_VALUE(r.vcRuleOrder,
    // '$.SuccessRule') = :iruleid")
    // @Query(value = "select * from masters.rules where idecisionid = :idecisionid and bcustom = true and bactive = true and bdelete = false and cast(cast(vcruleorder as json) ->> 'SuccessRule' as Integer) = :iruleid", nativeQuery = true)
    // public RulesMasters findCustomRuleBySuccessRuleAndIDecisionID(@Param("iruleid") int iRuleID,
    //                                                               @Param("idecisionid") int iDecisionID);

    //Default Rule methods

    // @Query("SELECT r from RulesMasters r where r.idecisionID.iDecisionID = :idecisionid and r.bcustom=false and r.bdelete = false ")
    // public List<RulesMasters> findAllDefaultRulesByIDecisionID(@Param("idecisionid") int iDecisionID);
    public List<RulesMasters> findByIdecisionID_iDecisionIDAndBcustomFalseAndBdeleteFalse(Integer iDecisionID);

}
