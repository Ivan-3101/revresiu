package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.DronaPay.UIServer.model.RulesDraftUi;

public interface RulesDraftUiRepository extends JpaRepository<RulesDraftUi, Integer> {
    public List<RulesDraftUi> findByBactiveTrueAndBdeleteFalse();

     public List<RulesDraftUi> findByBactiveTrueAndBdeleteFalseAndItenantId(Integer tenantid);
}
