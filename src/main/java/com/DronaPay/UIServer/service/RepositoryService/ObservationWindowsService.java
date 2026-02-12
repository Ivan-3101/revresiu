package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.model.ObservationWindows;

public interface ObservationWindowsService {
    
    public List<ObservationWindows> findAllNonDeleted() throws  Exception;

    public List<ObservationWindows> findAllNonDeletedTenant(List<Integer> tenants) throws Exception;

    public ObservationWindows saveObservationWindows(ObservationWindows observationWindows) throws Exception;

    public ObservationWindows findByWId(Integer wid, Integer tenantid) throws Exception;

    public Integer findMaxId() throws Exception;

    public ObservationWindows findByWidowName(String name, Integer tenantid) throws Exception;
}
