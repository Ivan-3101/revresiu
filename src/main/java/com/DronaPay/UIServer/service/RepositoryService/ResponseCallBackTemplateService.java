package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ResponseCallBackTemplate;

public interface ResponseCallBackTemplateService {
    
    public ResponseCallBackTemplate findById(Integer id) throws Exception;
}
