package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.WebuserMapping;
import com.DronaPay.UIServer.model.WebuserMappingAudit;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.List;
import java.util.Optional;

public interface WebuserMappingService {

    public List<WebuserMapping> findGroupByID(Integer group_id);

    public List<WebuserMapping> findGroupByIDs(List<Integer> group_ids);

    public List<WebuserMapping> findRoleByID(Integer role_id);

    public List<WebuserMapping> findByTenantIDs(List<Integer> tenantids);

    public UserMapping findByIDsWebuserIDandOrgID(String mapping_type, Integer webuser_id, Integer org_id);

    public List<WebuserMapping> findByIDsWebuserIDandOrgID(Integer webuser_id, Integer org_id);

    public Optional<WebuserMapping> findByWebuserIDAndMappingType(Integer webuserID, String mappingType);

    public List<WebuserMapping> findByIorgIdAndMappingIDAndMappingType(Integer orgId, Integer mappingID, String mappingType);

    public List<WebuserMapping> findByIDAndOrgId(String mappingtype, Integer webuserid, Integer orgid);
}
