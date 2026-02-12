package com.DronaPay.UIServer.requests;

import lombok.Data;

@Data
public class AddNewCustomTransactionClassRequest {
    
    private String transactionIdentifier;
    private int defaultDecisionId;    
    private Integer productId;
    private Boolean payer;
    private Boolean payee;
    private Integer channelID;
    private String makerRemark;
}
