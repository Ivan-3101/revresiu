package com.DronaPay.UIServer.controller.Dashboards;

import com.DronaPay.UIServer.requests.DashboardRequest;
import com.DronaPay.UIServer.service.ControllerService.Dashboards.DashboardControllerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/dashboards")
public class DashboardController {

    @Autowired
    private DashboardControllerService dashboardControllerService;

    @GetMapping("/{dashboardname}")
    public ResponseEntity<?> getTransactionClasses(@PathVariable("dashboardname") String dashboardName, Authentication pr) {
        return dashboardControllerService.getTransactionClasses(dashboardName, pr);
    }

//    @PostMapping("/get-data")
//    public ResponseEntity<?> queryForDashboard(@RequestBody DashboardRequest dashboardRequest, Authentication pr) {
//        return dashboardControllerService.queryForDashboard(dashboardRequest, pr);
//    }

    @GetMapping("/get-vpa-dropdown/{type}")
    public ResponseEntity<?> getVpaDropdown(@PathVariable(name = "type") String type, Authentication pr) {
        return dashboardControllerService.getVpaDropdown(type, pr);
    }

    @GetMapping("/get-id-dropdown")
    public ResponseEntity<?> getIDDropdown(Authentication pr) {
        return dashboardControllerService.getIDDropdown(pr);
    }

    @GetMapping("/get-score-dropdown")
    public ResponseEntity<?> getScoreDropdown(Authentication pr) {
        return dashboardControllerService.getScoreDropdown(pr);
    }


}
