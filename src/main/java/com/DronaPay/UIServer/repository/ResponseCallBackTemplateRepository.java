package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.ResponseCallBackTemplate;

public interface ResponseCallBackTemplateRepository extends JpaRepository<ResponseCallBackTemplate ,Integer> {
    
}
