package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.FormMaster;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.repository.FormMasterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FormMasterServiceImpl implements FormMasterService {

    @Autowired
    private FormMasterRepository formMasterRepository;


    @Autowired
    private ActivityLogService activityLogService;

    public FormMaster findByFormName(String form_name, WebUser webuser, Integer tenantid)
    {
        return formMasterRepository.findByVcFormNameAndItenantId(form_name, tenantid)
                .orElseThrow(() -> {

                    return new NotFoundException("Form not found by form name "+form_name, webuser, form_name);
                });
    }

    public FormMaster findByID(Integer form_id, WebUser webuser, Integer tenantid)
    {
        return formMasterRepository.findByIformIDAndItenantId(form_id, tenantid)
                .orElseThrow(() -> {
                    return new NotFoundException("Form not found by form id "+form_id, webuser, form_id.toString());
                });
    }

    public FormMaster save(FormMaster formMaster)
    {
        return formMasterRepository.save(formMaster);
    }
}
