package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.DronaPay.UIServer.model.RulesDraft;

public interface RulesDraftRepository extends JpaRepository<RulesDraft, Integer> {
    public List<RulesDraft> findByBactiveTrueAndBdeleteFalse();
}
