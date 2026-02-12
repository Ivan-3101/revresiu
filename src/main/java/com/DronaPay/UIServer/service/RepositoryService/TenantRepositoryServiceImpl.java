package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.Tenant;
import com.DronaPay.UIServer.repository.TenantRepository;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class TenantRepositoryServiceImpl extends TenantRepositoryService {

    @Autowired
    private TenantRepository tenantRepository;

//     @Value("${score.server.hash}")
//     private Boolean hash;


    @Value("${drona.key}")
    private String drona_key;


    @Override
    public Tenant saveAudit(Tenant input) {
        return tenantRepository.save(input);
    }

    @Override
    public List<Tenant> findNonDeletedTenants() throws Exception {
        return tenantRepository.findAllByIrecordStatus(0);
    }

    @Override
    public Tenant findByTenantId(String tenantid) {
        return tenantRepository.findByVcTenantId(tenantid);
    }

    @Override
    @Cacheable("usertenantbyid")
    public List<Tenant> findByTenantIds(List<Integer> itenantid) {
        return tenantRepository.findAllById(itenantid);
    }

    @Override
    public List<Tenant> findByOrgId(String orgid) throws Exception {
        return tenantRepository.findAllByIorgId_VcOrgId(orgid);
    }

    @Override
    @Cacheable(value="TENANTS", key="#itenantid", unless="#result == null")
    public Tenant findByItenantId(Integer itenantid) {
        return tenantRepository.getReferenceById(itenantid);
    }

    @Override
    @CacheEvict(value="TENANTS", key="#itenantid")
    public void update(Tenant tenant, Integer itenantid) {
        tenantRepository.saveAndFlush(tenant);
    }

    @Override
    public String findAPIKeyTenant(Integer itenantid) {
        Tenant tenant = findByItenantId(itenantid);

        // if (hash) {
        //     String hashedkey = new DigestUtils("SHA-256")
        //             .digestAsHex(tenant.getConfig().get("api-keys").get(0).get("api-key").asText());
        //     System.out.println("hashed key for tenantid " + itenantid + " is " + hashedkey);
        //     return hashedkey;
        // } else {

        JsonNode apiKeys = tenant.getConfig().get("api-keys");
        String retKey = "";
        for (JsonNode apiKey : apiKeys) {
            String expiry = apiKey.get("expiry").asText();
            LocalDate expiryDate = LocalDate.parse(expiry);
            if (!LocalDate.now().isAfter(expiryDate)) {
                retKey = apiKey.get("api-key").asText();
                break;
            }
        }
        return decryptCipherText(retKey);
    }

    @Override
    public String decryptCipherText(String ciphertext) {
        return tenantRepository.decryptApiKey(ciphertext, drona_key);
    }

}
