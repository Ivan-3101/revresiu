package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.Tenant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TenantRepository extends JpaRepository<Tenant, Integer> {

    public Tenant findByVcTenantId(String tenantid);

    public List<Tenant> findAllByIrecordStatus(Integer status);

    public List<Tenant> findAllByIorgId_VcOrgId(String orgid);

    @Query(nativeQuery = true, value = "select pgp_sym_decrypt(cast(?1  as bytea), ?2 )")
    public String decryptApiKey(@Param("ciphertext") String ciphertext, @Param("key") String key);

}