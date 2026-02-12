package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.SectionParameters;

import java.util.List;

public interface SectionParametersService {

    public List<SectionParameters> findBySummaryName(String summaryname,Integer tenantid) throws Exception;

    
}
