package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.ResponseVO.ListManagementVO;
import lombok.Data;

import java.util.List;

@Data
public class ListManagementResponse {
    private Boolean view;
    private Boolean add;
    private Boolean edit;
    private Boolean delete;
    private Boolean approve;
    private Boolean publish;
    private List<ListManagementVO> listManagementVO;
}
