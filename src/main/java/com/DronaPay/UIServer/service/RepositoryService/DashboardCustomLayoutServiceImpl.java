package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.VOMapper.DashboardCustomLayoutVoMapper;
import com.DronaPay.UIServer.model.DashboardCustomLayout;
import com.DronaPay.UIServer.repository.DashboardCustomLayoutRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class DashboardCustomLayoutServiceImpl implements DashboardCustomLayoutService {

    @Autowired
    private DashboardCustomLayoutRepository dashboardCustomLayoutRepository;

    @Autowired
    private DashboardCustomLayoutAuditService dashboardCustomLayoutAuditService;

    public DashboardCustomLayout findDefaultLayoutByIResultSetID(Integer iResultSetID, Integer iUserID,
            Integer itenantid) throws Exception {
        DashboardCustomLayout cust = dashboardCustomLayoutRepository
                .findByBactiveTrueAndBdeleteFalseAndBdefaultTrueAndIresultSetIDAndIuserIDAndItenantId(
                        iResultSetID, iUserID, itenantid)
                .orElse(null);
        if (cust == null) {
            cust = dashboardCustomLayoutRepository
                    .findByBactiveTrueAndBdeleteFalseAndBdefaultTrueAndIresultSetIDAndIuserIDIsNullAndItenantId(
                            iResultSetID, itenantid)
                    .orElse(null);
        }
        return cust;
    }

    public DashboardCustomLayout findLayoutByIResultSetID(Integer iResultSetID, Integer iUserID, Integer tenantId)
            throws Exception {
        return dashboardCustomLayoutRepository
                .findByBactiveTrueAndBdeleteFalseAndIresultSetIDAndIuserIDAndItenantId(
                        iResultSetID, iUserID, tenantId)
                .orElse(null);
    }

    public DashboardCustomLayout findDefaultLayoutByIResultSetIDUser(Integer iResultSetID, Integer iUserID,
            Integer tenantId) throws Exception {
        return dashboardCustomLayoutRepository
                .findByBactiveTrueAndBdeleteFalseAndBdefaultTrueAndIresultSetIDAndIuserIDAndItenantId(
                        iResultSetID, iUserID, tenantId)
                .orElse(null);
    }

    @Transactional
    public DashboardCustomLayout save(DashboardCustomLayout al) throws Exception {
        DashboardCustomLayout temp = dashboardCustomLayoutRepository.save(al);
        dashboardCustomLayoutAuditService.save(DashboardCustomLayoutVoMapper.parse(temp));
        return temp;
    }

    @Transactional
    public void removeDefaultByResultSetID(Integer iResultSetID, Integer itenentid) throws Exception {
        // dashboardCustomLayoutRepository.removeDefaultByResultSetID(iResultSetID);
        List<DashboardCustomLayout> dashboardList = dashboardCustomLayoutRepository
                .findByIresultSetIDAndItenantId(iResultSetID, itenentid);
        // dashboardList.stream().map(x ->
        // {x.withBactive(false)}).collect(Collectors.toList());
        List<DashboardCustomLayout> updatedList = dashboardList.stream().map(x -> {
            x.setBdefault(false);
            return x;
        }).collect(Collectors.toList());
        dashboardCustomLayoutRepository.saveAll(updatedList);
    }
}
