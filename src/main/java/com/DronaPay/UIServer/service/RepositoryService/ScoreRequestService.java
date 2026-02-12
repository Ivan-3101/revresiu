package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.ScoreRequests;

public interface ScoreRequestService {

	public List<ScoreRequests> getListByIClassName(String vcClassName) throws Exception;

	public ScoreRequests findByvcRequestID(String vcRequestID) throws Exception;

	public void save(ScoreRequests scoreRequests) throws Exception;
}
