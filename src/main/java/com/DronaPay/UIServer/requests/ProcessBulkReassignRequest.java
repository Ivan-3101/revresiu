package com.DronaPay.UIServer.requests;

import java.util.List;

import com.DronaPay.UIServer.requests.ProcessBulkReassignRequest.TaskProcessMap;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NotNull
@Getter
@NoArgsConstructor
public class ProcessBulkReassignRequest {

    private String currentAssignee;
    private String newAssignee;
    private String comments;
    private List<TaskProcessMap> tasks;

    @Getter
    public static class TaskProcessMap {
        private String taskid;
        private String processId;
        private Long ticketId;
    }

}
