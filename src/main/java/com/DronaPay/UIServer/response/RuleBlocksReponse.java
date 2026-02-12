package com.DronaPay.UIServer.response;


import java.util.List;
import lombok.Data;

@Data
public class RuleBlocksReponse {
    
    private List<MetadataResponse> metadata;
    private List<String> observations;

}
