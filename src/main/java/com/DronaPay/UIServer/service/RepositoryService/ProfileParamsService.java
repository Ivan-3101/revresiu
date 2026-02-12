package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

public interface ProfileParamsService {
    public List<String> findByWorkflowAndType(String workflowkey, String type, Integer tenantid) throws Exception;
}
