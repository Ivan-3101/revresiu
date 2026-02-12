package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.ResponseVO.DropDownVo;
import lombok.Data;

import java.util.List;

@Data
public class AllocationMapperResponse {
    private Boolean view;
    private Boolean add;
    private Boolean edit;
    private Boolean delete;
    private Boolean approve;
    // private List<DropDownVo> listWorkflow;
    private List<DropDownVo> listGroups;
}
