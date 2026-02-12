package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.ObservationWindowsAudit;
import com.DronaPay.UIServer.repository.ObservationsWindowUiAuditRepository;

@Service
public class ObservationWindowsAuditServiceImpl implements  ObservationWindowsAuditService{

    @Autowired
    private ObservationsWindowUiAuditRepository observationsWindowUiAuditRepository;

    @Override
    public List<ObservationWindowsAudit> findAllPendingEntries() throws Exception {
        //return observationsWindowUiAuditRepository.findAllPendingEntries();
        return observationsWindowUiAuditRepository.findByIstatusIsNullAndBclosedFalse();
    }

    @Override
    public List<ObservationWindowsAudit> findAllPendingEntriesTenant(List<Integer> tenants) throws Exception {
        return observationsWindowUiAuditRepository.findAllByItenantIdInAndIstatusIsNullAndBclosedFalse(tenants);
    }

    @Override
    public ObservationWindowsAudit saveObservationWindowAudit(ObservationWindowsAudit observationWindowsAudit)
            throws Exception {
        return observationsWindowUiAuditRepository.save(observationWindowsAudit);
    }

    @Override
    public ObservationWindowsAudit findByWAuditId(Integer wAuditId,Integer tenantId) throws Exception {
        //return observationsWindowUiAuditRepository.findPendingEntriesById(wAuditId);
        return observationsWindowUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndWauditIdAndItenantId(wAuditId,tenantId);
    }

    @Override
    public ObservationWindowsAudit findbyWId(Integer wId,Integer tenantId) throws Exception {
        //return observationsWindowUiAuditRepository.findPendingEntriesByWId(wId);
        return observationsWindowUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndWidAndItenantId(wId,tenantId);
    }

    @Override
    public ObservationWindowsAudit findBywName(String wNme,Integer tenantid) throws Exception {
        //return observationsWindowUiAuditRepository.findPendingEntriesByName(wNme);
        return observationsWindowUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndWnameAndItenantId(wNme,tenantid);
    }

    @Override
    public Integer findMaxId() throws Exception {
       //return observationsWindowUiAuditRepository.findmaxIdOfPending();
       ObservationWindowsAudit top = observationsWindowUiAuditRepository.findTopByIstatusIsNullAndBclosedFalseOrderByWidDesc();
       return (top != null ? top.getWid() : null);
    }
    
}
