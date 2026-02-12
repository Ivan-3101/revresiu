package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.Constants.Enum.WebuserMappingType;
import com.DronaPay.UIServer.model.WebuserMapping;
import com.DronaPay.UIServer.repository.WebuserMappingRepository;
import com.DronaPay.UIServer.util.UserMapping;
import com.DronaPay.UIServer.util.WebuserMappingUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class WebuserMappingServiceImpl implements WebuserMappingService {

    @Autowired
    private WebuserMappingRepository webuserMappingRepository;

    @Autowired
    private WebuserMappingUtil webuserMappingUtil;

    public List<WebuserMapping> findGroupByID(Integer group_id) {
        return webuserMappingRepository.findAllByMappingIDAndMappingType(group_id, String.valueOf(WebuserMappingType.Group));
    }

    public List<WebuserMapping> findGroupByIDs(List<Integer> group_id) {
        return webuserMappingRepository.findAllByMappingIDInAndMappingType(group_id, String.valueOf(WebuserMappingType.Group));
    }

    public List<WebuserMapping> findRoleByID(Integer role_id) {
        return webuserMappingRepository.findAllByMappingIDAndMappingType(role_id, String.valueOf(WebuserMappingType.Role));
    }

    @Override
    public List<WebuserMapping> findByTenantIDs(List<Integer> tenantids) {
        return webuserMappingRepository.findAllByMappingIDInAndMappingType(tenantids, String.valueOf(WebuserMappingType.Tenant));
    }

    public UserMapping findByIDsWebuserIDandOrgID(String mapping_type, Integer webuser_id, Integer org_id) {
        return webuserMappingUtil.mappingHelper(webuserMappingRepository.findAllByMappingTypeAndWebuserIDAndIorgId(mapping_type, webuser_id, org_id),
                mapping_type);
    }

    public List<WebuserMapping> findByIDAndOrgId(String mappingtype, Integer webuserid, Integer orgid){
        return webuserMappingRepository.findAllByMappingTypeAndWebuserIDAndIorgId(mappingtype, webuserid, orgid);
    }

    public List<WebuserMapping> findByIDsWebuserIDandOrgID(Integer webuser_id, Integer org_id) {
        return webuserMappingRepository.findAllByWebuserIDAndIorgId(webuser_id, org_id);
    }

    public Optional<WebuserMapping> findByWebuserIDAndMappingType(Integer webuserID, String mappingType) {
        return webuserMappingRepository.findByWebuserIDAndMappingType(webuserID, mappingType);
    }

    public List<WebuserMapping> findByIorgIdAndMappingIDAndMappingType(Integer orgId, Integer mappingID, String mappingType) {
        return webuserMappingRepository.findByIorgIdAndMappingIDAndMappingType(orgId, mappingID, mappingType);
    }
}
