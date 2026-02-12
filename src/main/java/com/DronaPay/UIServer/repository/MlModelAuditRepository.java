package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.MlModelAudit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MlModelAuditRepository  extends JpaRepository<MlModelAudit, Integer> {

    MlModelAudit findByIstatusIsNullAndBclosedFalseAndVcMlFlowModelNameAndItenantId(String modelName, Integer itenantId);

    MlModelAudit findByBclosedFalseAndImodelAuditIdAndItenantId(Integer auditID, Integer tenantId);

    MlModelAudit findByBclosedFalseAndImodelIdAndItenantId(Integer agentId, Integer tenantId);

    List<MlModelAudit> findByIstatusIsNullAndBclosedFalseAndItenantIdIn(List<Integer> tenantid);

}
