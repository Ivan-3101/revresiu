package com.DronaPay.UIServer.service.RepositoryService.sim;

import com.DronaPay.UIServer.model.sim.Runs;
import com.DronaPay.UIServer.repository.sim.RunsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RunsServiceImpl implements RunsService{

    @Autowired
    private RunsRepository runsRepository;


    public List<Runs> findAll(Integer tenantid) throws Exception
    {
        return runsRepository.findAllByItenantId(tenantid);
    }
}
