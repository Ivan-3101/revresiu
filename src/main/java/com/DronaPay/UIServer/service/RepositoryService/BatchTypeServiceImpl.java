package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.BatchJobType;
import com.DronaPay.UIServer.repository.BatchTypeRepository;

@Service
public class BatchTypeServiceImpl implements BatchTypeService {

    @Autowired
    private BatchTypeRepository batchTypeRepository;

    @Override
    public List<BatchJobType> findAll() {
        return batchTypeRepository.findAll();
    }

    @Override
    public BatchJobType findById(Integer typeId) throws Exception {
       return batchTypeRepository.findById(typeId).get();
    }
    
}
