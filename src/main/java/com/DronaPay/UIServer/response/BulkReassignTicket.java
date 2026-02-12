package com.DronaPay.UIServer.response;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class BulkReassignTicket {
    private Long ticketId;
    private String error;
}
