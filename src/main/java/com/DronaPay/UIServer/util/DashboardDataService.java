package com.DronaPay.UIServer.util;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.DatabaseType;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.DashboardQuery;
import com.DronaPay.UIServer.model.DashboardQueryParameters;
import com.DronaPay.UIServer.model.TransactionClassesUI;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.DashboardQueryRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.ResultSetResponse;
import com.DronaPay.UIServer.service.ControllerService.Dashboards.DataAnalyzerControllerServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nimbusds.jose.shaded.gson.Gson;
import com.nimbusds.jose.shaded.gson.JsonObject;
import com.nimbusds.jose.shaded.gson.JsonPrimitive;
import jakarta.persistence.PersistenceException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.hibernate.annotations.Cache;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.net.UnknownHostException;
import java.sql.SQLException;
import java.sql.Types;
import java.time.Duration;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAccessor;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
public class DashboardDataService {


    DashboardErrorUtil dashboardErrorUtil;

    DashboardQueryService dashboardQueryService;

    LoggerEncoderUtil loggerEncoderUtil;

    ActivityLogService activityLogService;

    Map<DatabaseType, JdbcTemplate> jdbcTemplateMap;

//    JdbcTemplate jdbcTemplateAnalytics;

//    JdbcTemplate jdbcTemplateTransactional;

    DashboardQueryParmeterService dashboardQueryParmeterService;

    TransactionClassesUiService transactionClassesUiService;

    public DashboardDataService(
            DashboardQueryService dashboardQueryService,
            DashboardQueryParmeterService dashboardQueryParmeterService,
            LoggerEncoderUtil loggerEncoderUtil,
            ActivityLogService activityLogService,
//            JdbcTemplate jdbcTemplateAnalytics,
//            JdbcTemplate jdbcTemplateTransactional,
            Map<DatabaseType, JdbcTemplate> jdbcTemplateMap,
            TransactionClassesUiService transactionClassesUiService,
            DashboardErrorUtil dashboardErrorUtil
    ) {
        this.dashboardQueryService = dashboardQueryService;
        this.dashboardQueryParmeterService = dashboardQueryParmeterService;
        this.loggerEncoderUtil = loggerEncoderUtil;
        this.activityLogService = activityLogService;
//        this.jdbcTemplateAnalytics = jdbcTemplateAnalytics;
//        this.jdbcTemplateTransactional = jdbcTemplateTransactional;
        this.jdbcTemplateMap = jdbcTemplateMap;
        this.transactionClassesUiService = transactionClassesUiService;
        this.dashboardErrorUtil = dashboardErrorUtil;
    }

