package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.FormMaster;
import com.DronaPay.UIServer.response.FormMasterDTO;
import org.springframework.stereotype.Component;

import java.util.function.Function;

@Component
public class FormMasterDTOMapper implements Function<FormMaster, FormMasterDTO> {

    @Override
    public FormMasterDTO apply(FormMaster formMaster) {
        return FormMasterDTO.builder()
                .iFormID(formMaster.getIformID())
                .vcFormName(formMaster.getVcFormName())
                .formattingJson(formMaster.getFormattingJson())
                .inputJson(formMaster.getInputJson())
                .displayName(formMaster.getVcDisplayName())
                .build();
    }
}
