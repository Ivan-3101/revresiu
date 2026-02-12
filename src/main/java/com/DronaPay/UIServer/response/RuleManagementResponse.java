package com.DronaPay.UIServer.response;

import lombok.Data;

import java.util.List;

@Data
public class RuleManagementResponse {
    private Boolean view;
    private Boolean add;
    private List<com.DronaPay.UIServer.ResponseVO.RuleManagementVO> RuleManagementVO;
}
