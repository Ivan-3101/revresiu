package com.DronaPay.UIServer.response;

import lombok.Data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Data
public class AccountWiseResponse {
    
    private String account;
    private List<Map<String, String>> ticketList;
    private Integer count;
    private Integer itenantId;
}