    public ResponseEntity<?> getResultSetDataService(DashboardQueryRequest dashboardQueryRequest) {
        Instant executionStarted = Instant.now();

        Integer tenantid = dashboardQueryRequest.getItenantID();
        Integer loggedInUser = dashboardQueryRequest.getIuserid();
        Integer iorgid = dashboardQueryRequest.getIorgid();
        UserMapping classIds = dashboardQueryRequest.getClassIds();
        DashboardQuery dashboardQuery = null;

        Gson gson = new Gson();
        JsonObject jsonObject = gson.toJsonTree(dashboardQueryRequest).getAsJsonObject();
        jsonObject.addProperty("ExecutionStarted", executionStarted.toString());

        activityLogService.addActivity(loggedInUser, iorgid,"dashboard data requested for Dashboard " + dashboardQueryRequest.getDashboardName(), jsonObject.toString() );

        String queryString = null;
        try {
            dashboardQuery = dashboardQueryService.findById(dashboardQueryRequest.getQueryID(), tenantid);
            if (dashboardQuery != null) {
                queryString = dashboardQuery.getVcDashboardQuery();
            }
        } catch (Exception e) {
            log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(dashboardQueryRequest.toString()));
            activityLogService.addActivity(loggedInUser, iorgid, "failed to get resultset data", "Error : " + e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (queryString != null) {

            List<DashboardQueryParameters> listParametersoriginal = dashboardQueryParmeterService.findByidAndTenant(dashboardQuery.getIDashboardQueryID(), tenantid);
            MapSqlParameterSource parameters = new MapSqlParameterSource();

            try {
                if (dashboardQueryRequest.getParametersJson() != null) {
                    ObjectMapper mapper = new ObjectMapper();
                    Map<String, Object> map = null;
                    try {
                        map = mapper.readValue(dashboardQueryRequest.getParametersJson(), Map.class);
                    } catch (JsonProcessingException e) {
                        log.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(dashboardQueryRequest.toString()));
                        activityLogService.addActivity(loggedInUser, iorgid, "failed to get resultset data",
                                "Error : " + e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    try {
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
                            if(js == null) {
                                activityLogService.addActivity(loggedInUser, iorgid, "dashboard query not configured properly",
                                        "Parameters : " + dashboardQueryRequest);
                                log.error("Exiting getResultSetData Method in "
                                        + DataAnalyzerControllerServiceImpl.class
                                        + " class with response  : dashboard query not configured propertly" + dashboardQueryRequest.toString());
                                return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Dashboard query not configured properly"),
                                        HttpStatus.OK);
                            }

                            if (js.optString((String) temp) != null && js.optString((String) temp) != "") {
                                try {
                                    js = js.optJSONObject((String) temp);
                                } catch (ClassCastException e) {
                                }
                                path += "/" + temp;
                            }
                            else {
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

                    System.out.println(queryString);

                    if (dashboardQueryRequest.getInputTimezone() != null) {
                        parameters.addValue("inputTimeZone", dashboardQueryRequest.getInputTimezone());
                    }

                    for (DashboardQueryParameters item : listParameters) {
                        String parameterName = item.getVcParameterName();
                        JsonNode validation = item.getValidation();
                        String temp = null;
                        switch (item.getVcParameterType()) {
                            case "Long":
                                parameters.addValue(parameterName,
                                        Long.parseLong(map.get(parameterName).toString()));
                                break;
                            case "Integer":
                                parameters.addValue(parameterName,
                                        Integer.parseInt(map.get(parameterName).toString()));
                                break;
                            case "String":
                                String stringValue = (String) map.get(parameterName);

                                if (validation != null && !validation.isEmpty()) {
                                    JsonNode patternNode = validation.get("pattern");
                                    JsonNode errorMessageNode = validation.get("errorMessage");
                                    if (patternNode != null) {
                                        String pattern = patternNode.asText();
                                        Pattern compiledPattern = Pattern.compile(pattern);
                                        Matcher matcher = compiledPattern.matcher(stringValue);

                                        if (!matcher.matches()) {
                                            String errorMessage = errorMessageNode != null ? errorMessageNode.asText() : ResponseMessages.GenericErrorMessage;
                                            log.error("Error: Invalid value for parameter - " + parameterName + "\nParam: " + loggerEncoderUtil.encode(dashboardQueryRequest.toString()));
                                            activityLogService.addActivity(loggedInUser, iorgid, "failed to get resultset data", errorMessage);
                                            return new ResponseEntity<>(new ApiResponse(false, errorMessage),
                                                    HttpStatus.BAD_REQUEST);
                                        }
                                    }
                                }
                                parameters.addValue(parameterName, stringValue);
//                                parameters.addValue(parameterName, (String) map.get(parameterName));
                                break;
                            case "List<String>":
                                parameters.addValue(parameterName, map.get(parameterName));
                                break;
                            case "Boolean":
                                parameters.addValue(parameterName, (Boolean) map.get(parameterName));
                                break;
                            case "Date":
                                TemporalAccessor ta = DateTimeFormatter.ISO_ZONED_DATE_TIME
                                        .parse((String) map.get(parameterName));
                                Instant i = Instant.from(ta);
                                Date d = Date.from(i);
                                try {
                                    parameters.addValue(parameterName, d);
                                } catch (Exception e) {
                                    log.error(e.toString());
                                }
                                break;


                            case "DateRange":


                                String inputtimezone = dashboardQueryRequest.getInputTimezone() == null ? "Asia/Kolkata" : dashboardQueryRequest.getInputTimezone();

                                ArrayList<String> myList = (ArrayList<String>) map.get(parameterName);
                                ZonedDateTime startLocalDate = ZonedDateTime
                                        .parse(myList.get(0),
                                                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX").withZone(ZoneId.of(inputtimezone)));
                                Calendar c = Calendar.getInstance();
                                c.setTimeZone(TimeZone.getTimeZone(inputtimezone));
                                c.setTimeInMillis(startLocalDate.toInstant().toEpochMilli());

                                ZonedDateTime endLocalDate = ZonedDateTime
                                        .parse(myList.get(1),
                                                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX").withZone(ZoneId.of(inputtimezone)));


                                Calendar c1 = Calendar.getInstance();
                                c1.setTimeZone(TimeZone.getTimeZone(inputtimezone));
                                c1.setTimeInMillis(endLocalDate.toInstant().toEpochMilli());


                                parameters.addValue("StartDate", c, Types.TIMESTAMP);
                                parameters.addValue("EndDate", c1, Types.TIMESTAMP);

//
                                break;
                            case "TableName":
                                temp = queryString;
                                temp = temp.replace(":" + parameterName, (String) map.get(parameterName));
                                queryString = temp;
                                break;

                            case "List":

                                List<Map<String, Object>> list = (List<Map<String, Object>>) map.get(parameterName);
                                List<Object> valuelist = new ArrayList<>();
                                String returnType = "";
                                for (Map<String, Object> element : list) {

                                    valuelist.add(element.get("value"));
                                    String initial = (String) element.get("returntype");
                                    if (initial != null && initial != "")
                                        returnType += returnType == "" ? initial : ", " + initial;
                                }

                                parameters.addValue(parameterName + "Value", valuelist);
                                temp = queryString;

                                if (returnType.contains(";")) {
                                    activityLogService.addActivity(loggedInUser, iorgid, "Malicious where clause ",
                                            "Parameters : " + dashboardQueryRequest);
                                    log.debug("Exiting getResultSetData Method in "
                                            + DataAnalyzerControllerServiceImpl.class
                                            + " class with response  : Malicious where clause");
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false, "Malicious where clause"),
                                            HttpStatus.BAD_REQUEST);
                                }

                                temp = temp.replace(":" + parameterName + "ReturnType", returnType);

                                queryString = temp;
                                break;

                            case "WhereStatement":
                                temp = queryString;
                                String value = (String) map.get(parameterName);
                                if (value == null || value.contains(";")) {
                                    activityLogService.addActivity(loggedInUser, iorgid, "Malicious where clause ",
                                            "Parameters : " + dashboardQueryRequest);
                                    log.debug("Exiting getResultSetData Method in "
                                            + DataAnalyzerControllerServiceImpl.class
                                            + " class with response  : Malicious where clause");
                                    return new ResponseEntity<ApiResponse>(
                                            new ApiResponse(false, "Malicious where clause"),
                                            HttpStatus.BAD_REQUEST);
                                }

                                String whereClause = StringUtils.substringBetween(temp.toLowerCase(), "from",
                                        parameterName.toLowerCase());
                                whereClause = whereClause == null ? "" : whereClause;
                                System.out.println("where clause extracted " + whereClause);
                                if (value.isEmpty() || value.isBlank()) {
                                    temp = temp.replace(":" + parameterName, "");
                                } else if (whereClause.contains("where")) {
                                    temp = temp.replace(":" + parameterName, "and " + value);
                                } else {
                                    temp = temp.replace(":" + parameterName, "where " + value);
                                }
                                queryString = temp;
                                System.out.println("Query generated " + queryString);
                                break;
                        }
                    }
                }
                if (dashboardQueryRequest.getTimeZone() != null) {
                    parameters.addValue("timeZone", dashboardQueryRequest.getTimeZone());

                }


                List<TransactionClassesUI> allowedClass;
                if(classIds.getMappingIds().contains(-1)) {
                    allowedClass = transactionClassesUiService.findAllByTenantId(tenantid);
                } else {
                    allowedClass = transactionClassesUiService.findByTenantClass(classIds);
                }
                List<String> allclasses = allowedClass
                        .stream()
                        .map(TransactionClassesUI::getVcClassName)
                        .toList();

                parameters.addValue("loggedinuser", loggedInUser);
                parameters.addValue("tenantid", tenantid);
                parameters.addValue("tenantidstr", tenantid.toString());
                parameters.addValue("orgid", iorgid);
                parameters.addValue("allClasses", allclasses);
            } catch (IllegalArgumentException e) {
            }

//            ResultSetResponse res = new ResultSetResponse();

//            Boolean isanalytics = dashboardQuery.getRunOnAnalytics();
            Boolean isFormattingRequired = dashboardQuery.getFormattingRequiered();
            List<Map<String, Object>> test;
            Object data = null;
            String message = null;
            try {
                DatabaseType dbType;
                try {
                    dbType = DatabaseType.fromValue(dashboardQuery.getDbType());
                } catch (IllegalArgumentException e) {
                    log.error("Invalid database type: " + dashboardQuery.getDbType(), e);
                    throw new RuntimeException(e);
                }

//                System.out.println("Database = " + dbType);

                JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(dbType);
                if (selectedJdbcTemplate == null) {
                    throw new IllegalArgumentException("No JdbcTemplate found for database type: " + dbType);
                }

                if (parameters.getValues().size() != 0) {
                    NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(selectedJdbcTemplate.getDataSource());
                    test = jdbcTemplateObject.queryForList(queryString, parameters);

                } else {
                    test = selectedJdbcTemplate.queryForList(queryString);
                }

                if (isFormattingRequired != null && isFormattingRequired && test.size() > 0) {
                    Map<String, Object> test1 = test.get(0);
                    data = test1.get("json_agg");
                    test=null;
                    test1=null;
                } else {
                    data = test;
                    test=null;
                }
//                if (isanalytics != null) {
//                    if (isanalytics) {
//                        log.info("JdbcTemplateMap injected in method: {}", jdbcTemplateMap);
//                        if (parameters.getValues().size() != 0) {
//
//                            NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                    jdbcTemplateAnalytics.getDataSource());
//                            test = jdbcTemplateObject.queryForList(queryString, parameters);
//
//                            jdbcTemplateObject = null;
//                            if (isFormattingRequired != null) {
//                                if (isFormattingRequired) {
//                                    if (test.size() > 0) {
//                                        Map<String, Object> test1 = test.get(0);
//                                        data = test1.get("json_agg");
//                                        test = null;
//                                        test1 = null;
//                                    }
//                                } else {
//
//                                    data = test;
//                                    test = null;
//                                }
//                            } else {
//                                data = test;
//                                test = null;
//                            }
//                        } else {
//
//                            test =
//                                    jdbcTemplateAnalytics.queryForList(queryString);
//                            if (isFormattingRequired != null) {
//                                if (isFormattingRequired) {
//                                    if (test.size() > 0) {
//                                        Map<String, Object> test1 = test.get(0);
//                                        data = test1.get("json_agg");
//                                        test = null;
//                                        test1 = null;
//                                    }
//                                } else {
//                                    data = test;
//                                    test = null;
//                                }
//                            } else {
//                                data = test;
//                                test = null;
//                            }
//                        }
//                    } else {
//                        if (parameters.getValues().size() != 0) {
//                            NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                    jdbcTemplateTransactional.getDataSource());
//                            test = jdbcTemplateObject.queryForList(queryString, parameters);
//                            jdbcTemplateObject = null;
//                            if (isFormattingRequired != null) {
//                                if (isFormattingRequired) {
//                                    if (test.size() > 0) {
//                                        Map<String, Object> test1 = test.get(0);
//                                        data = test1.get("json_agg");
//                                    }
//                                } else {
//                                    data = test;
//                                }
//                            } else {
//                                data = test;
//                            }
//                        } else {
//                            test =
//                                    jdbcTemplateTransactional.queryForList(queryString);
//                            if (isFormattingRequired != null) {
//                                if (isFormattingRequired) {
//                                    if (test.size() > 0) {
//                                        Map<String, Object> test1 = test.get(0);
//                                        data = test1.get("json_agg");
//                                        test = null;
//                                        test1 = null;
//                                    }
//                                } else {
//                                    data = test;
//                                    test = null;
//                                }
//                            } else {
//                                data = test;
//                                test = null;
//                            }
//                        }
//                    }
//                } else {
//                    if (parameters.getValues().size() != 0) {
//                        NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                                jdbcTemplateTransactional.getDataSource());
//                        test = jdbcTemplateObject.queryForList(queryString, parameters);
//                        jdbcTemplateObject = null;
//                        if (isFormattingRequired != null) {
//                            if (isFormattingRequired) {
//                                Map<String, Object> test1 = test.get(0);
//                                data = test1.get("json_agg");
//                                test = null;
//                                test1 = null;
//                            } else {
//                                data = test;
//                                test = null;
//                            }
//                        } else {
//                            data = test;
//                            test = null;
//                        }
//                    } else {
//                        test = jdbcTemplateTransactional.queryForList(queryString);
//                        if (isFormattingRequired != null) {
//                            if (isFormattingRequired) {
//                                if (test.size() > 0) {
//                                    Map<String, Object> test1 = test.get(0);
//                                    data = test1.get("json_agg");
//                                    test = null;
//                                    test1 = null;
//                                }
//                            } else {
//                                data = test;
//                                test = null;
//                            }
//                        } else {
//                            data = test;
//                            test = null;
//                        }
//                    }
//                }
            } catch (PersistenceException e) {
                if (e.getCause().getCause().getMessage().contains("Too Many Records...")) {
                    message = dashboardErrorUtil.getErrorMessage("Too Many Records...");
                } else {
                    message = dashboardErrorUtil.getErrorMessage("Failed Proccessing");
                }
                log.error("Failed to execute dashboard query. Query: [{}], Parameters: [{}], Error: {}",
                        queryString,
                        loggerEncoderUtil.encode(dashboardQueryRequest.toString()),
                        e.getMessage(),
                        e);
            } catch (OutOfMemoryError e) {
                message = dashboardErrorUtil.getErrorMessage("Too Many Records...");
                log.error("Failed to execute dashboard query. Query: [{}], Parameters: [{}], Error: {}",
                        queryString,
                        loggerEncoderUtil.encode(dashboardQueryRequest.toString()),
                        e.getMessage(),
                        e);
            } catch (UncategorizedSQLException e) {
                String error_code = dashboardErrorUtil.extractErrorCode(e.getMessage());

                if(!StringUtils.isBlank(error_code) && dashboardQuery.getDbType()==3)
                {
                    message = dashboardErrorUtil.getErrorMessage(error_code);
                    if (StringUtils.isBlank(message)) {
                        message = dashboardErrorUtil.getErrorMessage("default");
                        log.error("Failed to execute dashboard query. Query: [{}], Parameters: [{}], Error: {}",
                                queryString,
                                loggerEncoderUtil.encode(dashboardQueryRequest.toString()),
                                e.getMessage(),
                                e);
                    }
                }
                else
                {
                    message = StringUtils.substringBetween(e.getCause().getMessage(), "ERROR: ", "\n");
                    if (message != null) {
                        log.info("Failed to execute dashboard query. Query: [{}], Parameters: [{}], Error: {}",
                                queryString,
                                loggerEncoderUtil.encode(dashboardQueryRequest.toString()),
                                e.getMessage(),
                                e);
                    } else {
                        message = dashboardErrorUtil.getErrorMessage("default");
                        log.error("Failed to execute dashboard query. Query: [{}], Parameters: [{}], Error: {}",
                                queryString,
                                loggerEncoderUtil.encode(dashboardQueryRequest.toString()),
                                e.getMessage(),
                                e);
                    }
                }

            } catch (Exception e) {
                message = dashboardErrorUtil.getErrorMessage("default");
                log.error("Failed to execute dashboard query. Query: [{}], Parameters: [{}], Error: {}",
                        queryString,
                        loggerEncoderUtil.encode(dashboardQueryRequest.toString()),
                        e.getMessage(),
                        e);
            }
//            res.setTransposeRequired(dashboardQuery.getTransposeRequired());
//            res.setConvertToJson(isFormattingRequired);

            Instant executionEnded = Instant.now();


            jsonObject.addProperty("ExecutionEnded", executionEnded.toString());

            Duration duration = Duration.between(executionStarted, executionEnded);
            long millis = duration.toMillis();

            // Convert millis to hours, minutes, seconds, milliseconds
            long hours = millis / (1000 * 60 * 60);
            long minutes = (millis / (1000 * 60)) % 60;
            long seconds = (millis / 1000) % 60;
            long milliseconds = millis % 1000;

            String formattedDuration = String.format("%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds);


            jsonObject.addProperty("TotalExecutionTime", formattedDuration);
            jsonObject.addProperty("responseMessage", message);
            activityLogService.addActivity(loggedInUser, iorgid,
                    "dashboard data accessed successfully for dashboard " + dashboardQueryRequest.getDashboardName(),
                    jsonObject.toString());

            return ResponseEntity.ok(new ResultSetResponse(message, data, isFormattingRequired, dashboardQuery.getTransposeRequired(), "COMPLETED", dashboardQueryRequest.getExecutionID(), dashboardQueryRequest.getIuserid(), dashboardQueryRequest.getIorgid()));
        } else {
            activityLogService.addActivity(loggedInUser, iorgid, "Table name does not exist ",
                    "Parameters : " + dashboardQueryRequest);
            log.debug("Exiting getResultSetData Method in " + DataAnalyzerControllerServiceImpl.class
                    + " class with response  : Table name does not exist");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Table name does not exist"),
                    HttpStatus.BAD_REQUEST);
        }
    }



}
