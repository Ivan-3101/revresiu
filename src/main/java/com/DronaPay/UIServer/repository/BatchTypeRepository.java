package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.BatchJobType;

public interface BatchTypeRepository extends JpaRepository<BatchJobType, Integer> {
    
}
