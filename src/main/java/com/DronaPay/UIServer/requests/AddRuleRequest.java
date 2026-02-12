package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.ResponseVO.RulesVO;
import lombok.Getter;

import java.time.ZonedDateTime;
import java.util.List;

@Getter
public class AddRuleRequest {

    private Integer itenantId;
    private Boolean active;
    private Integer classname;
    private Integer productid;
    private String ruledescription;
    private String rulename;
    private String ruledetail;
    private Integer decisionid;
    private ZonedDateTime startdate;
    private List<RulesVO> sequence;
    private String params;
}
