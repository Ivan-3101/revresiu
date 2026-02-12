package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.PerspectiveQueryRespository;
import com.DronaPay.UIServer.model.PerspectiveQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
class PerspectiveQueryServiceImpl implements PerspectiveQueryService {

    @Autowired
    private PerspectiveQueryRespository perspectiveQueryRespository;

    public PerspectiveQuery findByVcTableName(String vcTableName) throws Exception {
        return perspectiveQueryRespository.findByVcTableName(vcTableName);
    }
}