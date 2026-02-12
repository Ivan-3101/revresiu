package com.DronaPay.UIServer.VOMapper;
import java.util.function.Function;

import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.ResponseVO.RuleAvailableVO;
import com.DronaPay.UIServer.model.RulesAvailableUi;

@Component
public class RuleAvailableDTOMapper implements Function<RulesAvailableUi, RuleAvailableVO> {

    @Override
    public RuleAvailableVO apply(RulesAvailableUi t) {
        return RuleAvailableVO.builder()
        .name(t.getVcRuleName())
        .description(t.getVcRuleDescription())
        .label(t.getVcLabel())
        .vcruledetail(t.getVcRuleDetail())
        .vcruleparams(t.getVcRuleParams())
        .build();
    }
    
}
