package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.ScoreRequestRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.DronaPay.UIServer.model.ScoreRequests;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ScoreRequestServiceImpl implements ScoreRequestService {

	@Autowired
	private ScoreRequestRepository scoreRequestRepository;

	public List<ScoreRequests> findByClassName(String className) throws Exception {
		List<ScoreRequests> allList = scoreRequestRepository.findAll();
		List<ScoreRequests> classNameList = allList.stream().filter( x ->
		{
			String vcRequestData = x.getVcRequestData();
			ObjectMapper mapper = new ObjectMapper();
			try {
				JsonNode requestJSON = mapper.readTree(vcRequestData);
				if(requestJSON != null) {
					JsonNode txnNode = requestJSON.get("txn");
					if(txnNode != null) {
						JsonNode classNode = txnNode.get("class");
						if(classNode != null) {
							return classNode.asText().equals(className);
						} else {
							return false;
						}
					} else {
						return false;
					}
					//return (requestJSON.get("txn").get("class").asText().equals(className));
				}
				else {
					return false;
				}
			} catch (JsonProcessingException e) {
				return false;
			}	
		}).collect(Collectors.toList());

		return classNameList;
	}

	public List<ScoreRequests> getListByIClassName(String vcClassName) throws Exception {
		//return scoreRequestRepository.findByClassName(vcClassName);
		return findByClassName(vcClassName);
	}

	public ScoreRequests findByvcRequestID(String vcRequestID) throws Exception {
		//return scoreRequestRepository.findByvcRequestID(vcRequestID);
		return scoreRequestRepository.findByVcRequestID(vcRequestID);
	}

	public void save(ScoreRequests scoreRequests) throws Exception {
		scoreRequestRepository.save(scoreRequests);
	}
}
