package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.DecisionUi;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;

public interface DecisionUiRepository extends JpaRepository<DecisionUi,Integer> {
    
    // @Query("SELECT d FROM DecisionUi d WHERE d.bActive = true ")
    // public List<DecisionUi> findAllActive();

    public Optional<DecisionUi> findByiDecisionIDAndItenantId(Integer decisionid, Integer tenantid);

    public List<DecisionUi> findByBactiveTrueAndItenantId(Integer tenantid);

    // @Query("SELECT d FROM DecisionUi d WHERE d.iStatus.iStatusID = 1 OR d.iStatus.iStatusID = null ")
    // public List<DecisionUi> findAllNonDeleted();
    public List<DecisionUi> findByIstatus_iStatusIDIsNullOrIstatus_iStatusID(Integer one);

    public List<DecisionUi> findAllByItenantIdIn(List<Integer> tenantids);
}
