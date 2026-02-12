package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.Decisions;

public interface DecisionService {

	public void save(Decisions decision) throws Exception;

	public List<Decisions> findAll() throws Exception;

	public List<Decisions> findAllActive() throws Exception;


	public Decisions findByiDecisionID(int iDecisionID) throws Exception;
}
