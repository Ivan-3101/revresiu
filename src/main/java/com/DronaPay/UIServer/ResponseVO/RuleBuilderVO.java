package com.DronaPay.UIServer.ResponseVO;

import java.util.List;

import com.DronaPay.UIServer.response.RuleBlocksReponse;

import lombok.Data;

@Data
public class RuleBuilderVO {
    RuleBlocksReponse metadataObservations;
    List<RuleAvailableVO> rulesDraft;
    List<RuleAvailableVO> rulesAvailable;
    List<DropdownWithObject> workflowList;
}
