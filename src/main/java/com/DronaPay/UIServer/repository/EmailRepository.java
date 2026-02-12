package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.EmailModel;

public interface EmailRepository extends JpaRepository<EmailModel, Integer> {

    public EmailModel findByIdAndItenantId(Integer id, Integer tenantid);

}
