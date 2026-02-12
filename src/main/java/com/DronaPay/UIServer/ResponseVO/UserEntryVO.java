package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class UserEntryVO {
    private Integer userid;
    private String vcusername;
}
