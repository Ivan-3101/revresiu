package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.TransactionClassesUI;
import com.DronaPay.UIServer.util.UserMapping;

public interface TransactionClassesUiService {
    
    public List<TransactionClassesUI> findAll() throws Exception;

	public List<TransactionClassesUI> findAllActiveClasses() throws Exception;

	public TransactionClassesUI findByiClassID(int iClassID, Integer tenantid) throws Exception;

	public TransactionClassesUI save(TransactionClassesUI transactionClasses) throws Exception;

	public TransactionClassesUI findByClassName(String vcClassName, Integer tenantid) throws Exception;

	public List<TransactionClassesUI> findByIdecisionId(Integer iDecisionId) throws Exception;

	public List<TransactionClassesUI> findByIdecisionIdInParams(Integer iDecisionId) throws Exception;

	public List<TransactionClassesUI> findAllByTenantIds(List<Integer> tenantids);

	public List<TransactionClassesUI> findAllByTenantId(Integer tenantids);

	public List<TransactionClassesUI> findByClassIDs(List<Integer> classids);

	public List<TransactionClassesUI> findByTenantClass(UserMapping mapping);
}
