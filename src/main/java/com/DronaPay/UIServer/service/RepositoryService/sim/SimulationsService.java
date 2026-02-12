package com.DronaPay.UIServer.service.RepositoryService.sim;

import com.DronaPay.UIServer.model.sim.Simulations;

import java.util.List;
import java.util.Optional;

public interface SimulationsService {

    public List<Simulations> findAll(Integer tenantid) throws Exception;

    public Optional<Simulations> findBySimid(String simid, Integer tenantid) throws Exception;

}
