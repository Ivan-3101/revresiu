package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.ResponseVO.RulesVO;
import lombok.Data;
import lombok.Getter;

import java.util.Date;
import java.util.List;

@Getter
public class EditRuleRequest {
    private Integer id;
    private Boolean active;
    private String ruledescription;
    private String rulename;
    private String ruledetail;
    private Date startdate;
    private List<RulesVO> sequence;
    private String params;
}
