package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.TransactionClasses;

public interface TransactionClassesService {

	public List<TransactionClasses> findAll() throws Exception;

	public List<TransactionClasses> findAllActiveClasses() throws Exception;

	public TransactionClasses findByiClassID(int iClassID) throws Exception;

	public void save(TransactionClasses transactionClasses) throws Exception;

}
