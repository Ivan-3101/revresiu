package com.DronaPay.UIServer.service.ControllerService.Dashboards;

import com.DronaPay.UIServer.requests.DashboardRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;


public interface DashboardControllerService {

    public ResponseEntity<?> getTransactionClasses(String dashboardName, Authentication pr);

//    public ResponseEntity<?> queryForDashboard(DashboardRequest dashboardRequest, Authentication pr);

    public ResponseEntity<?> getVpaDropdown(String type, Authentication pr);

    public ResponseEntity<?> getIDDropdown(Authentication pr);

    public ResponseEntity<?> getScoreDropdown(Authentication pr);
}
