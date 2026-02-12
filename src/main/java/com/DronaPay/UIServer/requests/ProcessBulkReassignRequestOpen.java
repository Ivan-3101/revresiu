package com.DronaPay.UIServer.requests;


import jakarta.validation.constraints.*;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NotNull
@Getter
@NoArgsConstructor
public class ProcessBulkReassignRequestOpen {

    private String currentAssignee;
    private String loggedInUser;
    private String newAssignee;
    private String comments;
    private String taskid;
    private String processId;
    private Long ticketId;

}