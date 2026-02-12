package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import lombok.Builder;
import lombok.Data;

import java.util.List;
@Data
public class DropDownWitnAccessControl {

    private Object dropDownOptions;
    private  Boolean view;
    private Boolean add;
    private Boolean delete;
    private Boolean edit;
    private Boolean approve;
}
