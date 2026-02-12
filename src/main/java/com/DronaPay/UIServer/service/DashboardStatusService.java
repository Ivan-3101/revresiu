package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.response.ResultSetResponse;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;

public interface DashboardStatusService {


    public ResultSetResponse updateStatus(Long executionId, ResultSetResponse status );

    public ResultSetResponse getStatus(Long executionId);

    public void clearStatus(Long executionId);
}
