package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.RulesDraftUi;

import java.util.List;
public interface RulesDraftUiService {
    public RulesDraftUi save(RulesDraftUi rl) throws Exception;
    public RulesDraftUi findById(Integer id) throws Exception;
    public List<RulesDraftUi> findAllActiveNonDeleted() throws Exception;
     public List<RulesDraftUi> findAllActiveNonDeletedByTenant(Integer tenantId) throws Exception;
}
