package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.FormValue;
import com.DronaPay.UIServer.model.WebUser;

public interface FormValueService {

    public FormValue save(FormValue formValue);

    public FormValue findByID(Integer form_value_id, WebUser webuser, Integer tenantid);

}
