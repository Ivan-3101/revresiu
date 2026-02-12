package com.DronaPay.UIServer.ResponseVO;

import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.response.MenuPermissions;
import lombok.Data;

@Data
public class UserAndPermissions {

    private WebUser user;
    private MenuPermissions permissions;
}
