package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ObservationMeta {
    private String name;
    private String description;
}
