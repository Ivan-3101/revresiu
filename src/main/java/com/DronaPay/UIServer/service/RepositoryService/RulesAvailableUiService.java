package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.RulesAvailableUi;

public interface RulesAvailableUiService {
    public List<RulesAvailableUi> findAllActiveNonDeleted() throws Exception;
    public List<RulesAvailableUi> findAllActiveNonDeletedTenant(Integer tenantid);
    public RulesAvailableUi save(RulesAvailableUi rl) throws Exception;
    public RulesAvailableUi findById(Integer id) throws Exception;
}
