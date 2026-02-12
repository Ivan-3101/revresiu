package com.DronaPay.UIServer.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.Organization;

public interface OrganizationRepository extends JpaRepository<Organization, Integer> {

    public Optional<Organization> findByVcOrgId(String orgid);

//    Optional<Organization> findByIorgid(Integer iorgId);

}
