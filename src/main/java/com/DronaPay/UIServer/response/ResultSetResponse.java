package com.DronaPay.UIServer.response;

public record ResultSetResponse(String message,
                                Object data,
                                Boolean convertToJson,
                                Boolean transposeRequired,
                                String Status,
                                Long executionID,
                                Integer iuserid,
                                Integer iorgid
) {


}
