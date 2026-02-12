package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;

import lombok.Data;

//import java.util.ArrayList;
//import java.util.Deque;
//import java.util.List;

@Builder
@Data
public class RulesVO {

    private String rulename;
    private Integer id;
    private String order;
    private Boolean active;
    private String params;

//    public static RulesVO parse(Rules rules)
//    {
//        RulesVO res = new RulesVO();
//        res.setId(rules.getIRuleID());
//        res.setRulename(rules.getVcRuleName());
//        res.setOrder(rules.getVcRuleOrder());
//        res.setActive(rules.isBActive());
//        return res;
//    }
//
//    public static List<RulesVO> parse(Deque<Rules> rulesDeque)
//    {
//        List<RulesVO> res = new ArrayList<>();
//        for(Rules rule: rulesDeque)
//        {
//            RulesVO temp = new RulesVO();
//            temp.setRulename(rule.getVcRuleName());
//            temp.setId(rule.getIRuleID());
//            temp.setOrder(rule.getVcRuleOrder());
//            temp.setActive(rule.isBActive());
//            res.add(temp);
//        }
//        return res;
//    }
//
//    public static RuleVOWithSelectedPosition parse(Deque<Rules> rulesDeque, Rules selected)
//    {
//        RuleVOWithSelectedPosition res = new RuleVOWithSelectedPosition();
//        List<RulesVO> listTemp = new ArrayList<>();
//        int index = 0;
//        Integer selectedPostion = null;
//        for(Rules rule: rulesDeque)
//        {
//            RulesVO temp = new RulesVO();
//            temp.setRulename(rule.getVcRuleName());
//            temp.setId(rule.getIRuleID());
//            temp.setOrder(rule.getVcRuleOrder());
//            temp.setActive(rule.isBActive());
//            if(rule.getIRuleID()==selected.getIRuleID())
//            {
//                selectedPostion =  index;
//            }
//            listTemp.add(temp);
//            index++;
//        }
//        if(!selected.isBActive())
//        {
//            listTemp.add(RulesVO.parse(selected));
//            res.setSelected(listTemp.size()-1);
//        }
//        else
//        {
//            res.setSelected(selectedPostion);
//        }
//        res.setRulesVOList(listTemp);
//        return res;
//    }
}
