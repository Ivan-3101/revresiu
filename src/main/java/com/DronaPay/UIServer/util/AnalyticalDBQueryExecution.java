package com.DronaPay.UIServer.util;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAccessor;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.DronaPay.UIServer.Constants.Enum.DatabaseType;
import jakarta.annotation.PostConstruct;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.response.QueryParams;
import com.DronaPay.UIServer.service.ControllerService.Dashboards.DataAnalyzerControllerServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AnalyticalDBQueryExecution {

//    @Qualifier("jdbcAnalyticsService")
//    @Autowired
//    private JdbcTemplate jdbcTemplateAnalytics;

    private Map<DatabaseType, JdbcTemplate> jdbcTemplateMap;

    @Autowired
    public AnalyticalDBQueryExecution(Map<DatabaseType, JdbcTemplate> jdbcTemplateMap) {
        this.jdbcTemplateMap = jdbcTemplateMap;
    }

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    public List<Map<String, Object>> executeQueryOnAnalytic(String query, List<QueryParams> params) {
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        String temp = null;
        List<Map<String, Object>> data = new ArrayList<>();
        JdbcTemplate selectedJdbcTemplate = jdbcTemplateMap.get(DatabaseType.POSTGRESQL_ANALYTICS);
        NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
                selectedJdbcTemplate.getDataSource());
//        NamedParameterJdbcTemplate jdbcTemplateObject = new NamedParameterJdbcTemplate(
//                jdbcTemplateAnalytics.getDataSource());

        for (QueryParams param : params) {
            switch (param.getParameterType()) {
                case "Integer":
                    parameters.addValue(param.getParameterName(),
                            Integer.parseInt(param.getValue().toString().split("\\.")[0]));
                    break;
                case "String":
                    parameters.addValue(param.getParameterName(), (String) param.getValue());
                    break;
                case "Boolean":
                    parameters.addValue(param.getParameterName(), (Boolean) param.getValue());
                    break;
                case "Date":
                    TemporalAccessor ta = DateTimeFormatter.ISO_ZONED_DATE_TIME
                            .parse((String) param.getValue());
                    Instant i = Instant.from(ta);
                    Date d = Date.from(i);
                    try {
                        parameters.addValue(param.getParameterName(), d);
                    } catch (Exception e) {
                        log.error(e.toString());
                    }
                    break;

                case "Calculate_Date":
                    Instant instant = Instant.parse(param.getValue().toString());
                    LocalDateTime localDateTime = instant.atZone(ZoneId.systemDefault()).toLocalDateTime();

                    if (param.getCalcType().equals("substract")) {
                        switch (param.getCalcUnit()) {
                            case "DAYS":
                                parameters.addValue(param.getParameterName(),
                                        localDateTime.minusDays(Long.parseLong(param.getCalcValue().toString()))
                                                .toLocalDate());
                                break;
                            case "WEEKS":
                                parameters.addValue(param.getParameterName(),
                                        localDateTime.minusWeeks(Long.parseLong(param.getCalcValue().toString()))
                                                .toLocalDate());
                                break;
                            case "MONTHS":
                                parameters.addValue(param.getParameterName(),
                                        localDateTime.minusMonths(Long.parseLong(param.getCalcValue().toString()))
                                                .toLocalDate());
                                break;
                            case "YEARS":
                                parameters.addValue(param.getParameterName(),
                                        localDateTime.minusYears(Long.parseLong(param.getCalcValue().toString()))
                                                .toLocalDate());
                                break;
                        }

                    } else if (param.getCalcType().equals("add")) {

                        switch (param.getCalcUnit()) {
                            case "DAYS":
                                parameters.addValue(param.getParameterName(),
                                        localDateTime.plusDays(Long.parseLong(param.getCalcValue().toString()))
                                                .toLocalDate());
                                break;

                            case "WEEKS":
                                parameters.addValue(param.getParameterName(),
                                        localDateTime.plusWeeks(Long.parseLong(param.getCalcValue().toString()))
                                                .toLocalDate());
                                break;
                            case "MONTHS":
                                parameters.addValue(param.getParameterName(),
                                        localDateTime.plusMonths(Long.parseLong(param.getCalcValue().toString()))
                                                .toLocalDate());
                                break;
                            case "YEARS":
                                parameters.addValue(param.getParameterName(),
                                        localDateTime.plusYears(Long.parseLong(param.getCalcValue().toString()))
                                                .toLocalDate());
                                break;
                        }

                    } else {
                        parameters.addValue(param.getParameterName(), param.getCalcValue());
                    }
                    break;

                case "DateRange":
                    ArrayList<String> myList = (ArrayList<String>) param.getValue();
                    LocalDateTime startLocalDate = LocalDate
                            .parse(myList.get(0),
                                    DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX"))
                            .atTime(LocalTime.MAX);
                    LocalDateTime endLocalDate = LocalDate
                            .parse(myList.get(1),
                                    DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX"))
                            .atTime(LocalTime.MAX);
                    parameters.addValue("StartDate", startLocalDate);
                    parameters.addValue("EndDate", endLocalDate);

                    break;
                case "TableName":
                    temp = query;
                    temp = temp.replace(":" + param.getParameterName(), (String) param.getValue());
                    query = temp;
                    break;
                case "WhereStatement":
                    temp = query;
                    String value = param.getValue() != null ? (String) param.getValue() : "";
                    if (value == null || value.contains(";")) {
                        log.debug("Exiting getResultSetData Method in "
                                + DataAnalyzerControllerServiceImpl.class
                                + " class with response  : Malicious where clause");

                    }

                    String whereClause = StringUtils.substringBetween(temp.toLowerCase(), "from",
                            param.getParameterName().toLowerCase());
                    log.info("where clause extracted " + loggerEncoderUtil.encode(whereClause));
                    if (value.isEmpty() || value.isBlank()) {
                        temp = temp.replace(":" + param.getParameterName(), "");
                    } else if (whereClause.contains("where")) {
                        temp = temp.replace(":" + param.getParameterName(), "and " + value);
                    } else {
                        temp = temp.replace(":" + param.getParameterName(), "where " + value);
                    }
                    query = temp;
                    log.info("Query generated " + loggerEncoderUtil.encode(query));
                    break;
            }
        }
        log.info("Query generated " + loggerEncoderUtil.encode(query));

        log.info("params generated " + loggerEncoderUtil.encode(parameters.toString()));

        data = jdbcTemplateObject.queryForList(query, parameters);
        log.debug("data obtained from query " + data);
        jdbcTemplateObject = null;

        return data;
    }

}
