package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.Organization;
import com.DronaPay.UIServer.repository.OrganizationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrganizationRepositoryServiceImpl implements OrganizationRepositoryService {

    @Autowired
    private OrganizationRepository organizationRepository;

    @Override
    public List<Organization> findAllOrgs() {
        return organizationRepository.findAll();
    }

    @Override
    public Organization findOrg(String orgId) {
        return organizationRepository.findByVcOrgId(orgId).orElseThrow(
                () -> new NotFoundException("failed to find org with name " + orgId, orgId, "INFO"));
    }

//    @Override
//    public Optional<Organization> findByIorgId(Integer iorgId) {
//        return organizationRepository.findByIorgid(iorgId);
//    }

}
