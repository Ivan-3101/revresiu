package com.DronaPay.UIServer.requests;


import lombok.Data;
import org.springframework.util.LinkedMultiValueMap;

import java.util.Map;

@Data
public class APICall {
    private String type;
    private String baseURL;
    private String path;
    private LinkedMultiValueMap headers;
    private Map<String, Object> body;
}
