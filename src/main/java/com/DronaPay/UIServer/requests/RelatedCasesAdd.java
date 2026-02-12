package com.DronaPay.UIServer.requests;

import lombok.Getter;

@Getter
public class RelatedCasesAdd {
    private Long ticketID;
    private String type;
    private String address;
    private Integer days;
    private Integer max;
}
