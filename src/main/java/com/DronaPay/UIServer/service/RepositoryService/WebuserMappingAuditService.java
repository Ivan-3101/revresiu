package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.WebuserMappingAudit;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.List;

public interface WebuserMappingAuditService {
    public List<WebuserMappingAudit> findByTenantIDs(List<Integer> tenantids);

    public UserMapping findByIDsWebuserIDandOrgID(String mapping_type, Integer webuser_id, Integer org_id);

    public List<WebuserMappingAudit> findByAuditIDAndOrgId(String mappingtype, Integer webuserauditid, Integer orgid);

}
