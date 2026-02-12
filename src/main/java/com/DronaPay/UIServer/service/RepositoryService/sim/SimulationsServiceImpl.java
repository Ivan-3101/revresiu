package com.DronaPay.UIServer.service.RepositoryService.sim;

import com.DronaPay.UIServer.model.sim.Simulations;
import com.DronaPay.UIServer.repository.sim.SimulationsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SimulationsServiceImpl implements SimulationsService{


    @Autowired
    private SimulationsRepository simulationsRepository;


    public List<Simulations> findAll(Integer tenantid) throws Exception
    {
        return simulationsRepository.findAllByItenantId(tenantid);
    }

    public Optional<Simulations> findBySimid(String simid, Integer itenantid) throws Exception
    {
        return simulationsRepository.findBySimidAndItenantId(simid, itenantid);
    }
}
