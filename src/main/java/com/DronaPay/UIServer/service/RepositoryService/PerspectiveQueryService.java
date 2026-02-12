package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.PerspectiveQuery;

public interface PerspectiveQueryService {

    public PerspectiveQuery findByVcTableName(String vcTableName) throws Exception;
}
