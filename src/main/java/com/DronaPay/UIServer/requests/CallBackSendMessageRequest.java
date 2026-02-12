package com.DronaPay.UIServer.requests;

import lombok.Getter;

@Getter
public class CallBackSendMessageRequest {

    private Integer template_id;
    private String correlation_key;
    private String subject;
    private String body;

}
