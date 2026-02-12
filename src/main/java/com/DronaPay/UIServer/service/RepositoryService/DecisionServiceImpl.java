package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.DecisionRepository;
import com.DronaPay.UIServer.model.Decisions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DecisionServiceImpl implements DecisionService {

	@Autowired
	private DecisionRepository decisionRepository;

	public void save(Decisions decision) throws Exception {
		decisionRepository.save(decision);
	}

	public List<Decisions> findAll() throws Exception {
		return decisionRepository.findAll();
	}

	public Decisions findByiDecisionID(int iDecisionID) throws Exception {
		return decisionRepository.findById(iDecisionID).orElse(null);
	}

	@Override
	public List<Decisions> findAllActive() throws Exception {
		// TODO Auto-generated method stub
		//return decisionRepository.findAllActive();
		return decisionRepository.findByBactiveTrue();
	}
}
