package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.TransactionClassesUiAudit;
import com.DronaPay.UIServer.repository.TransactionClassUiAuditRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionClassesUiAuditServiceImpl extends TransactionClassesUiAuditService {

    @Autowired
    private TransactionClassUiAuditRepository transactionClassUiAuditRepository;


    @Override
    public TransactionClassesUiAudit saveAudit(TransactionClassesUiAudit input) {
        return transactionClassUiAuditRepository.save(input);
    }

    @Override
    public List<TransactionClassesUiAudit> findPendingEntries() throws Exception {
        //return transactionClassUiAuditRepository.findAllPendingEntries();
        return transactionClassUiAuditRepository.findByIstatusIsNullAndBclosedFalse();
    }


    @Override
    public TransactionClassesUiAudit findPendingEntriesTenantClass(String vcclassname, Integer itenantid) {
        return transactionClassUiAuditRepository.findByvcClassNameAndItenantIdAndIstatusIsNullAndBclosedFalse(vcclassname, itenantid);
    }

    @Override
    public List<TransactionClassesUiAudit> findPendingEntriesTenantClass(List<Integer> itenantids,
                                                                         List<Integer> classids) {
        //if -1 search for all classes, else filter by classes
        if (classids.contains(-1)) {
            return transactionClassUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndItenantIdIn(itenantids);
        } else {
            return transactionClassUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndItenantIdInAndIclassIDIn(itenantids, classids);
        }
    }

    @Override
    public TransactionClassesUiAudit findTransactionDetail(Integer iclassId, Integer tenantid) {
        //return transactionClassUiAuditRepository.findClassPendingForAction(iclassId);
        return transactionClassUiAuditRepository.findByBclosedFalseAndIclassAuditIDAndItenantId(iclassId,tenantid);
    }

    @Override
    public TransactionClassesUiAudit findPendingEntriesByIClassId(Integer iClassId, Integer itenantid) {
        //return transactionClassUiAuditRepository.findClassPendingForActionByIclassId(iClassId);
        return transactionClassUiAuditRepository.findByBclosedFalseAndIclassIDAndItenantId(iClassId, itenantid);
    }

    @Override
    public List<TransactionClassesUiAudit> findPendinEntriesByIDecisionId(Integer iDecisionId) {
        //return transactionClassUiAuditRepository.findAllPendingEntriesByIdecisionId(iDecisionId);
        return transactionClassUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndIdecisionID(iDecisionId);
    }

}
