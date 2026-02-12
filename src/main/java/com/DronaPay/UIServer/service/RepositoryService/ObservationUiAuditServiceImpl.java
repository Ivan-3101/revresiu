package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ObservationUiAudit;
import com.DronaPay.UIServer.repository.ObservationsUiAuditRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ObservationUiAuditServiceImpl implements ObservationUiAuditService {

    @Autowired
    private ObservationsUiAuditRepository observationsUiAuditRepository;

    @Override
    public List<ObservationUiAudit> findAllPendingEntries() throws Exception {
        //return observationsUiAuditRepository.findAllPendingEntries();
        return observationsUiAuditRepository.findByIstatusIsNullAndBclosedFalse();
    }

    @Override
    public ObservationUiAudit saveObservationUiAudit(ObservationUiAudit observationUiAudit) throws Exception {
        return observationsUiAuditRepository.save(observationUiAudit);
    }

    @Override
    public ObservationUiAudit findByObservationUiAduitId(Integer oAuditId,Integer tenantId) throws Exception {

        //return observationsUiAuditRepository.findAllPendingEntriesById(oAuditId);
        return observationsUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndOauditIdAndItenantId(oAuditId,tenantId);
    }

    @Override
    public ObservationUiAudit findByOId(Integer oId, Integer wid, Integer tenantid) throws Exception {
        //return observationsUiAuditRepository.findAllPendingEntriesByOId(oId);
        return observationsUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndOidAndItenantId(oId,tenantid);
    }

    @Override
    public ObservationUiAudit findByOnameAndItenantId(String wName, Integer tenantId) throws Exception {
        //return observationsUiAuditRepository.findAllPendingEntriesByName(wName);
        return observationsUiAuditRepository.findByIstatusIsNullAndBclosedFalseAndOnameAndItenantId(wName, tenantId);
    }

    @Override
    public Integer findMaxIdPending() throws Exception {
        //return observationsUiAuditRepository.findMaxIdOfPendingEntry();
        ObservationUiAudit top = observationsUiAuditRepository.findTopByIstatusIsNullAndBclosedFalseOrderByOidDesc();
        return (top != null ? top.getOid() : null);
    }

    @Override
    public List<ObservationUiAudit> findAllPendingEntriesTenant(List<Integer> tennats) throws Exception {
        return observationsUiAuditRepository.findAllByItenantIdInAndIstatusIsNullAndBclosedFalse(tennats);
    }

}
