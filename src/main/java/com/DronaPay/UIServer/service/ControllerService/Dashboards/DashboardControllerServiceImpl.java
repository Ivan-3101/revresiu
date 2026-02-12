package com.DronaPay.UIServer.service.ControllerService.Dashboards;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.DatabaseType;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropDownVo;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.VOMapper.DropDownVoMapper;
import com.DronaPay.UIServer.VOMapper.DropdownWithObjectMapper;
import com.DronaPay.UIServer.model.PerspectiveQuery;
import com.DronaPay.UIServer.model.PerspectiveQueryParameters;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.DashboardRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.DropDownWitnAccessControl;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.hibernate.Session;
import org.hibernate.query.SelectionQuery;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAccessor;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class DashboardControllerServiceImpl implements DashboardControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DashboardControllerServiceImpl.class);
    final String menu_name = MenuNames.dataAnalyzer;
//    @Qualifier("jdbcAnalyticsService")
//    @Autowired
//    JdbcTemplate jdbcTemplateAnalytics;
//    @Qualifier("jdbcTransactionalService")
//    @Autowired
//    JdbcTemplate jdbcTemplateTransactional;
    @Autowired
    private Map<DatabaseType, JdbcTemplate> jdbcTemplateMap;

    private JdbcTemplate jdbcTemplateAnalytics;
    private JdbcTemplate jdbcTemplateTransactional;

    @PostConstruct
    private void init() {
        this.jdbcTemplateTransactional = jdbcTemplateMap.get(DatabaseType.POSTGRESQL_TRANSACTIONAL);
        this.jdbcTemplateAnalytics = jdbcTemplateMap.get(DatabaseType.POSTGRESQL_ANALYTICS);
    }

