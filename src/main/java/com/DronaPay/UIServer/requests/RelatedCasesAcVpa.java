package com.DronaPay.UIServer.requests;

import lombok.Getter;

@Getter
public class RelatedCasesAcVpa {
    private String payerVpa;
    private String payeeVpa;
    private String payerAccount;
    private String payeeAccount;
    private Long ticketID;
    private Integer max;
    private Integer days;
}
