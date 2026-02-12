package com.DronaPay.UIServer.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.ZonedDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PreviousChatResponse {
    private Boolean bAgentMsg;
    private String message;
    private ZonedDateTime timestamp;
}
