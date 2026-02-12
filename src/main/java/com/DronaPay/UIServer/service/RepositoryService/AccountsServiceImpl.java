package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.Accounts;
import com.DronaPay.UIServer.repository.AccountsRepository;

@Service
public class AccountsServiceImpl implements AccountsService {
    @Autowired
    private AccountsRepository accountsRepo;

    @Override
    public Accounts findByVcExternalID(String address) throws Exception {
        return accountsRepo.findByVcExternalAccountID(address);
    }
    
}
