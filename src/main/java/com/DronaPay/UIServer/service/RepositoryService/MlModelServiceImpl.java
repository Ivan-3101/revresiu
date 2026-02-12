package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MlModel;
import com.DronaPay.UIServer.repository.MlModelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class MlModelServiceImpl implements MlModelService{

    @Autowired
    private MlModelRepository mlModelRepository;

    @Override
    public MlModel saveMlModel(MlModel mlModel) throws Exception {
        return mlModelRepository.save(mlModel);
    }

    @Override
    public MlModel findByModelIdAndTenant(Integer agentId, Integer tenantId) throws Exception{
        return mlModelRepository.findByImodelIdAndItenantId(agentId, tenantId);
    }

    @Override
    public MlModel findByModelName(String modelName, Integer tenantId) throws Exception{
        return mlModelRepository.findByVcMlFlowModelNameAndIrecordStatusAndItenantId(modelName, 0, tenantId);
    }

    @Override
    public List<MlModel> findAllNonDeletedTenants(List<Integer> tenants) throws Exception {
        return mlModelRepository.findAllByItenantIdIn(tenants)
                .stream()
                .filter(agent->{
                    return agent.getIstatus() == null || agent.getIstatus().getIStatusID() == 1;
                }).collect(Collectors.toList());
    }


}
