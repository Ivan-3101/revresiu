package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.EmailModel;
import com.DronaPay.UIServer.repository.EmailRepository;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class EmailRepoService {
    @Autowired
    EmailRepository emailRepository;

    public EmailModel findById(Integer id, Integer tenantid) throws Exception {
        return emailRepository.findByIdAndItenantId(id, tenantid);
    }
}
