package com.DronaPay.UIServer.service.ControllerService.Dashboards;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.model.DashboardFilters;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.DashboardFilterOptionRequest;
import com.DronaPay.UIServer.requests.DashboardQueryRequest;
import com.DronaPay.UIServer.requests.DashboardQueryRequestGt;
import com.DronaPay.UIServer.requests.ResultSetLayoutRequest;
import com.DronaPay.UIServer.response.DashboardFiltersResponse;
import com.DronaPay.UIServer.response.ResultSetResponse;
import com.DronaPay.UIServer.util.UserMapping;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

public interface DataAnalyzerControllerService {

    public ResponseEntity<?> getTransactionClasses(String menuname, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getDashboardDropdown(String menuname, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getFilters(String dashboardname, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getDashboardResultSet(String dashboardname, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getFilterOptions(DashboardFilterOptionRequest dashboardQueryRequest, Authentication pr);

    public ResponseEntity<?> getResultSetData(DashboardQueryRequestGt dashboardQueryRequest, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getResultSetDataStart(DashboardQueryRequestGt dashboardQueryRequest, Integer tenantid, Authentication pr);

    public ResponseEntity<?> getResultSetDataService(DashboardQueryRequest dashboardQueryRequest);

    public ResponseEntity<?> setResultSet(ResultSetLayoutRequest resultSetLayoutRequest, Authentication pr);

    public ResponseEntity<?> getResultSetByArray(List<Integer> resultsetarray, Authentication pr, Integer itenentid);

    public LinkedHashMap<String, DashboardFiltersResponse> parseFromFilters(ArrayList<DashboardFilters> dashboardFiltersList, WebUser user, Integer tenantid) throws Exception;

    public HashMap<String, DashboardFiltersResponse> getFiltersService(Integer dashboardid, WebUser user, Integer tenantid) throws Exception;

    public SseEmitter streamExecutionStatus(Integer tenantid, Long executionid, Authentication pr);

    public ResponseEntity<ResultSetResponse> streamExecutionResult(Integer tenantid, Long executionid, Authentication pr);


}

