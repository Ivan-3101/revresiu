package com.DronaPay.UIServer.response;


import java.util.List;
import lombok.Data;

@Data
public class MetadataObservationsResponse {
    
    private List<MetadataResponse> metadata;
    private List<ObservationMeta> observations;

}
