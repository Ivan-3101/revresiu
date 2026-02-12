package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.FormValue;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.repository.FormValueRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FormValueServiceImpl implements FormValueService {

    @Autowired
    private FormValueRepository formValueRepository;

    @Transactional
    public FormValue save(FormValue formValue) {
        return formValueRepository.save(formValue);
    }

    public FormValue findByID(Integer form_value_id, WebUser webuser, Integer tenantid) {
        return formValueRepository.findByIvalueIDAndItenantId(form_value_id, tenantid).orElseThrow(() -> {
            return new NotFoundException("Form not found by form id " + form_value_id, webuser, form_value_id.toString());
        });
    }
}
