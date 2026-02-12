package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.FormMaster;
import com.DronaPay.UIServer.model.WebUser;

public interface FormMasterService {

    public FormMaster findByFormName(String form_name, WebUser webuser, Integer tenantid);

    public FormMaster findByID(Integer form_ids, WebUser webuser, Integer tenantid);

    public FormMaster save(FormMaster formMaster);
}
