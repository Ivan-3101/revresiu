package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;

@Builder
@Data
public class MlModelTrainedResponse {
    private String modelName;
    private String description;
    private Double latestVersion;
    private String modelStatus;
    private ZonedDateTime lastUpdate;
    private ZonedDateTime createdDate;
    private Integer itenantId;
    private String tenantName;

}
