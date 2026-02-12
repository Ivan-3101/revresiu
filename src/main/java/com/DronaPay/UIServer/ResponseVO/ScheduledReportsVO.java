package com.DronaPay.UIServer.ResponseVO;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
@Data
public class ScheduledReportsVO {
    private Integer reportId;
    List<Map<String, Object>> filters;
    private List<String> emailList;
    private List<String> vcusername;
    private Integer day;
    private String frequency;
    private String time;
    private String name;
    private LocalDateTime latestSentTimestamp;
    private Boolean active;
    private Integer availableReportId;
    private String menuName;
    private String subMenuName;
    private Integer itenantId;
    private String tenantName;
}
