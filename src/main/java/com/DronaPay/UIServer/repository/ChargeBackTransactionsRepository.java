package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ChargeBackTransactions;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ChargeBackTransactionsRepository extends JpaRepository<ChargeBackTransactions, Integer> {
    
}
