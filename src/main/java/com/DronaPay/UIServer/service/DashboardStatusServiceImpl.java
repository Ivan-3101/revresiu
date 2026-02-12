package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.response.ResultSetResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class DashboardStatusServiceImpl implements DashboardStatusService {

    @CachePut(value = "executionStatus", key = "#executionId")
    public ResultSetResponse updateStatus(Long executionId, ResultSetResponse status ) {
        return status;
    }

    @Cacheable(value = "executionStatus", key = "#executionId")
    public ResultSetResponse getStatus(Long executionId) {
        return new ResultSetResponse(null, null, null, null, "NOT_FOUND", executionId, null, null); // default if not found
    }

    @CacheEvict(value = "executionStatus", key = "#executionId")
    public void clearStatus(Long executionId) {
        log.info("Cleaning result from cache for execution id "+executionId);
    }

}
