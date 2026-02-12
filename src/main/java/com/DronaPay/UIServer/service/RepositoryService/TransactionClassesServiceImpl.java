package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.TransactionClassesRepository;
import com.DronaPay.UIServer.model.TransactionClasses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionClassesServiceImpl implements TransactionClassesService {

	@Autowired
	private TransactionClassesRepository transactionClassesRepository;

	public List<TransactionClasses> findAll() throws Exception {
		return transactionClassesRepository.findAll();
	}

	public List<TransactionClasses> findAllActiveClasses() throws Exception {
		return transactionClassesRepository.findBybActiveTrue();
	}

	public TransactionClasses findByiClassID(int iClassID) throws Exception {
		return transactionClassesRepository.getById(iClassID);
//        return transactionClassesRepository.findByiClassID(iClassID);
	}

	public void save(TransactionClasses transactionClasses) throws Exception {
		transactionClassesRepository.save(transactionClasses);
	}
}