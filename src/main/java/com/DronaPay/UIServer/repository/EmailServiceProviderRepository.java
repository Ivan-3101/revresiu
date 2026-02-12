package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.EmailServiceProvider;

public interface EmailServiceProviderRepository extends JpaRepository<EmailServiceProvider, Integer> {
    
}
