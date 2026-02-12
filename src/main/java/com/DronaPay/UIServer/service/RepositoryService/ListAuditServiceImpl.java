package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.repository.ListAuditRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.ListAudit;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ListAuditServiceImpl extends ListAuditService {

    @Autowired
    private ListAuditRepository listAuditRepository;

    @Override
    @Transactional
    public ListAudit saveAudit(ListAudit input) {
        // System.out.println("called audir repo");
       return listAuditRepository.save(input);
    }

    @Override
    public List<ListAudit> findPendingEntries() {
        //return listAuditRepository.findAllPendingEntries();
        return listAuditRepository.findByIstatusIsNullAndBclosedFalse();
    }

    @Override
    public List<ListAudit> findPendingEntriesTenants(List<Integer> tenants) {
        return listAuditRepository.findAllByIstatusIsNullAndBclosedFalseAndIlistType_Id_ItenantId_ItenantidIn(tenants);
    }

    @Override
    public ListAudit findByExternalId(String externalID, Integer tenantid) throws Exception {
        return listAuditRepository.findByVcExternalListItemIdAndIlistType_Id_ItenantId_ItenantidAndIstatusIsNullAndBclosedFalse(externalID, tenantid);
    }

    // public ListAudit findById(Integer ilistid) throws Exception {
    //     return listAuditRepository.findById(ilistid).orElse(null);
    // }

    public ListAudit findById(Integer ilistid,Integer tenantId) throws Exception {
        return listAuditRepository.findByiListItemAuditIdAndIlistType_Id_ItenantId_ItenantidAndIstatusIsNullAndBclosedFalse(ilistid, tenantId);
    }
    
}
