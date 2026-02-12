package com.DronaPay.UIServer.service.RepositoryService.sim;

import com.DronaPay.UIServer.model.sim.Runs;
import com.DronaPay.UIServer.model.sim.Simulations;

import java.util.List;

public interface RunsService {
    public List<Runs> findAll(Integer tenantid) throws Exception;
}
