package com.DronaPay.UIServer.response;

import java.util.Date;

public record BatchJobResponse(String jobStatus, Date createdTimeStamp, Date startedTimeStamp, Date endTimeStamp,
        Integer totalRecords, Integer passedRecords, Integer failedRecords) {

}
