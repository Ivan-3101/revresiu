package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ListDropDownVO {


    private String label;
    private String value;
    private String scorePath;
    private String validation;

}
