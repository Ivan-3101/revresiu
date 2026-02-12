package com.DronaPay.UIServer.ResponseVO;

import lombok.Data;

import java.time.ZonedDateTime;

@Data
public class ListVO {
    private Integer listItemId;
    private Integer auditId;
    private String externalId;
    private String source;
    private String listType;
    private String itemField;
    private String itemValue;
    private ZonedDateTime effectiveFrom;
    private ZonedDateTime expiresAt;
    private String note;
    private Integer record_Status;
}
