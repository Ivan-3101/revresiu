package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.Tenant;
import com.DronaPay.UIServer.service.Audit;

public abstract class TenantRepositoryService implements Audit<Tenant> {

    public abstract List<Tenant> findNonDeletedTenants() throws Exception;

    public abstract Tenant findByTenantId(String tenantid);

    public abstract List<Tenant> findByTenantIds(List<Integer> itenantid);

    public abstract List<Tenant> findByOrgId(String orgid) throws Exception;

    public abstract Tenant findByItenantId(Integer itenantid);

    public abstract String findAPIKeyTenant(Integer itenantid);

    public abstract String decryptCipherText(String ciphertext);

    public abstract void update(Tenant tenant, Integer itenantid);
    
}