//    private Map<DatabaseType, JdbcTemplate> jdbcTemplateMap;
//
//    @Autowired
//    public DashboardControllerServiceImpl(Map<DatabaseType, JdbcTemplate> jdbcTemplateMap) {
//        this.jdbcTemplateMap = jdbcTemplateMap;
//    }
    @Autowired
    private PerspectiveQueryService perspectiveQueryService;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private WebUserService webUserService;
    @PersistenceContext
    private EntityManager entityManager;
    @Autowired
    private TransactionClassesService transactionClassesService;
    @Autowired
    private VpaService vpaService;
    @Autowired
    private LiveTransService liveTransService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    public ResponseEntity<?>
    getTransactionClasses(String dashboardName, Authentication pr) {
        LOGGER.debug("entered in class " + DashboardControllerServiceImpl.class + " in method getTransactionClasses");
        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        activityLogService.addActivity(loggedInUser, "transaction classes dropdown options requested for " + dashboardName, dashboardName);

        MenuPermissions mp = loggedUser.getPermissions().get(dashboardName);

        if (mp.isView()) {
            try {
                // List<DropDownVo> responses = DropDownVoMapper
                //         .parseWithNameAsValue(transactionClassesService.findAllActiveClasses());
                DropDownWitnAccessControl res = new DropDownWitnAccessControl();
                // res.setDropDownOptions(responses);
                res.setAdd(mp.isAdd());
                res.setView(mp.isView());
                res.setDelete(mp.isDelete());
                res.setApprove(mp.isApprove());
                res.setEdit(mp.isEdit());

                activityLogService.addActivity(loggedInUser, "Dashboard transaction classes successfully accessed for " + dashboardName,
                        "Parameters : " + res.toString());
                LOGGER.debug("Exiting getTransactionClasses Method in " + DashboardControllerServiceImpl.class
                        + " class with response  : transaction classes dropdown");
                return ResponseEntity.ok(res);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
                activityLogService.addActivity(loggedInUser, "failed to access dashboard transaction classes",
                        "Error : " + e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get transaction classes filter options ");
            LOGGER.debug("Exiting getTransactionClasses Method in " + DashboardControllerServiceImpl.class
                    + " class with response  : unauthorized to get transaction classes filter options");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "unauthorized to get transaction classes filter options "),
                    HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> getVpaDropdown(String type, Authentication pr) {
        LOGGER.debug("entered in class " + DashboardControllerServiceImpl.class + " in method getVpaDropdown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        activityLogService.addActivity(loggedInUser, "vpa dropdown options requested  ", type);

        try {
            List<DropdownWithObject> responses = null;
            if (type.equalsIgnoreCase("payer")) {
                responses = DropdownWithObjectMapper.parseVpaFromVpa(vpaService.findAll());
            } else if (type.equalsIgnoreCase("payee")) {
                responses = DropdownWithObjectMapper.parseVpaFromVpa(vpaService.findAll());
            }
            activityLogService.addActivity(loggedInUser, "vpa dropdown accessed successfully ",
                    "Parameters : " + responses.toString());
            LOGGER.debug("Exiting getVpaDropdown Method in " + DashboardControllerServiceImpl.class
                    + " class with response  : vpa dropdown list");
            return ResponseEntity.ok(responses);
        } catch (Exception e) {

            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
            activityLogService.addActivity(loggedInUser, "failed to access vpa dropdown accessed",
                    "Error : " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

    public ResponseEntity<?> getIDDropdown(Authentication pr) {

        LOGGER.debug("entered in class " + DashboardControllerServiceImpl.class + " in method getIDDropdown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        activityLogService.addActivity(loggedInUser, "transaction id dropdown options requested  ");

        try {
            List<DropdownWithObject> responses = DropdownWithObjectMapper.parseFromID(liveTransService.findAll());
            activityLogService.addActivity(loggedInUser, "id dropdown accessed successfully ",
                    "Parameters : " + responses.toString());
            LOGGER.debug("Exiting getIDDropdown Method in " + DashboardControllerServiceImpl.class
                    + " class with response  : id dropdown list");
            return ResponseEntity.ok(responses);
        } catch (Exception e) {

            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(loggedInUser.toString()));
            activityLogService.addActivity(loggedInUser, "failed to access id dropdown accessed",
                    "Error : " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<?> getScoreDropdown(Authentication pr) {

        LOGGER.debug("entered in class " + DashboardControllerServiceImpl.class + " in method getScoreDropdown");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();

        activityLogService.addActivity(loggedInUser, "transaction score dropdown options requested  ");

        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {
            String queryString = "select DISTINCT score, true as \"Rule Score\" from transactions.livetrans where score > 0 order by score";

            Session session = null;
            if (entityManager == null
                    || (session = entityManager.unwrap(Session.class)) == null) {
                throw new NullPointerException();
            }
            if (queryString != null) {
                SelectionQuery query = session.createNamedQuery(queryString);
                List<Object[]> rows = new ArrayList<>();

                try {
                    rows = query.list();
                    session.close();
                } catch (OutOfMemoryError e) {
                    session.close();
                    rows = null;
                    activityLogService.addActivity(loggedInUser, "Exiting getScoreDropdown Method in "
                            + DashboardControllerServiceImpl.class + " class with response  : " + e.toString());
                    LOGGER.error("Exiting getScoreDropdown Method in "
                            + DashboardControllerServiceImpl.class + " class with response  : " + e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Unable to execute query because : " + e.toString()),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                } catch (Exception e) {
                    session.close();
                    rows = null;
                    activityLogService.addActivity(loggedInUser, "Exiting getScoreDropdown Method in "
                            + DashboardControllerServiceImpl.class + " class with response  : " + e.toString());
                    LOGGER.error("Exiting getScoreDropdown Method in "
                            + DashboardControllerServiceImpl.class + " class with response  : " + e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Unable to execute query because : " + e.toString()),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                List<DropdownWithObject> responses = DropdownWithObjectMapper.parseDashboardDropdownFromObject(rows);

                LOGGER.debug("Exiting getScoreDropdown Method in " + DashboardControllerServiceImpl.class
                        + " class with response  : filter options accessed successfully");
                activityLogService.addActivity(loggedInUser, "score dropdown  options accessed successfully ");
                return ResponseEntity.ok(responses);
            } else {
                LOGGER.debug("Exiting getScoreDropdown Method in " + DashboardControllerServiceImpl.class
                        + " class with response  : failed to access rule management view table data");
                activityLogService.addActivity(loggedInUser, "failed to access rule management view table data");
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Table name does not exist"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to get filter options ");
            LOGGER.debug("Exiting getScoreDropdown Method in " + DashboardControllerServiceImpl.class
                    + " class with response  : unauthorized to get filter options");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to get filter options "),
                    HttpStatus.FORBIDDEN);
        }
    }

//    public ResponseEntity<?> queryForDashboard(DashboardRequest dashboardRequest, Authentication pr) {
//
//        LOGGER.debug("entered in class " + DashboardControllerServiceImpl.class + " in method queryForDashboard");
//
//        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
//
//        WebUser loggedInUser = loggedUser.getWebUser();
//
//        activityLogService.addActivity(loggedInUser, "data requested for dashboard ", dashboardRequest.toString());
//
//        String queryString = null;
//        PerspectiveQuery perspectiveQuery = null;
//        try {
//            perspectiveQuery = perspectiveQueryService.findByVcTableName(dashboardRequest.getTableName());
//        } catch (Exception e) {
//            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(dashboardRequest.getTableName()));
//            activityLogService.addActivity(loggedInUser, "failed to execute dashboard query",
//                    "Error : " + e.toString());
//            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
//                    HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//
//        if (perspectiveQuery != null) {
//            queryString = perspectiveQuery.getVcQuery();
//        } else {
//            activityLogService.addActivity(loggedInUser,
//                    "failed to execute dashboard query because query is not present in database");
//            LOGGER.error("Exiting queryForDashboard Method in " + DashboardControllerServiceImpl.class
//                    + " class with response  : query is not present in database");
//            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "query is not present in database"),
//                    HttpStatus.FORBIDDEN);
//        }
//
//
//        if (queryString != null) {
//            MapSqlParameterSource parameters = new MapSqlParameterSource();
//
//            List<PerspectiveQueryParameters> listParametersoriginal = new ArrayList<>();
//            listParametersoriginal = perspectiveQuery.getPerspectiveQueryParametersList();
//            ObjectMapper mapper = new ObjectMapper();
//            try {
//                if (dashboardRequest.getJsonFilter() != null) {
//                    Map<String, Object> map = null;
//                    try {
//                        map = mapper.readValue(dashboardRequest.getJsonFilter(), Map.class);
//                    } catch (JsonProcessingException e) {
//                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(dashboardRequest.toString()));
//                        activityLogService.addActivity(loggedInUser, "failed to get resultset data",
//                                "Error : " + e.toString());
//                        return new ResponseEntity<ApiResponse>(
//                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
//                                HttpStatus.INTERNAL_SERVER_ERROR);
//                    }
//                    List<PerspectiveQueryParameters> listParameterjsonpath = null;
//                    try {
//                        mapper.readTree(queryString);
//                        JSONObject jsonTemp = new JSONObject(queryString);
//                        HashMap<Integer, PerspectiveQueryParameters> t = (HashMap<Integer, PerspectiveQueryParameters>) listParametersoriginal
//                                .stream()
//                                .filter(c -> c.getVcParameterType().equals("JsonPath"))
//                                .collect(Collectors.toMap(PerspectiveQueryParameters::getIOrder, Function.identity()));
//
//                        listParameterjsonpath = new ArrayList<PerspectiveQueryParameters>(t.values());
//
//                        String path = "";
//                        JSONObject js = jsonTemp;
//                        for (PerspectiveQueryParameters item : listParameterjsonpath) {
//                            Object temp = new Object();
//                            temp = map.get(item.getVcParameterName());
//                            if (js.optString((String) temp) != null && js.optString((String) temp) != "") {
//                                try {
//                                    js = js.optJSONObject((String) temp);
//                                } catch (ClassCastException e) {
//                                }
//                                path += "/" + temp;
//                            } else {
//                                try {
//                                    js = js.optJSONObject("Other");
//                                } catch (ClassCastException e) {
//                                }
//                                path += "/" + "Other";
//                                parameters.addValue(item.getVcParameterName(), temp);
//                            }
//                        }
//                        queryString = (String) jsonTemp.optQuery(path);
//                    } catch (JsonProcessingException e) {
//                    }
//
//                    List<PerspectiveQueryParameters> listParameters = listParametersoriginal
//                            .stream()
//                            .filter(c -> !c.getVcParameterType().equals("JsonPath"))
//                            .collect(Collectors.toList());
//
//                    for (PerspectiveQueryParameters item : listParameters) {
//                        String parameterName = item.getVcParameterName();
//                        try {
//                            switch (item.getVcParameterType()) {
//                                case "Integer":
//
//                                    parameters.addValue(parameterName, (Integer) map.get(parameterName));
//                                    break;
//                                case "String":
//
//                                    parameters.addValue(parameterName, (String) map.get(parameterName));
//                                    break;
//                                case "Date":
//                                    TemporalAccessor ta = DateTimeFormatter.ISO_ZONED_DATE_TIME
//                                            .parse((String) map.get(parameterName));
//                                    Instant i = Instant.from(ta);
//                                    Date d = Date.from(i);
//                                    try {
//                                        parameters.addValue(parameterName, d);
//                                    } catch (Exception e) {
//                                        LOGGER.error(e.toString());
//                                    }
//                                    break;
//                            }
//                        } catch (Exception e) {
//                            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(parameterName));
//                            activityLogService.addActivity(loggedInUser, "failed to set valuesy",
//                                    "Error : " + e.toString());
//                            return new ResponseEntity<ApiResponse>(
//                                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
//                                    HttpStatus.INTERNAL_SERVER_ERROR);
//                        }
//                    }
//                }
//
//            } catch (Exception e) {
//                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(dashboardRequest.getJsonFilter()));
//                activityLogService.addActivity(loggedInUser, "failed to execute dashboard query",
//                        "Error : " + e.toString());
//                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
//                        HttpStatus.INTERNAL_SERVER_ERROR);
//            }
//
//            if (dashboardRequest.getTimeZone() != null) {
//
//                parameters.addValue("timeZone", dashboardRequest.getTimeZone());
//            }
//
//            Boolean isanalytics = perspectiveQuery.getRunOnAnalytics();
//            Boolean isFormattingRequired = perspectiveQuery.getFormattingRequiered();
//            List<Map<String, Object>> test = null;
//            activityLogService.addActivity(loggedInUser, "data accessed successfully  for dashboard ", dashboardRequest.toString());
//
//            try {
//                if (isanalytics != null) {
//                    if (isanalytics) {
//                        if (parameters.getValues().size() != 0) {
//                            NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                    jdbcTemplateAnalytics.getDataSource());
//                            test = jdbcTemplateObject.queryForList(queryString, parameters);
//                            if (isFormattingRequired != null) {
//                                if (isFormattingRequired) {
//                                    Map<String, Object> test1 = test.get(0);
//                                    return ResponseEntity.ok(test1.get("json_agg"));
//                                } else {
//                                    return ResponseEntity.ok(test);
//                                }
//                            } else {
//                                return ResponseEntity.ok(test);
//                            }
//                        } else {
//                            test = jdbcTemplateAnalytics.queryForList(queryString);
//                            if (isFormattingRequired != null) {
//                                if (isFormattingRequired) {
//                                    Map<String, Object> test1 = test.get(0);
//                                    return ResponseEntity.ok(test1.get("json_agg"));
//                                } else {
//                                    return ResponseEntity.ok(test);
//                                }
//                            } else {
//                                return ResponseEntity.ok(test);
//                            }
//                        }
//                    } else {
//                        if (parameters.getValues().size() != 0) {
//                            NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                    jdbcTemplateTransactional.getDataSource());
//                            test = jdbcTemplateObject.queryForList(queryString, parameters);
//                            if (isFormattingRequired != null) {
//                                if (isFormattingRequired) {
//                                    if (test.size() > 0) {
//                                        Map<String, Object> test1 = test.get(0);
//                                        return ResponseEntity.ok(test1.get("json_agg"));
//                                    }
//                                } else {
//                                    return ResponseEntity.ok(test);
//                                }
//                            } else {
//                                return ResponseEntity.ok(test);
//                            }
//                        } else {
//                            test = jdbcTemplateTransactional.queryForList(queryString);
//                            if (isFormattingRequired != null) {
//                                if (isFormattingRequired) {
//                                    if (test.size() > 0) {
//                                        Map<String, Object> test1 = test.get(0);
//                                        return ResponseEntity.ok(test1.get("json_agg"));
//                                    }
//                                } else {
//                                    return ResponseEntity.ok(test);
//                                }
//                            } else {
//                                return ResponseEntity.ok(test);
//                            }
//                        }
//                    }
//                } else {
//                    if (parameters.getValues().size() != 0) {
//                        NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                jdbcTemplateTransactional.getDataSource());
//                        test = jdbcTemplateObject.queryForList(queryString, parameters);
//                        if (isFormattingRequired != null) {
//                            if (isFormattingRequired) {
//                                Map<String, Object> test1 = test.get(0);
//
//                                return ResponseEntity.ok(test1.get("json_agg"));
//                            } else {
//                                return ResponseEntity.ok(test);
//                            }
//                        } else {
//                            return ResponseEntity.ok(test);
//                        }
//                    } else {
//                        test = jdbcTemplateTransactional.queryForList(queryString);
//                        if (isFormattingRequired != null) {
//                            if (isFormattingRequired) {
//                                if (test.size() > 0) {
//                                    Map<String, Object> test1 = test.get(0);
//                                    return ResponseEntity.ok(test1.get("json_agg"));
//                                }
//                            } else {
//                                return ResponseEntity.ok(test);
//                            }
//                        } else {
//                            return ResponseEntity.ok(test);
//                        }
//                    }
//                }
//            } catch (OutOfMemoryError e) {
//
//                activityLogService.addActivity(loggedInUser, "Exiting queryForDashboard Method in "
//                        + DashboardControllerServiceImpl.class + " class with response  : " + e.toString());
//                LOGGER.error("Exiting queryForDashboard Method in "
//                        + DataAnalyzerControllerServiceImpl.class + " class with response  : " + e.toString());
//                return new ResponseEntity<ApiResponse>(
//                        new ApiResponse(false, "Unable to execute query because : " + e.toString()),
//                        HttpStatus.FORBIDDEN);
//            } catch (Exception e) {
//
//                activityLogService.addActivity(loggedInUser, "Exiting queryForDashboard Method in "
//                        + DashboardControllerServiceImpl.class + " class with response  : " + e.toString());
//                LOGGER.error("Exiting queryForDashboard Method in "
//                        + DataAnalyzerControllerServiceImpl.class + " class with response  : " + e.toString());
//                return new ResponseEntity<ApiResponse>(
//                        new ApiResponse(false, "Unable to execute query because : " + e.toString()),
//                        HttpStatus.FORBIDDEN);
//            }
//            return null;
//        } else {
//            activityLogService.addActivity(loggedInUser,
//                    "failed to execute dashboard query because query is not present in database");
//            LOGGER.error("Exiting queryForDashboard Method in " + DashboardControllerServiceImpl.class
//                    + " class with response  : query is not present in database");
//            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "query is not present in database"),
//                    HttpStatus.FORBIDDEN);
//        }
//    }
}
