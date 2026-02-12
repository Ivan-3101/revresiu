package com.DronaPay.UIServer.response;

import lombok.Data;
import java.util.List;

import com.DronaPay.UIServer.ResponseVO.TenantManagementVO;

@Data
public class TenantManagementResponse {
    private Boolean view;
    private Boolean add;
    private Boolean edit;
    private Boolean delete;
    private Boolean approve;
    private List<TenantManagementVO> tenantManagementVO;
}
