package com.DronaPay.UIServer.service.RepositoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.model.ResponseCallBackTemplate;
import com.DronaPay.UIServer.repository.ResponseCallBackTemplateRepository;

@Component
public class ResponseCallBackTemplateServiceImpl implements ResponseCallBackTemplateService {

    @Autowired
    private ResponseCallBackTemplateRepository responseCallBackTemplateRepository;

    @Override
    public ResponseCallBackTemplate findById(Integer id) throws Exception {

        return responseCallBackTemplateRepository.findById(id).orElseThrow(() -> new Exception("No template found "));
    }

}
