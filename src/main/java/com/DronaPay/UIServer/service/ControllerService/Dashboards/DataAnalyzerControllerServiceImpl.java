package com.DronaPay.UIServer.service.ControllerService.Dashboards;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.DatabaseType;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DashboardResultSetVO;
import com.DronaPay.UIServer.ResponseVO.DropDownVo;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.VOMapper.DropDownVoMapper;
import com.DronaPay.UIServer.VOMapper.DropdownWithObjectMapper;
import com.DronaPay.UIServer.exception.ForbiddenException;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ControllerService.ListManagement.ListManagementServiceImpl;
import com.DronaPay.UIServer.service.DashboardStatusService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class DataAnalyzerControllerServiceImpl implements DataAnalyzerControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DataAnalyzerControllerServiceImpl.class);
    @Autowired
    public WebUserService webUserService;

    @Autowired
    public ActivityLogService activityLogService;

    @Autowired
    public TransactionClassesUiService transactionClassesUiService;

//    @Qualifier("jdbcAnalyticsService")
//    @Autowired
//    JdbcTemplate jdbcTemplateAnalytics;
//
//    @Qualifier("jdbcTransactionalService")
//    @Autowired
//    JdbcTemplate jdbcTemplateTransactional;

    @Autowired
    private DashboardService dashboardService;
    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private DashboardQueryService dashboardQueryService;

    @Autowired
    private DashboardResultSetService dashboardResultSetService;

    @Autowired
    private DashboardFiltersService dashboardFiltersService;

    @Autowired
    private DashboardCustomLayoutService dashboardCustomLayoutService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private MenuStructureDescService menuStructureDescService;

    @Autowired
    private TransactionClassesUiService transactionClassesService;

    @Autowired
    private DashboardQueryParmeterService dashboardQueryParmeterService;

    @Autowired
    private DashboardErrorUtil dashboardErrorUtil;

    private Map<DatabaseType, JdbcTemplate> jdbcTemplateMap;


    @Autowired
    private JsonConverterUtil jsonConverterUtil;

    @Autowired
    private DashboardQueryExecutor dashboardQueryExecutor;



    @Autowired
    public DataAnalyzerControllerServiceImpl(Map<DatabaseType, JdbcTemplate> jdbcTemplateMap) {
        this.jdbcTemplateMap = jdbcTemplateMap;
    }

    public ResponseEntity<?> getDashboardDropdown(String menuname, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + DataAnalyzerControllerServiceImpl.class + " in method getDashboardDropdown");

        if (menuname.isBlank()) {
            LOGGER.error("Error : " + loggerEncoderUtil.encode(menuname) + "\nParam : " + loggerEncoderUtil.encode(menuname));
            // activityLogService.addActivity("dashboard name is not valid ",
            // menuname.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, menuname),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        LoggedUser temp = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = temp.getWebUser();
        activityLogService.addActivity(loggedInUser, "dashboard dropdown options requested for " + menuname);

        MenuPermissions mp = temp.getPermissions().get(menuname);

        if (mp.isView() && temp.allowTenants(Arrays.asList(tenantid))) {
            try {
                Integer imenuid = menuStructureDescService.findByVcMenuName(menuname, loggedInUser);
                List<DropdownWithObject> responses = DropdownWithObjectMapper
                        .parseDashboardDropdown(
                                dashboardService.findAllActiveAndNotDeletedAndIMenuID(imenuid, tenantid));

                DropDownWitnAccessControl res = new DropDownWitnAccessControl();
                res.setDropDownOptions(responses);
                res.setAdd(mp.isAdd());
                res.setView(mp.isView());
                res.setDelete(mp.isDelete());
                res.setApprove(mp.isApprove());
                res.setEdit(mp.isEdit());

                activityLogService.addActivity(loggedInUser,
                        "Dashboard dropdown accessed successfully for " + MenuNames.dataAnalyzer,
                        "Parameters : " + responses.toString());
                LOGGER.debug("Exiting getDashboardDropdown Method in " + DataAnalyzerControllerServiceImpl.class
                        + " class with response  : Dashboard dropdown accessed");
                return ResponseEntity.ok(res);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access dashboard dropdown list", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access dashboard dropdown ");
            LOGGER.debug("Exiting getDashboardDropdown Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access dashboard dropdown");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access dashboard dropdown"),
                    HttpStatus.FORBIDDEN);
        }
    }

    public HashMap<String, DashboardFiltersResponse> getFiltersService(Integer dashboardid, WebUser user,
                                                                       Integer tenantid) throws Exception {
        ArrayList<DashboardFilters> dashboardFilters = dashboardFiltersService
                .getAllByIDashboardID(dashboardid, tenantid);
        HashMap<String, DashboardFiltersResponse> responses = new HashMap<>();
        responses = parseFromFilters(dashboardFilters, user, tenantid);
        return responses;
    }

    @Override
    public SseEmitter streamExecutionStatus(Integer tenantid, Long executionid, Authentication pr) {
       return dashboardQueryExecutor.streamExecutionStatus(tenantid, executionid, pr);
    }

    public ResponseEntity<?> getFilters(String dashboardname, Integer tenantid, Authentication pr) {
        LOGGER.debug("entered in class " + DataAnalyzerControllerServiceImpl.class + " in method getFilters");
        Dashboard dashboard = dashboardService.findByNameTenant(dashboardname, tenantid);
        LoggedUser temp = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = temp.getWebUser();
        activityLogService.addActivity(loggedInUser,
                "dashboard filters requested for " + dashboard.getImenuStructureDesc().getVcMenuName(),
                "Dashboard name " + dashboardname);
        MenuPermissions mp = temp.getPermissions().get(dashboard.getImenuStructureDesc().getVcMenuName());

        if (mp.isView() && temp.allowTenants(Arrays.asList(tenantid))) {
            try {
                HashMap<String, DashboardFiltersResponse> responses = getFiltersService(dashboard.getIDashboardID(),
                        loggedInUser, tenantid);
                activityLogService.addActivity(loggedInUser,
                        "dashboard filters accessed successfully for " + MenuNames.dataAnalyzer,
                        "Parameters : " + responses.toString());
                LOGGER.debug("Exiting getFilters Method in " + ListManagementServiceImpl.class
                        + " class with response  : filters dropdown accessed successfully");
                return ResponseEntity.ok(responses);
            } catch (Exception e) {
                e.printStackTrace();
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(dashboardname));
                activityLogService.addActivity(loggedInUser, "failed to get filters", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access filters for dashboard ");
            LOGGER.debug("Exiting getDashboardDropdown Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access filters for dashboard ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access filters for dashboard "),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getDashboardResultSet(String dashboardname, Integer tenantid, Authentication pr) {
        LOGGER.debug(
                "entered in class " + DataAnalyzerControllerServiceImpl.class + " in method getDashboardResultSet");

        Dashboard dashboard = dashboardService.findByNameTenant(dashboardname, tenantid);

        LoggedUser temp = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = temp.getWebUser();
        activityLogService.addActivity(loggedInUser,
                "dashboard resultset requested for " + dashboard.getImenuStructureDesc().getVcMenuName(),
                "Dashboard dashboardname " + dashboardname);
        MenuPermissions mp = temp.getPermissions().get(dashboard.getImenuStructureDesc().getVcMenuName());

        if (mp.isView() && temp.allowTenants(Arrays.asList(tenantid))) {
            try {
                DashboardResultSetResponse response = new DashboardResultSetResponse();
                response.setResultSet(parseResultSetFromDashboard(dashboard, loggedInUser, tenantid));
                response.setNumberOfRows(dashboard.getIRowCount());
                activityLogService.addActivity(loggedInUser,
                        "Dashboard Resultset accessed successfully for "
                                + dashboard.getImenuStructureDesc().getVcMenuName(),
                        "Parameters : " + response.toString());
                LOGGER.debug("Exiting getDashboardDropdown Method in " + ListManagementServiceImpl.class
                        + " class with response  : Dashboard Resultset");
                return ResponseEntity.ok(response);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(dashboardname));
                activityLogService.addActivity(loggedInUser, "failed to access dashboard Resultset",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access Dashboard Resultset ");
            LOGGER.debug("Exiting getDashboardDropdown Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to access Dashboard Resultset ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to access Dashboard Resultset "),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getFilterOptions(DashboardFilterOptionRequest dashboardQueryRequest, Authentication pr) {
        LOGGER.debug("entered in class " + DataAnalyzerControllerServiceImpl.class + " in method getFilterOptions");

        DashboardFilters filter = dashboardFiltersService.findById(dashboardQueryRequest.getFilterID(),
                dashboardQueryRequest.getTenantId());

        LoggedUser temp1 = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = temp1.getWebUser();
        activityLogService.addActivity(loggedInUser,
                "dashboard filter dropdown options requested for " + MenuNames.dataAnalyzer,
                dashboardQueryRequest.toString());
        Dashboard dashboard = dashboardService.findById(filter.getIdashboardID(), dashboardQueryRequest.getTenantId());
        MenuPermissions mp = temp1.getPermissions()
                .get(dashboard.getImenuStructureDesc().getVcMenuName());

        if (mp.isView()) {
            String queryString = null;
            DashboardQuery dashboardQuery = dashboardQueryService.findById(filter.getIDashboardQueryIDForOptions(),
                    filter.getItenantId());
            try {

                if (dashboardQuery != null)
                    queryString = dashboardQuery.getVcDashboardQuery();
            } catch (Exception e) {
                LOGGER.error(
                        "Error : " + e + "\nParam : " + loggerEncoderUtil.encode(dashboardQueryRequest.toString()));
                activityLogService.addActivity(loggedInUser, "failed to getdropdown options",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (queryString != null) {

                List<DashboardQueryParameters> listParametersoriginal = new ArrayList<>();
                listParametersoriginal = dashboardQueryParmeterService.findByidAndTenant(dashboardQuery.getIDashboardQueryID(),
                        dashboardQuery.getItenantId());
                ObjectMapper mapper = new ObjectMapper();
                Map<String, Object> map = new HashMap<>();
                MapSqlParameterSource parameters = new MapSqlParameterSource();
                try {
                    map = mapper.readValue(dashboardQueryRequest.getParametersJson(),
                            Map.class);
                    mapper.readTree(queryString);
                    JSONObject jsonTemp = new JSONObject(queryString);
                    HashMap<Integer, DashboardQueryParameters> t = (HashMap<Integer, DashboardQueryParameters>) listParametersoriginal
                            .stream()
                            .filter(c -> c.getVcParameterType().equals("JsonPath"))
                            .collect(
                                    Collectors.toMap(DashboardQueryParameters::getIOrder, Function.identity()));

                    List<DashboardQueryParameters> listParameterjsonpath = new ArrayList<DashboardQueryParameters>(
                            t.values());

                    String path = "";
                    JSONObject js = jsonTemp;
                    for (DashboardQueryParameters item : listParameterjsonpath) {
                        Object temp = new Object();
                        temp = map.get(item.getVcParameterName());
                        if (js.optString((String) temp) != null && js.optString((String) temp) != "") {
                            try {
                                js = js.optJSONObject((String) temp);
                            } catch (ClassCastException e) {
                            }
                            path += "/" + temp;
                        } else {
                            try {
                                js = js.optJSONObject("Other");
                            } catch (ClassCastException e) {
                            }
                            path += "/" + "Other";
                            parameters.addValue(item.getVcParameterName(), temp);

                        }
                    }
                    queryString = (String) jsonTemp.optQuery(path);
                } catch (JsonProcessingException e) {
                }
                List<DashboardQueryParameters> listParameters = listParametersoriginal
                        .stream()
                        .filter(c -> !c.getVcParameterType().equals("JsonPath"))
                        .collect(Collectors.toList());


                if (dashboardQueryRequest.getParametersJson() != null) {


                    for (DashboardQueryParameters item : listParameters) {
                        String temp = null;
                        String parameterName = item.getVcParameterName();
                        switch (item.getVcParameterType()) {
                            case "Integer":

                                parameters.addValue(parameterName,
                                        Integer.parseInt(map.get(parameterName).toString()));
                                break;
                            case "String":


                                parameters.addValue(parameterName, (String) map.get(parameterName));
                                break;
                            case "Boolean":

                                parameters.addValue(parameterName, (Boolean) map.get(parameterName));

                                break;
                            case "TableName":
                                temp = queryString;
                                temp = temp.replace(":" + parameterName, (String) map.get(parameterName));
                                queryString = temp;
                                break;
                        }
                    }
                }

                List<Object[]> rows = new ArrayList<>();
                
                parameters.addValue("loggedinuser", loggedInUser.getIuserID());
                parameters.addValue("tenantid", dashboardQueryRequest.getTenantId());
                parameters.addValue("tenantidstr", dashboardQueryRequest.getTenantId().toString());
                parameters.addValue("orgid", loggedInUser.getIorgId().getIorgid());

                DatabaseType dbType;
                try {
                    dbType = DatabaseType.fromValue(dashboardQuery.getDbType());
                } catch (IllegalArgumentException e) {
                    LOGGER.error("Invalid database type: " + dashboardQuery.getDbType(), e);
                    throw new RuntimeException(e);
                }

                JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(dbType);
                if (selectedJdbcTemplate == null) {
                    throw new IllegalArgumentException("No JdbcTemplate found for database type: " + dbType);
                }

                NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
                        selectedJdbcTemplate.getDataSource());
                List<Map<String, Object>> test = jdbcTemplateObject.queryForList(queryString, parameters);

//                NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                        jdbcTemplateTransactional.getDataSource());
//                List<Map<String, Object>> test = jdbcTemplateObject.queryForList(queryString, parameters);


                LOGGER.debug("Exiting getFilterOptions Method in " + DataAnalyzerControllerServiceImpl.class
                        + " class with response  : filter options accessed successfully");
                activityLogService.addActivity(loggedInUser,
                        "filter dropdown options accessed successfully for " + MenuNames.dataAnalyzer,
                        "Parameters : " + dashboardQueryRequest);
                return ResponseEntity.ok(test);
            } else {
                LOGGER.debug("Exiting getFilterOptions Method in " + DataAnalyzerControllerServiceImpl.class
                        + " class with response  : failed to access rule management view table data");
                activityLogService.addActivity(loggedInUser, "failed to access rule management view table data",
                        "Parameters : " + dashboardQueryRequest);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Table name does not exist"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get filter options ");
            LOGGER.debug("Exiting getDashboardDropdown Method in " + ListManagementServiceImpl.class
                    + " class with response  : unauthorized to get filter options");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get filter options "),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getResultSetDataService(DashboardQueryRequest dashboardQueryRequest) {


        DashboardDataService temp = new DashboardDataService(dashboardQueryService, dashboardQueryParmeterService,
                loggerEncoderUtil,
                activityLogService, jdbcTemplateMap, transactionClassesUiService, dashboardErrorUtil);
        return temp.getResultSetDataService(dashboardQueryRequest);
    }



    public ResponseEntity<ResultSetResponse> streamExecutionResult(Integer tenantid, Long executionid, Authentication pr){
        return dashboardQueryExecutor.streamExecutionResult(tenantid, executionid, pr);
    }


public ResponseEntity<?> getResultSetData(DashboardQueryRequestGt dashboardQueryRequest, Integer tenantid,
                                          Authentication pr) {
    LOGGER.debug("entered in class " + DataAnalyzerControllerServiceImpl.class + " in method getResultSetData");


    LoggedUser temp = (LoggedUser) pr.getPrincipal();
    WebUser loggedInUser = temp.getWebUser();
    DashboardQuery dashboardQuery = dashboardQueryService.findById(dashboardQueryRequest.getQueryID(), tenantid);

    if (dashboardQuery.getImenuStructureDesc() == null) {
        activityLogService.addActivity(loggedInUser, "unauthorized to get result set data");
        LOGGER.debug("Exiting getResultSetData Method in " + ListManagementServiceImpl.class
                + " class with response  : unauthorized to get result set data");
        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get result set data"),
                HttpStatus.FORBIDDEN);
    }

    activityLogService.addActivity(loggedInUser, "dashboard data requested for " + MenuNames.dataAnalyzer,
            dashboardQueryRequest.toString());
    MenuPermissions mp = temp.getPermissions().get(dashboardQuery.getImenuStructureDesc().getVcMenuName());

    if (mp.isView() && temp.allowTenants(Arrays.asList(tenantid))) {
        DashboardQueryRequest request = new DashboardQueryRequest();
        request.setQueryID(dashboardQueryRequest.getQueryID());
        request.setParametersJson(dashboardQueryRequest.getParametersJson());
        request.setTimeZone(dashboardQueryRequest.getTimeZone());
        request.setInputTimezone(dashboardQueryRequest.getInputTimezone());
        request.setIuserid(loggedInUser.getIuserID());
        request.setIorgid(loggedInUser.getIorgId().getIorgid());
        request.setClassIds(temp.getUserClass());
        request.setItenantID(tenantid);
        return getResultSetDataService(request);
    } else {
        activityLogService.addActivity(loggedInUser, "unauthorized to get result set data");
        LOGGER.debug("Exiting getResultSetData Method in " + ListManagementServiceImpl.class
                + " class with response  : unauthorized to get result set data");
        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get result set data"),
                HttpStatus.FORBIDDEN);
    }
}


public ResponseEntity<?> getResultSetDataStart(DashboardQueryRequestGt dashboardQueryRequest, Integer tenantid,
                                               Authentication pr) {
    LOGGER.debug("entered in class " + DataAnalyzerControllerServiceImpl.class + " in method getResultSetData");


    LoggedUser temp = (LoggedUser) pr.getPrincipal();
    WebUser loggedInUser = temp.getWebUser();

    DashboardQuery dashboardQuery = dashboardQueryService.findById(dashboardQueryRequest.getQueryID(), tenantid);

    if(dashboardQuery == null )
    {
        activityLogService.addActivity(loggedInUser, "dashboad query id not found");
        LOGGER.debug("Exiting getResultSetData Method in " + ListManagementServiceImpl.class
                + " class with response  : dashboad query id not found");
        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "dashboad query id not found"),
                HttpStatus.BAD_REQUEST);
    }

    if (dashboardQuery.getImenuStructureDesc() == null) {
        activityLogService.addActivity(loggedInUser, "unauthorized to get result set data");
        LOGGER.debug("Exiting getResultSetData Method in " + ListManagementServiceImpl.class
                + " class with response  : unauthorized to get result set data");
        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get result set data"),
                HttpStatus.FORBIDDEN);
    }


    MenuPermissions mp = temp.getPermissions().get(dashboardQuery.getImenuStructureDesc().getVcMenuName());

    if (mp.isView() && temp.allowTenants(Arrays.asList(tenantid))) {
        Long executionID = Instant.now().toEpochMilli();

        DashboardQueryRequest request = new DashboardQueryRequest();
        request.setDashboardName(dashboardQueryRequest.getDashboardName());
        request.setQueryID(dashboardQueryRequest.getQueryID());
        request.setParametersJson(dashboardQueryRequest.getParametersJson());
        request.setTimeZone(dashboardQueryRequest.getTimeZone());
        request.setInputTimezone(dashboardQueryRequest.getInputTimezone());
//            request.setLoggedUser(temp);
        request.setItenantID(tenantid);
        request.setExecutionID(executionID);
        request.setIuserid(loggedInUser.getIuserID());
        request.setIorgid(loggedInUser.getIorgId().getIorgid());
        request.setClassIds(temp.getUserClass());



        dashboardQueryExecutor.getResultSetDataServiceAsync(request, dashboardQueryService, dashboardQueryParmeterService,
                loggerEncoderUtil,
                activityLogService, jdbcTemplateMap, transactionClassesUiService);

        return ResponseEntity.ok(new ResultSetDataStartResponse(executionID));
//            return getResultSetDataService(request, temp, tenantid);
    } else {
        activityLogService.addActivity(loggedInUser, "unauthorized to get result set data");
        LOGGER.debug("Exiting getResultSetData Method in " + ListManagementServiceImpl.class
                + " class with response  : unauthorized to get result set data");
        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get result set data"),
                HttpStatus.FORBIDDEN);
    }
}


@Override
public ResponseEntity<?> setResultSet(ResultSetLayoutRequest resultSetLayoutRequest, Authentication pr) {
    LOGGER.debug("entered in class " + DataAnalyzerControllerServiceImpl.class + " in method setResultSet");

    DashboardResultSet drs = dashboardResultSetService.findByID(resultSetLayoutRequest.getResultSetID(),
            resultSetLayoutRequest.getTenantId());
    Dashboard dashboard = dashboardService.findById(drs.getIDashboardID(), resultSetLayoutRequest.getTenantId());

    LoggedUser temp = (LoggedUser) pr.getPrincipal();
    WebUser loggedInUser = temp.getWebUser();
    activityLogService.addActivity(loggedInUser, " requested to set dashboard layout for " + MenuNames.dataAnalyzer,
            resultSetLayoutRequest.toString());

//        MenuPermissions mp = temp.getPermissions().get(drs.getImenuStructureDesc().getVcMenuName());
    MenuPermissions mp = temp.getPermissions().get(dashboard.getImenuStructureDesc().getVcMenuName());

    if (mp.isEdit()) {
        String status = "";
        try {

            if (resultSetLayoutRequest.getSetDefault()) {
                dashboardCustomLayoutService
                        .removeDefaultByResultSetID(resultSetLayoutRequest.getResultSetID(),
                                resultSetLayoutRequest.getTenantId());
                DashboardCustomLayout dcl = new DashboardCustomLayout();
                dcl.setIresultSetID(drs.getIDashboardResultSetID());
                dcl.setBdefault(true);
                dcl.setBdelete(false);
                dcl.setBactive(true);
                dcl.setVcLayoutJSON(resultSetLayoutRequest.getLayoutJsonString());
                dcl.setBshared(false);
                dcl.setIuserID(null);
                dcl.setDtCreaatedTimeStamp(ZonedDateTime.now());
                dcl.setDtLastupdatedTimeStamp(ZonedDateTime.now());
                dcl.setItenantId(resultSetLayoutRequest.getTenantId());
                dashboardCustomLayoutService.save(dcl);
                status = "Default";
            } else if (resultSetLayoutRequest.getSetForMySelf() || resultSetLayoutRequest.getResetMyself()) {

                DashboardCustomLayout dcl = dashboardCustomLayoutService.findDefaultLayoutByIResultSetIDUser(
                        resultSetLayoutRequest.getResultSetID(), loggedInUser.getIuserID(),
                        resultSetLayoutRequest.getTenantId());
                String setLayout = resultSetLayoutRequest.getSetForMySelf()
                        ? resultSetLayoutRequest.getLayoutJsonString()
                        : drs.getVcDashboardResultSetLayout();
                if (dcl == null) {
                    dcl = new DashboardCustomLayout();
                    dcl.setIresultSetID(drs.getIDashboardResultSetID());
                    dcl.setBdefault(true);
                    dcl.setBdelete(false);
                    dcl.setBactive(true);
                    dcl.setVcLayoutJSON(setLayout);
                    dcl.setBshared(false);
                    dcl.setIuserID(loggedInUser.getIuserID());
                    dcl.setIorgId(loggedInUser.getIorgId().getIorgid());
                    dcl.setDtCreaatedTimeStamp(ZonedDateTime.now());
                    dcl.setDtLastupdatedTimeStamp(ZonedDateTime.now());
                } else {
                    dcl.setDtLastupdatedTimeStamp(ZonedDateTime.now());
                    dcl.setVcLayoutJSON(setLayout);
                    dcl.setBdefault(true);
                }
                dcl.setItenantId(resultSetLayoutRequest.getTenantId());
                dashboardCustomLayoutService.save(dcl);
                if (resultSetLayoutRequest.getSetDefault()) {
                    status = status + " and Self Both";
                } else {
                    status = "Self";
                }

            }

            LOGGER.debug(loggerEncoderUtil
                    .encode("Exiting getDashboardDropdown Method in " + ListManagementServiceImpl.class
                            + " class with response  : Dashboard Resultset saved successfully for " + status));
            activityLogService.addActivity(loggedInUser, "  dashboard layout updated for " + MenuNames.dataAnalyzer,
                    resultSetLayoutRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(true, "Layout Updated Successfully for " + status), HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(
                    "Error : " + e + "\nParam : " + loggerEncoderUtil.encode(resultSetLayoutRequest.toString()));
            activityLogService.addActivity(loggedInUser, "failed to update dashboard Resultset",
                    "Error : " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    } else {
        activityLogService.addActivity(loggedInUser, "unauthorized to update Dashboard Resultset ");
        LOGGER.debug("Exiting getDashboardDropdown Method in " + ListManagementServiceImpl.class
                + " class with response  : unauthorized to update Dashboard Resultset ");
        return new ResponseEntity<ApiResponse>(
                new ApiResponse(false, "unauthorized to access Dashboard Resultset "),
                HttpStatus.FORBIDDEN);
    }

}

public ResponseEntity<?> getResultSetByArray(List<Integer> resultsetarray, Authentication pr, Integer iTenantID) {
    LOGGER.debug("entered in class " + DataAnalyzerControllerServiceImpl.class + " in method getResultSetByArray");

    List<DashboardResultSet> resultsetlist = dashboardResultSetService.findAllById(resultsetarray, iTenantID);

//        List<String> menunames = resultsetlist
//                .stream()
//                .map(a -> a.getImenuStructureDesc().getVcMenuName()).collect(Collectors.toList());

    List<Integer> dashboardIds = resultsetlist.stream()
            .map(DashboardResultSet::getIDashboardID)
            .distinct()
            .collect(Collectors.toList());

    List<String> menunames = dashboardService.findAllByIds(dashboardIds, iTenantID).stream()
            .map(dashboard -> dashboard.getImenuStructureDesc().getVcMenuName())
            .toList();

    LoggedUser temp1 = (LoggedUser) pr.getPrincipal();
    WebUser loggedInUser = temp1.getWebUser();

    boolean permissiontoaccess = menunames.stream().anyMatch(a -> {
        try {
            return !temp1.getPermissions().get(a).isView();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    });

    activityLogService.addActivity(loggedInUser, "dashboard resultset requested for " + menunames,
            "Dashboard id" + resultsetarray);

    if (!permissiontoaccess) {
        try {
            Map<Integer, Map<String, String>> response = new HashMap<>();
            for (DashboardResultSet iresultset : resultsetlist) {
                try {
                    DashboardResultSet drs = iresultset;
                    Integer iresultsetid = drs.getIDashboardResultSetID();

                    Map<String, String> temp = new HashMap<>();
                    temp.put("schema", drs.getVcDashboardResultSetSchema());
                    DashboardCustomLayout dcl = dashboardCustomLayoutService
                            .findDefaultLayoutByIResultSetID(iresultsetid, loggedInUser.getIuserID(), iTenantID);
                    if (dcl != null) {
                        temp.put("layout", dcl.getVcLayoutJSON());
                        response.put(iresultsetid, temp);
                    } else {
                        if (drs != null) {
                            temp.put("layout", drs.getVcDashboardResultSetLayout());
                            response.put(iresultsetid, temp);
                        } else {
                            response.put(iresultsetid, null);
                        }
                    }
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }

            activityLogService.addActivity(loggedInUser,
                    "Dashboard Resultset accessed successfully for " + menunames,
                    "Parameters : " + response.toString());
            LOGGER.debug("Exiting getResultSetByArray Method in " + ListManagementServiceImpl.class
                    + " class with response  : Dashboard Resultset");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(resultsetarray.toString()));
            activityLogService.addActivity(loggedInUser, "failed to access dashboard Resultset",
                    "Error : " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    } else {
        activityLogService.addActivity(loggedInUser, "unauthorized to access Dashboard Resultset ");
        LOGGER.debug("Exiting getResultSetByArray Method in " + ListManagementServiceImpl.class
                + " class with response  : unauthorized to access Dashboard Resultset ");
        return new ResponseEntity<ApiResponse>(
                new ApiResponse(false, "unauthorized to access Dashboard Resultset "),
                HttpStatus.FORBIDDEN);
    }
}

public LinkedHashMap<String, DashboardFiltersResponse> parseFromFilters(
        ArrayList<DashboardFilters> dashboardFiltersList, WebUser user, Integer tenantid) throws Exception {
    LinkedHashMap<String, DashboardFiltersResponse> res = new LinkedHashMap<>();
    for (DashboardFilters dashboardFilter : dashboardFiltersList) {
        if (dashboardFilter.getVcDashboardFilterType().equalsIgnoreCase("select")
                || dashboardFilter.getVcDashboardFilterType().equalsIgnoreCase("multiselect")) {
            DashboardFiltersResponse temp = new DashboardFiltersResponse();
            DashboardQuery options = dashboardQueryService
                    .findById(dashboardFilter.getIDashboardQueryIDForOptions(), tenantid);
            temp.setParametersRequired(options.getBParametersRequired());
            temp.setParametersJsonString(
                    options.getVcDashboardParametersJson());
            temp.setFilterQueryID(options.getIDashboardQueryID());
            temp.setDiplayName(dashboardFilter.getVcDashboardFilterDisplayName());
            temp.setFilterType(dashboardFilter.getVcDashboardFilterType());

            if (dashboardFilter.getIDashboardQueryIDForOptions() != null) {
                if (!options.getBParametersRequired()) {
                    String queryString = options.getVcDashboardQuery();

//                        Boolean isAnalytics = options.getRunOnAnalytics();

                    MapSqlParameterSource parameters = new MapSqlParameterSource();
                    parameters.addValue("loggedinuser", user.getIuserID());
                    parameters.addValue("tenantid", tenantid);
                    parameters.addValue("orgid", user.getIorgId().getIorgid());

                    if (queryString != null) {

                        List<Map<String, Object>> test;

                        DatabaseType dbType;
                        try {
                            dbType = DatabaseType.fromValue(options.getDbType());
                        } catch (IllegalArgumentException e) {
                            LOGGER.error("Invalid database type: " + options.getDbType(), e);
                            throw new RuntimeException(e);
                        }

                        JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(dbType);
                        if (selectedJdbcTemplate == null) {
                            throw new IllegalArgumentException("No JdbcTemplate found for database type: " + dbType);
                        }

                        NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(selectedJdbcTemplate.getDataSource());
                        test = jdbcTemplateObject.queryForList(queryString, parameters);
//                            if (isAnalytics != null) {
//                                if (isAnalytics) {
//
//                                    NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                            jdbcTemplateAnalytics.getDataSource());
//                                    test = jdbcTemplateObject.queryForList(queryString, parameters);
//                                } else {
//
//                                    NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                            jdbcTemplateTransactional.getDataSource());
//                                    test = jdbcTemplateObject.queryForList(queryString, parameters);
//                                }
//                            } else {
//
//                                NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                        jdbcTemplateTransactional.getDataSource());
//                                test = jdbcTemplateObject.queryForList(queryString, parameters);
//                            }
                        temp.setOptions(test);
                        test = null;
                    }

                }
            }
            temp.setFilterID(dashboardFilter.getIDashboardFilterID());
            res.put(dashboardFilter.getVcDashboardFilterName(), temp);
        } else if (dashboardFilter.getVcDashboardFilterType().equalsIgnoreCase("datepicker")) {
            DashboardFiltersResponse temp = new DashboardFiltersResponse();

            temp.setFilterType(dashboardFilter.getVcDashboardFilterType());
            temp.setDiplayName(dashboardFilter.getVcDashboardFilterDisplayName());
            if (dashboardFilter.getIDashboardQueryIDForDefaultValue() != null) {
                DashboardQuery defaultQuery = dashboardQueryService
                        .findById(dashboardFilter.getIDashboardQueryIDForDefaultValue(), tenantid);
                if (!defaultQuery.getBParametersRequired()) {
                    String queryString = defaultQuery
                            .getVcDashboardQuery();
                    Session session;
                    if (entityManager == null || (session = entityManager.unwrap(Session.class)) == null) {
                        throw new NullPointerException();
                    }
                    if (queryString != null) {
                        NativeQuery query = session.createNativeQuery(queryString);
                        List<Object> rows = new ArrayList<>();
                        try {
                            rows = query.list();
                            session.close();
                        } catch (OutOfMemoryError e) {
                            session.close();
                            LOGGER.error(e.toString());
                            throw e;
                        } catch (Exception e) {
                            session.close();
                            LOGGER.error(e.toString());
                            throw e;
                        }

                        if (rows.size() < 1) {
                            rows.add(new java.sql.Date(Calendar.getInstance().getTimeInMillis()));
                        }
                        java.sql.Date d = (java.sql.Date) rows.get(0);
                        temp.setValue(d);
                    }
                }
            }
            temp.setFilterID(dashboardFilter.getIDashboardFilterID());
            res.put(dashboardFilter.getVcDashboardFilterName(), temp);
        } else if (dashboardFilter.getVcDashboardFilterType().equalsIgnoreCase("daterangepicker")) {
            DashboardFiltersResponse temp = new DashboardFiltersResponse();
            temp.setFilterType(dashboardFilter.getVcDashboardFilterType());
            temp.setDiplayName(dashboardFilter.getVcDashboardFilterDisplayName());
            if (dashboardFilter.getIDashboardQueryIDForDefaultValue() != null) {
                DashboardQuery defaultQuery = dashboardQueryService
                        .findById(dashboardFilter.getIDashboardQueryIDForDefaultValue(), tenantid);
                if (!defaultQuery.getBParametersRequired()) {
                    String queryString = defaultQuery.getVcDashboardQuery();

//                        Boolean isAnalytics = defaultQuery.getRunOnAnalytics();

                    if (queryString != null) {

                        DatabaseType dbType;
                        try {
                            dbType = DatabaseType.fromValue(defaultQuery.getDbType());
                        } catch (IllegalArgumentException e) {
                            LOGGER.error("Invalid database type: " + defaultQuery.getDbType(), e);
                            throw new RuntimeException(e);
                        }

                        JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(dbType);
                        if (selectedJdbcTemplate == null) {
                            throw new IllegalArgumentException("No JdbcTemplate found for database type: " + dbType);
                        }

                        List<Map<String, Object>> test = selectedJdbcTemplate.queryForList(queryString);
//                            if (isAnalytics != null) {
//                                if (isAnalytics) {
//                                    test = jdbcTemplateAnalytics.queryForList(queryString);
//                                } else {
//                                    test = jdbcTemplateTransactional.queryForList(queryString);
//                                }
//                            } else {
//                                test = jdbcTemplateTransactional.queryForList(queryString);
//                            }

                        Timestamp start;
                        Timestamp end;
                        if (test.size() < 1) {
                            start = Timestamp.from(Instant.now());
                            end = Timestamp.from(Instant.now());
                        } else {
                            Map<String, Object> first = test.get(0);
                            start = (Timestamp) first.get("startdate");
                            end = (Timestamp) first.get("enddate");
                        }

                            LocalDate startlocaldate = start.toLocalDateTime().toLocalDate();
                            LocalDate endlocaldate = end.toLocalDateTime().toLocalDate();
                            LocalDateTime[] daterange = {startlocaldate.atStartOfDay(),
                                    endlocaldate.atTime(LocalTime.MAX)};
                            temp.setValue(daterange);
                            test = null;
                        }
                    }
                }
                temp.setFilterID(dashboardFilter.getIDashboardFilterID());
                temp.setValidation(dashboardFilter.getValidation());
                res.put(dashboardFilter.getVcDashboardFilterName(), temp);

        } else if (dashboardFilter.getVcDashboardFilterType().equalsIgnoreCase("input")) {
            DashboardFiltersResponse temp = new DashboardFiltersResponse();
            temp.setFilterType(dashboardFilter.getVcDashboardFilterType());
            temp.setDiplayName(dashboardFilter.getVcDashboardFilterDisplayName());
            temp.setValidation(dashboardFilter.getValidation());
            if (dashboardFilter.getIDashboardQueryIDForDefaultValue() != null) {
                DashboardQuery defaultQuery = dashboardQueryService
                        .findById(dashboardFilter.getIDashboardQueryIDForDefaultValue(), tenantid);
                if (!defaultQuery.getBParametersRequired()) {
                    String queryString = defaultQuery.getVcDashboardQuery();
                    Session session;
                    if (entityManager == null || (session = entityManager.unwrap(Session.class)) == null) {
                        throw new NullPointerException();
                    }
                    if (queryString != null) {
                        NativeQuery query = session.createNativeQuery(queryString);
                        List<Object> rows = new ArrayList<>();

                        try {
                            rows = query.list();
                            session.close();
                        } catch (OutOfMemoryError e) {
                            session.close();
                            LOGGER.error(e.toString());
                            throw e;
                        } catch (Exception e) {
                            session.close();
                            LOGGER.error(e.toString());
                            throw e;
                        }
                        temp.setValue(rows.get(0));
                    }
                }
            }
            temp.setFilterID(dashboardFilter.getIDashboardFilterID());
            res.put(dashboardFilter.getVcDashboardFilterName(), temp);
        } else if (dashboardFilter.getVcDashboardFilterType().equalsIgnoreCase("formfilter")) {
            DashboardFiltersResponse temp = new DashboardFiltersResponse();
            DashboardQuery options = dashboardQueryService
                    .findById(dashboardFilter.getIDashboardQueryIDForOptions(), tenantid);
            temp.setFilterID(dashboardFilter.getIDashboardFilterID());
            temp.setParametersRequired(options.getBParametersRequired());
            temp.setParametersJsonString(options.getVcDashboardParametersJson());
            temp.setFilterQueryID(options.getIDashboardQueryID());
            temp.setDiplayName(dashboardFilter.getVcDashboardFilterDisplayName());
            temp.setFilterType(dashboardFilter.getVcDashboardFilterType());
            res.put(dashboardFilter.getVcDashboardFilterName(), temp);
        } else if (dashboardFilter.getVcDashboardFilterType().equalsIgnoreCase("transpose")) {
            DashboardFiltersResponse temp = new DashboardFiltersResponse();
            temp.setFilterID(dashboardFilter.getIDashboardFilterID());
            temp.setValidation(dashboardFilter.getValidation());
            temp.setDiplayName(dashboardFilter.getVcDashboardFilterDisplayName());
            temp.setFilterType(dashboardFilter.getVcDashboardFilterType());
            temp.setValue("Normal");
            res.put(dashboardFilter.getVcDashboardFilterName(), temp);
        }
    }
    return res;
}

public HashMap<Integer, DashboardResultSetVO> parseResultSetFromDashboard(Dashboard dashboard, WebUser user,
                                                                          Integer itenantid)
        throws Exception {

        Integer iUserID = user.getIuserID();
    HashMap<Integer, DashboardResultSetVO> res = new HashMap<>();

    List<DashboardResultSet> dashboardResultSetList = dashboardResultSetService
            .findAllByDashboardID(dashboard.getIDashboardID(), itenantid);
    for (DashboardResultSet dashboardResultSet : dashboardResultSetList) {
        DashboardResultSetVO temp = new DashboardResultSetVO();
        DashboardQuery dashboardQuery = dashboardQueryService.findById(dashboardResultSet.getDashboardQuery(),
                itenantid);
        temp.setParametersRequired(dashboardQuery.getBParametersRequired());
        temp.setDashboardColumns(dashboardResultSet.getVcDashboardResultSetColumnJson());
        temp.setParametersJsonString(dashboardQuery.getVcDashboardParametersJson());
        temp.setColSize(dashboardResultSet.getIColSize());

        DashboardCustomLayout dcl = dashboardCustomLayoutService
                .findDefaultLayoutByIResultSetID(dashboardResultSet.getIDashboardResultSetID(), iUserID, itenantid);

        if (dcl != null) {
            temp.setDashboardLayout(dcl.getVcLayoutJSON());
        } else {
            temp.setDashboardLayout(dashboardResultSet.getVcDashboardResultSetLayout());
        }
        temp.setDashboardName(dashboardResultSet.getVcDashboardResultSetName());
        temp.setSchema(dashboardResultSet.getVcDashboardResultSetSchema());
        temp.setRowNo(dashboardResultSet.getIRowNo());
        temp.setIQueryID(dashboardQuery.getIDashboardQueryID());
        Object data = null;
        // if (!dashboardResultSet.getDashboardQuery().getBParametersRequired()) {
        // String queryString =
        // dashboardResultSet.getDashboardQuery().getVcDashboardQuery();
        // Boolean isanalytics =
        // dashboardResultSet.getDashboardQuery().getRunOnAnalytics();
        // Boolean isFormattingRequired =
        // dashboardResultSet.getDashboardQuery().getFormattingRequiered();
        // // ResultSetResponse finalres = new ResultSetResponse();
        // List<Map<String, Object>> test = null;
        // if (isanalytics != null) {
        // if (isanalytics) {
        // test = jdbcTemplateAnalytics.queryForList(queryString);

        // if (isFormattingRequired != null) {
        // if (isFormattingRequired) {
        // if (test.size() > 0) {
        // Map<String, Object> test1 = test.get(0);
        // data = test1.get("json_agg");
        // test = null;
        // test1 = null;
        // }
        // } else {
        // data = test;
        // test = null;

        // }
        // } else {
        // data = test;
        // test = null;

        // }

        // } else {

        // test = jdbcTemplateTransactional.queryForList(queryString);
        // if (isFormattingRequired != null) {
        // if (isFormattingRequired) {
        // if (test.size() > 0) {
        // Map<String, Object> test1 = test.get(0);
        // data = test1.get("json_agg");
        // test = null;
        // test1 = null;
        // }
        // } else {
        // data = test;
        // test = null;

        // }
        // } else {
        // data = test;
        // test = null;

        // }
        // }
        // } else {
        // test = jdbcTemplateTransactional.queryForList(queryString);
        // if (isFormattingRequired != null) {
        // if (isFormattingRequired) {
        // if (test.size() > 0) {
        // Map<String, Object> test1 = test.get(0);
        // data = test1.get("json_agg");
        // test = null;

        // }
        // } else {
        // data = test;
        // test = null;

        // }
        // } else {
        // data = test;
        // test = null;
        // }
        // }
        // // finalres.setConvertToJson(isFormattingRequired);
        // //
        // finalres.setTransposeRequired(dashboardResultSet.getDashboardQuery().getTransposeRequired());
        // temp.setDashboardData(new ResultSetResponse(null, data, isFormattingRequired,
        // dashboardResultSet.getDashboardQuery().getTransposeRequired()));
        // }

        res.put(dashboardResultSet.getIDashboardResultSetID(), temp);
    }
    return res;
}

public List<Object> get(int input) {
    List<Object> temp = new ArrayList<>();
    for (int i = 0; i < input; i++) {
        temp.add("" + i);
    }
    return temp;
}

@Override
public ResponseEntity<?> getTransactionClasses(String menuname, Integer tenantid, Authentication pr) {
    LOGGER.debug(
            "entered in class " + DataAnalyzerControllerServiceImpl.class + " in method getTransactionClasses");

    LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
    WebUser loggedInUser = loggedUser.getWebUser();
    activityLogService.addActivity(loggedInUser,
            "transaction classes requested for tenant " + tenantid);
    MenuPermissions mp = loggedUser.getPermissions().get(menuname);

    if (mp.isView() && loggedUser.allowTenants(Arrays.asList(tenantid))) {
        List<TransactionClassesUI> allClasses = new ArrayList<>();
        UserMapping classIds = loggedUser.getUserClass();
        if (classIds.getMappingIds().contains(-1)) {
            allClasses = transactionClassesService.findAllByTenantIds(Arrays.asList(tenantid));
        } else {
            allClasses = transactionClassesService.findByTenantClass(classIds);
        }
        // List<TransactionClassesUI> allClasses = loggedUser.getTransactionClasses().stream()
        //         .filter(cl -> cl.getItenantId().equals(tenantid)).toList();
        List<DropDownVo> responses = DropDownVoMapper
                .parseWithNameAsValue(allClasses);
        DropDownWitnAccessControl res = new DropDownWitnAccessControl();
        res.setDropDownOptions(responses);
        res.setAdd(mp.isAdd());
        res.setView(mp.isView());
        res.setDelete(mp.isDelete());
        res.setApprove(mp.isApprove());
        res.setEdit(mp.isEdit());

        return ResponseEntity.ok(res);
    } else {
        activityLogService.addActivity(loggedInUser, "unauthorized to access Transaction classes ");
        LOGGER.debug("Exiting getResultSetByArray Method in " + ListManagementServiceImpl.class
                + " class with response  : unauthorized to access Dashboard Resultset ");
        return new ResponseEntity<ApiResponse>(
                new ApiResponse(false, "unauthorized to access Transaction classes "),
                HttpStatus.FORBIDDEN);
    }

}
}
