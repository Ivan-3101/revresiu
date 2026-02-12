package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.model.BatchJob;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BatchJobResponseWithUsername {

    private BatchJob job;
    private String username;
}
