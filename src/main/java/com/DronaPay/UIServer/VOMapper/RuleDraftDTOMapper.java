package com.DronaPay.UIServer.VOMapper;
import java.util.function.Function;

import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.ResponseVO.RuleAvailableVO;
import com.DronaPay.UIServer.model.RulesDraftUi;

@Component
public class RuleDraftDTOMapper implements Function<RulesDraftUi, RuleAvailableVO> {

    @Override
    public RuleAvailableVO apply(RulesDraftUi t) {
        return RuleAvailableVO.builder()
        .name(t.getVcRuleName())
        .description(t.getVcRuleDescription())
        .label(t.getVcLabel())
        .vcruledetail(t.getVcRuleDetail())
        .vcruleparams(t.getVcRuleParams())
        .build();
    }
    
}
