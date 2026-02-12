package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.TemplateResponseRepository;
import com.DronaPay.UIServer.model.TemplateResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TemplateResponseServiceImpl implements TemplateResponseService {

    @Autowired
    private TemplateResponseRepository templateResponseRepository;

    @Override
    public TemplateResponse getByTemplateName(String templateName) {
        //return templateResponseRepository.findBytemplateNameAndActiveFlag(templateName);
        return templateResponseRepository.findByTemplateNameAndActiveFlag(templateName, "Y");
    }
    
}
