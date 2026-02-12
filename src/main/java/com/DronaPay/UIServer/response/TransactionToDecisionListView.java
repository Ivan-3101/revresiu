package com.DronaPay.UIServer.response;

import lombok.Data;

import java.util.List;

@Data
public class TransactionToDecisionListView {

    private List<CustomTransactionResponse> transactionClass;
    private Boolean view;
    private Boolean delete;
    private Boolean add;
    private Boolean edit;
    private Boolean approve;
    private Boolean publish;

}
