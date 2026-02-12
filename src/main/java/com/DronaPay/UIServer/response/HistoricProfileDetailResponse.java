package com.DronaPay.UIServer.response;


import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class HistoricProfileDetailResponse {
    
    private String vcpath;
    private String vccolumnname;
    private String vcdescription;
    private String vcdtype;
    private Boolean bscore;
    private Boolean bml;
    private Boolean bui;
    private String vcpythonfunction;
    private Boolean bpayer;
    private Boolean bpayee;
    
}
