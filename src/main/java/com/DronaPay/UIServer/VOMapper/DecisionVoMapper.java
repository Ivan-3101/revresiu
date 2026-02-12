package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.ResponseVO.DecisionVo;
import com.DronaPay.UIServer.model.DecisionUi;
import com.DronaPay.UIServer.model.DecisionUiAudit;

import java.time.ZonedDateTime;

public class DecisionVoMapper {

    public static DecisionVo parse(DecisionUi decision) {
        DecisionVo res = DecisionVo.builder()
                .label(decision.getVcDecisionName())
                .value(decision.getIDecisionID())
                .build();
        return res;
    }

    public static DecisionUiAudit parseToAudit(DecisionUi decision) {
        DecisionUiAudit decisionUiAudit = new DecisionUiAudit();
        decisionUiAudit.setBActive(decision.isBactive());
        decisionUiAudit.setBclosed(false);
        decisionUiAudit.setDtEntryDatetime(ZonedDateTime.now());
        decisionUiAudit.setDtEntryStamp(ZonedDateTime.now());
        decisionUiAudit.setIdecisionUiId(decision.getIDecisionID());
        decisionUiAudit.setIProductID(decision.getIProductID());
        decisionUiAudit.setIRecordStatus(1);
        decisionUiAudit.setIstatus(null);
        decisionUiAudit.setVcAction("M");
        decisionUiAudit.setVcDecisionDetail(decision.getVcDecisionDetail());
        decisionUiAudit.setVcDecisionMapInfo(decision.getVcDecisionMapInfo());
        decisionUiAudit.setVcDecisionName(decision.getVcDecisionName());
        decisionUiAudit.setVcResultParams(decision.getVcResultParams());
        decisionUiAudit.setItenantId(decision.getItenantId());
        return decisionUiAudit;
    }

}
