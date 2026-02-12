package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.EmailServiceProvider;
import com.DronaPay.UIServer.repository.EmailServiceProviderRepository;

@Service
public class EmailProviderRepoService {
    @Autowired
    EmailServiceProviderRepository emailProviderRepo;

    public EmailServiceProvider findById(Integer id) throws Exception {
        return emailProviderRepo.getReferenceById(id);
    }
}
