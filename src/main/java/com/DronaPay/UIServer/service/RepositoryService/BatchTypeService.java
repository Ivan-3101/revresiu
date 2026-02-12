package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.BatchJobType;

public interface BatchTypeService {
    
    List<BatchJobType> findAll();

    BatchJobType findById(Integer typeId) throws Exception;
}
