package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MlModelAudit;
import com.DronaPay.UIServer.repository.MlModelAuditRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MlModelAuditServiceImpl implements MlModelAuditService {

    @Autowired
    private MlModelAuditRepository mlModelAuditRepository;

    @Override
    public MlModelAudit saveMlModelAudit(MlModelAudit mlModelAudit) throws Exception {
        return mlModelAuditRepository.save(mlModelAudit);
    }

    @Override
    public MlModelAudit findByModelName(String modelName, Integer tenantId) throws Exception{
        return mlModelAuditRepository.findByIstatusIsNullAndBclosedFalseAndVcMlFlowModelNameAndItenantId(modelName, tenantId);
    }

    @Override
    public MlModelAudit findPendingMlModelAuditByAuditIDAndTenant(Integer auditID, Integer tenantId) throws Exception {
        return mlModelAuditRepository.findByBclosedFalseAndImodelAuditIdAndItenantId(auditID, tenantId);
    }

    @Override
    public MlModelAudit findPendingMlModelAuditByModelIDAndTenant(Integer modelId, Integer tenantId) throws Exception{
        return mlModelAuditRepository.findByBclosedFalseAndImodelIdAndItenantId(modelId, tenantId);
    }

    @Override
    public List<MlModelAudit> findPendingEntriesTenant(List<Integer> tenantid) throws Exception {
        return mlModelAuditRepository.findByIstatusIsNullAndBclosedFalseAndItenantIdIn(tenantid);
    }
}
