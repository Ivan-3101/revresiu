package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.ArrayList;

@NotNull
@Data
public class UploadChargeBackRequest {

    @NotNull
    @NotEmpty(message = "date Cannot be Empty")
    private String date;

    @NotNull
    @NotEmpty(message = "Due Date Cannot be Empty")
    private String dueDate;

    @NotNull
    @NotEmpty(message = "AdjType Cannot be Empty")
    private String adjType;

    @NotNull
    @NotEmpty(message = "Reason Code Cannot be Empty")
    private String reasonCode;

    @NotNull
    @NotEmpty(message = "Descriptor Cannot be Empty")
    private String description;

    @NotNull
    @NotEmpty(message = "Aggregator Code Cannot be Empty")
    private String aggregatorCode;

    @NotNull
    @NotEmpty(message = "Merchant ID Cannot be Empty")
    private String merchantId;

    @NotNull
    @NotEmpty(message = "REFID Cannot be Empty")
    private String REFID;

    @NotNull
    @NotEmpty(message = "transaction date Cannot be Empty")
    private String transactionDate;

    @NotNull
    @NotEmpty(message = "payer name Cannot be Empty")
    private String payerName;

    @NotNull
    @NotEmpty(message = "amount Cannot be Empty")
    private String amount;

    @NotNull
    @NotEmpty(message = "Debit NBIN Cannot be Empty")
    private String debitNbin;

    @NotNull
    @NotEmpty(message = "transaction id Cannot be Empty")
    private String transactionId;

    @NotNull
    @NotEmpty(message = "Order Id Cannot be Empty")
    private String nvlTsdkOrderId;

    private ArrayList<String> errorMsg;

    private String passed;

}
