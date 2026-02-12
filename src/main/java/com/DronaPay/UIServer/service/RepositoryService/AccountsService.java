package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.Accounts;

public interface AccountsService {
    public Accounts findByVcExternalID(String address) throws Exception;
}
