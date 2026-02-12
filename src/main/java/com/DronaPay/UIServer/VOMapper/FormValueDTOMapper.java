package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.FormMaster;
import com.DronaPay.UIServer.model.FormValue;
import com.DronaPay.UIServer.response.FormMasterDTO;
import com.DronaPay.UIServer.response.FormValueDTO;
import com.DronaPay.UIServer.service.RepositoryService.FormMasterService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.function.Function;

@Component
public class FormValueDTOMapper implements Function<FormValue, FormValueDTO> {

    @Autowired
    private FormMasterDTOMapper formMasterDTOMapper;

    @Autowired
    private FormMasterService formMasterService;

    @Override
    public FormValueDTO apply(FormValue form_value) {
        return FormValueDTO.builder()
                .iFormValueID(form_value.getIvalueID())
                .valueJson(form_value.getValuesJson())
                .formMaster(formMasterDTOMapper.apply(formMasterService.findByID(form_value.getIFormID(), null, form_value.getItenantId())))
                .build();
    }
}
