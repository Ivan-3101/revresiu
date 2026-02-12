package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;
import java.util.stream.Collectors;

import com.DronaPay.UIServer.repository.TransactionClassesUiRepository;
import com.DronaPay.UIServer.util.UserMapping;
import com.fasterxml.jackson.databind.JsonNode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.TransactionClassesUI;

@Service
public class TransactionClassesUiServiceImpl implements TransactionClassesUiService{
    
    @Autowired
	private TransactionClassesUiRepository transactionClassesRepository;

	public List<TransactionClassesUI> findAll() throws Exception {
		return transactionClassesRepository.findByiRecordStatus(0);
	}

	@Override
	public List<TransactionClassesUI> findByTenantClass(UserMapping mappings) {
		return transactionClassesRepository.findAllByiRecordStatusAndItenantIdInAndIclassIDIn(
				0, mappings.getTenantids(), mappings.getMappingIds());
		
	}

	public List<TransactionClassesUI> findAllActiveClasses() throws Exception {
		return transactionClassesRepository.findBybActiveTrue();
	}

	public TransactionClassesUI findByiClassID(int iClassID, Integer itenantid) throws Exception {
		return transactionClassesRepository.findByIclassIDAndItenantId(iClassID, itenantid);
		//return transactionClassesRepository.getById(iClassID);

//        return transactionClassesRepository.findByiClassID(iClassID);
	}

	public TransactionClassesUI save(TransactionClassesUI transactionClasses) throws Exception {
		return transactionClassesRepository.save(transactionClasses);
	}

	@Override
	public TransactionClassesUI findByClassName(String vcClassName, Integer tenantid) throws Exception {
		
		return transactionClassesRepository.findByiRecordStatusAndVcClassNameAndItenantId(0, vcClassName, tenantid);
	}

	@Override
	public List<TransactionClassesUI> findByIdecisionId(Integer iDecisionId) throws Exception {
		
		return transactionClassesRepository.findByiDecisionID(iDecisionId);
	}

	@Override
	public List<TransactionClassesUI> findByIdecisionIdInParams(Integer iDecisionId) throws Exception {
		//return transactionClassesRepository.findByIDecisionIdInParams("%decision_id\"\\: "+iDecisionId+"%");
		List<TransactionClassesUI> allList = transactionClassesRepository.findByiRecordStatus(0);
		List<TransactionClassesUI> decisionList = allList.stream().filter(x->
		{
			JsonNode node = x.getVcDecisionParams();
			if(node != null) {
				JsonNode decision = node.findValue("decision_id");
				if(decision != null) {
					return (decision.asInt() == iDecisionId);
				} else {
					return false;
				}
			}
			else {
				return false;
			}
		}).collect(Collectors.toList());

		return decisionList;
	}

	@Override
	public List<TransactionClassesUI> findAllByTenantIds(List<Integer> tenantids) {
		return transactionClassesRepository.findAllByiRecordStatusAndItenantIdIn(0, tenantids);
	}

	@Override
	public List<TransactionClassesUI> findAllByTenantId(Integer tenantid) {
		return transactionClassesRepository.findAllByiRecordStatusAndItenantId(0, tenantid);
	}

	@Override
	public List<TransactionClassesUI> findByClassIDs(List<Integer> classids) {
		return transactionClassesRepository.findAllById(classids);
	}
}
