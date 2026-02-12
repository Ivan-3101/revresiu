package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MlModel;

import java.util.List;

public interface MlModelService {

    public MlModel saveMlModel(MlModel mlModel) throws Exception;

    public MlModel findByModelIdAndTenant(Integer modelId, Integer tenantId) throws Exception ;

    public MlModel findByModelName(String modelName, Integer tenantId) throws Exception ;

    public List<MlModel> findAllNonDeletedTenants(List<Integer> tenants) throws Exception;
}
