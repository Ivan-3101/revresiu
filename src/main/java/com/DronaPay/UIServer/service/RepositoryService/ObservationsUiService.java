package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;
import java.util.Optional;

import com.DronaPay.UIServer.model.ObservationsUi;

public interface ObservationsUiService {
    
    public List<ObservationsUi> findAllNonDeleted() throws Exception;

    public ObservationsUi saveObservations(ObservationsUi observationsUi) throws Exception;

    public ObservationsUi findByObservationId(Integer oId, Integer wid, Integer tenantid) throws Exception;
    
    public List<ObservationsUi> findByWid(Integer wId, Integer tenantid) throws Exception;

    public Integer findMaxId() throws Exception;

    public ObservationsUi findByObservationName(String name) throws Exception;

    public List<ObservationsUi> findAllNonDeletedTenants(List<Integer> tenants) throws Exception;

    Optional<ObservationsUi> findByOnameAndItenantId(String oname, Integer itenantid) throws Exception;

}
