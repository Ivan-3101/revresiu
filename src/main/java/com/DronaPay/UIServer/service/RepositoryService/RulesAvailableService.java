package com.DronaPay.UIServer.service.RepositoryService;


import com.DronaPay.UIServer.model.RulesAvailable;

import java.util.List;

public interface RulesAvailableService {

    public List<RulesAvailable> findAllByIDecisionIDActiveAndNotDeleted() throws Exception;

    public List<RulesAvailable> findAllByIDecisionIDActiveAndNotDeletedAndRuleType() throws Exception;

    public List<String> findRuleTypes() throws Exception;

    public RulesAvailable findById(Integer iRuleAvailableID) throws Exception;

    public List<String> findRuleLabels() throws Exception;

    public void save(RulesAvailable ra) throws Exception;

}
