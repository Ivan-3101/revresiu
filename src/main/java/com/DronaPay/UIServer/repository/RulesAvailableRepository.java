package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.RulesAvailable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RulesAvailableRepository extends JpaRepository<RulesAvailable, Integer> {

    // @Query("SELECT r from RulesAvailable r where r.bactive=true and r.bdelete = false ")
    // public List<RulesAvailable> findAllByIDecisionIDActiveAndNotDeleted();
    public List<RulesAvailable> findByBactiveTrueAndBdeleteFalse();

    // @Query("SELECT r from RulesAvailable r where r.bactive=true and r.bdelete = false and r.vcRuleType=:vcruletype ")
    // public List<RulesAvailable> findAllByIDecisionIDActiveAndNotDeletedAndModes(@Param("vcruletype") String vcRuleType);
    public List<RulesAvailable> findByBactiveTrueAndBdeleteFalseAndVcRuleType(String vcRuleType);
    
    // @Query("SELECT DISTINCT r.vcRuleType from RulesAvailable r where r.bactive=true and r.bdelete = false ")
    // public List<String> findDistinctRuleType();
   

    // @Query("SELECT DISTINCT r.vcLabel from RulesAvailable r where r.bactive=true and r.bdelete = false ")
    // public List<String> findDistinctLabel();
    
}

