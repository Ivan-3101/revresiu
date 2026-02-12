package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.Constants.Enum.WebuserMappingType;
import com.DronaPay.UIServer.model.WebuserMappingAudit;
import com.DronaPay.UIServer.repository.WebuserMappingAuditRepository;
import com.DronaPay.UIServer.util.UserMapping;
import com.DronaPay.UIServer.util.WebuserMappingUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class WebuserMappingAuditServiceImpl implements WebuserMappingAuditService {

    @Autowired
    private WebuserMappingAuditRepository webuserAuditMappingRepository;

    @Autowired
    private WebuserMappingUtil webuserMappingUtil;

    @Override
    public List<WebuserMappingAudit> findByTenantIDs(List<Integer> tenantids) {
        return webuserAuditMappingRepository.findAllByMappingIDInAndMappingType(tenantids, String.valueOf(WebuserMappingType.Tenant));
    }

    public UserMapping findByIDsWebuserIDandOrgID(String mapping_type, Integer webuser_id, Integer org_id) {
        return webuserMappingUtil.mappingHelperAudit
        (webuserAuditMappingRepository.findAllByMappingTypeAndWebUserAuditIDAndIorgId(mapping_type, webuser_id, org_id), mapping_type);
                
    }

    @Override
    public List<WebuserMappingAudit> findByAuditIDAndOrgId(String mappingtype, Integer webuserauditid, Integer orgid){
        return webuserAuditMappingRepository.findAllByMappingTypeAndWebUserAuditIDAndIorgId(mappingtype, webuserauditid, orgid);
    }
}
