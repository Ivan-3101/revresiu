package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.DecisionUi;
import com.DronaPay.UIServer.service.Audit;

public abstract class DecisionUiService implements Audit<DecisionUi> {
    
    abstract DecisionUi save(DecisionUi decision) throws Exception;

	abstract List<DecisionUi> findAll() throws Exception;

	abstract List<DecisionUi> findAllActive(Integer tenantid) throws Exception;

	public abstract DecisionUi findByiDecisionID(int iDecisionID, Integer tenantid) throws Exception;

	abstract List<DecisionUi> findAllNonDeleted() throws Exception;

	public abstract List<DecisionUi> findAllNonDeletedTenants(List<Integer> tenants) throws Exception;

	public abstract List<DecisionUi> findActiveBatchDecisions() throws Exception;
	
}
