package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.RulesAvailableUi;

public interface RulesAvailableUiRepository extends JpaRepository<RulesAvailableUi, Integer> {
    public List<RulesAvailableUi> findByBactiveTrueAndBdeleteFalse();

    public List<RulesAvailableUi> findByBactiveTrueAndBdeleteFalseAndItenantId(Integer tenantid);
    
    public List<RulesAvailableUi>findByBactiveTrueAndBdeleteFalseAndItenantIdIsNull();
}
