package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.exception.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.Dashboard;
import com.DronaPay.UIServer.repository.DashboardRepository;

@Service
public class DashboardServiceImpl implements DashboardService {

    @Autowired
    public DashboardRepository dashboardRepository;

    private Dashboard findMatchingDB(List<Dashboard> allDash, Integer tenantid) {
        boolean tenantFound = false;
        Dashboard reportFound = null;
        ///// check if report is found that matches the given tenantid
        for (Dashboard rep : allDash) {
            if (rep.getItenantId() != null && rep.getItenantId().equals(tenantid)) {
                tenantFound = true;
                reportFound = rep;
                break;
            }
        }
        //// if no report found with tenantid, then check if null tenantid report is
        //// present
        if (!tenantFound) {
            for (Dashboard rep : allDash) {
                if (rep.getItenantId() == null) {
                    tenantFound = true;
                    reportFound = rep;
                    break;
                }
            }
        }
        return reportFound;
    }

    public List<Dashboard> findAllActiveAndNotDeleted(Integer tenantid) throws Exception {
        return dashboardRepository.findByItenantIdAndBactiveTrueAndBdeleteFalseAndBdynamicTrueOrderByIorderAsc(tenantid);

    }

    // public List<Dashboard> findAllActiveAndNotDeletedAndIMenuID(Integer imenu)
    // throws Exception {
    // return
    // dashboardRepository.findByImenuStructureDesc_iMenuIDAndBactiveTrueAndBdeleteFalseOrderByIorderAsc(imenu);
    // }

    public List<Dashboard> findAllActiveAndNotDeletedAndIMenuID(Integer imenu, Integer tenantid) throws Exception {
       return dashboardRepository
                .findByImenuStructureDesc_iMenuIDAndItenantIdAndBactiveTrueAndBdeleteFalseAndBdynamicTrueOrderByIorderAsc(imenu,tenantid);
                
       
    }

    @Override
    public Dashboard findByNameTenant(String dashboardname, Integer tenantid) {
        return dashboardRepository.findByVcDashboardNameAndItenantId(dashboardname, tenantid)
                .orElseThrow(() -> new NotFoundException("Failed to find Dashboard with dashboard name "+dashboardname, "dashboardname : "+ dashboardname +", itenantid : "+tenantid));

    }

    @Override
    public Dashboard findById(Integer iDashboardID,Integer tenantId) {
        return dashboardRepository.findByiDashboardIDAndItenantId(iDashboardID, tenantId);
    }

    @Override
    public List<Dashboard> findAllByIds(List<Integer> dashboardIds, Integer tenantid){
        return dashboardRepository.findAllByiDashboardIDInAndItenantId(dashboardIds, tenantid);
    }
}
