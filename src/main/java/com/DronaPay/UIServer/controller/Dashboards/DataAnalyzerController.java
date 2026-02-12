package com.DronaPay.UIServer.controller.Dashboards;

import com.DronaPay.UIServer.requests.DashboardFilterOptionRequest;
import com.DronaPay.UIServer.requests.DashboardQueryRequestGt;
import com.DronaPay.UIServer.requests.ResultSetLayoutRequest;
import com.DronaPay.UIServer.response.ResultSetResponse;
import com.DronaPay.UIServer.service.ControllerService.Dashboards.DataAnalyzerControllerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;
import java.util.concurrent.Executors;


@RestController
@RequestMapping("/api/v1/generic-dashboard")
public class DataAnalyzerController {

    @Autowired
    private DataAnalyzerControllerService dataAnalyzerControllerService;

    @GetMapping("/get-transaction-classes/{menuname}/tenant-id/{tenantid}")
    public ResponseEntity<?> getTransactionClasses(@PathVariable("menuname") String menuname, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return dataAnalyzerControllerService.getTransactionClasses(menuname, tenantid, pr);
    }


    @GetMapping("/{menuname}/tenant-id/{tenantid}")
    public ResponseEntity<?> getDashboardDropdown(@PathVariable("menuname") String menuName,
                                                  @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return dataAnalyzerControllerService.getDashboardDropdown(menuName, tenantid, pr);
    }

    @GetMapping("/get-filters/{dashboardname}/tenant-id/{tenantid}")
    public ResponseEntity<?> getDashboardFilters(@PathVariable("dashboardname") String dashboardname, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return dataAnalyzerControllerService.getFilters(dashboardname, tenantid, pr);
    }

    @GetMapping("/get-resultset/{dashboardname}/tenant-id/{tenantid}")
    public ResponseEntity<?> getDashboard(@PathVariable("dashboardname") String dashboardname, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        System.out.println(dashboardname);
        return dataAnalyzerControllerService.getDashboardResultSet(dashboardname, tenantid, pr);
    }

    @PostMapping("/get-filter-options")
    public ResponseEntity<?> getFilterOptions(@RequestBody DashboardFilterOptionRequest dashboardQueryRequest, Authentication pr) {
        return dataAnalyzerControllerService.getFilterOptions(dashboardQueryRequest, pr);
    }

    @PostMapping("/get-result-set-data/tenant-id/{tenantid}")
    public ResponseEntity<?> getResultSetData(@RequestBody DashboardQueryRequestGt dashboardQueryRequest, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return dataAnalyzerControllerService.getResultSetData(dashboardQueryRequest, tenantid, pr);
    }

    @PostMapping("/get-result-set-data/tenant-id/{tenantid}/start")
    public ResponseEntity<?> getResultSetDataStart(@RequestBody DashboardQueryRequestGt dashboardQueryRequest, @PathVariable("tenantid") Integer tenantid, Authentication pr) {
        return dataAnalyzerControllerService.getResultSetDataStart(dashboardQueryRequest, tenantid, pr);
    }


    @GetMapping("/get-result-set/{tenant-id}/{resultsetarray}")
    public ResponseEntity<?> getResultSetByArray(@PathVariable("resultsetarray") List<Integer> resultsetarray, @PathVariable("tenant-id") Integer tenantid, Authentication pr) {
        return dataAnalyzerControllerService.getResultSetByArray(resultsetarray, pr, tenantid);
    }

    @PostMapping("/set-resultset")
    public ResponseEntity<?> setResultset(@RequestBody ResultSetLayoutRequest resultSetLayoutRequest, Authentication pr) {
        return dataAnalyzerControllerService.setResultSet(resultSetLayoutRequest, pr);
    }


    @GetMapping(value = "/get-result-set-data/tenant-id/{tenantid}/{executionid}/status", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter streamExecutionStatus(@PathVariable Integer tenantid, @PathVariable Long executionid, Authentication pr) {

        return  dataAnalyzerControllerService.streamExecutionStatus(tenantid, executionid, pr);

    }

    @GetMapping(value = "/get-result-set-data/tenant-id/{tenantid}/{executionid}/result")
    public ResponseEntity<ResultSetResponse> streamExecutionResult(@PathVariable Integer tenantid, @PathVariable Long executionid, Authentication pr) {

        return  dataAnalyzerControllerService.streamExecutionResult(tenantid, executionid, pr);

    }

}
