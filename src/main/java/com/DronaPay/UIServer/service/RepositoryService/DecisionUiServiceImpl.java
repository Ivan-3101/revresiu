package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import com.DronaPay.UIServer.repository.DecisionUiRepository;
import com.fasterxml.jackson.databind.node.JsonNodeType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.DecisionUi;

@Service
public class DecisionUiServiceImpl extends DecisionUiService {
    
    @Autowired
	private DecisionUiRepository decisionUiRepository;

	public DecisionUi save(DecisionUi decision) throws Exception {
		return decisionUiRepository.save(decision);
	}

	public List<DecisionUi> findAll() throws Exception {
		return decisionUiRepository.findAll();
	}

	public DecisionUi findByiDecisionID(int iDecisionID, Integer tenantid) throws Exception {
		return decisionUiRepository.findByiDecisionIDAndItenantId(iDecisionID, tenantid).orElse(null);
	}

    @Override
    public List<DecisionUi> findAllActive(Integer tenantid) throws Exception {
        // TODO Auto-generated method stub
        //return decisionUiRepository.findAllActive();
		return decisionUiRepository.findByBactiveTrueAndItenantId(tenantid);
    }

	@Override
	public DecisionUi saveAudit(DecisionUi input) {
		// TODO Auto-generated method stub
		return decisionUiRepository.save(input);
	}

	@Override
	public List<DecisionUi> findAllNonDeleted() throws Exception {
		// TODO Auto-generated method stub
		//return decisionUiRepository.findAllNonDeleted();
		return decisionUiRepository.findByIstatus_iStatusIDIsNullOrIstatus_iStatusID(1);
	}

	@Override
	public List<DecisionUi> findActiveBatchDecisions() throws Exception {
		///not in use hence passing hardcoded value for tenantid
		List<DecisionUi> decisions = decisionUiRepository.findByBactiveTrueAndItenantId(0);
		return decisions.stream().filter(dec -> {
			if(dec.getAttribs() == null || dec.getAttribs().getNodeType() == JsonNodeType.NULL) {
				return false;
			} else {
				return true;
			}
		}).collect(Collectors.toList());
	}

	@Override
	public List<DecisionUi> findAllNonDeletedTenants(List<Integer> tenants) throws Exception {
		return decisionUiRepository.findAllByItenantIdIn(tenants)
		.stream()
		.filter(dec->{
			return ((dec.getIstatus() == null) || (dec.getIstatus() != null && dec.getIstatus().getIStatusID() == 1));
		}).collect(Collectors.toList());
	}

	
}
