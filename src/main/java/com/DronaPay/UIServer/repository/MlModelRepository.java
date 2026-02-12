package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.MlModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MlModelRepository extends JpaRepository<MlModel, Integer> {

    MlModel findByVcMlFlowModelNameAndIrecordStatusAndItenantId(String modelName, Integer zero, Integer itenantId);

    MlModel findByImodelIdAndItenantId(Integer modelId, Integer itenantId);

    List<MlModel> findAllByItenantIdIn(List<Integer> tenantids);

}
