package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.Organization;

import java.util.List;
import java.util.Optional;

public interface OrganizationRepositoryService {
    public List<Organization> findAllOrgs();

    public Organization findOrg(String orgId);

//    public Optional<Organization> findByIorgId(Integer iorgId);
}
