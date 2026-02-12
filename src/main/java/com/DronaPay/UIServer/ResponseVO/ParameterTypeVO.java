package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;
import lombok.Data;

//import java.util.ArrayList;
//import java.util.HashMap;
import java.util.List;
//import java.util.Map;

@Builder
@Data
public class ParameterTypeVO {

    private Integer value;
    private String label;
    private List<ViewParameterVO> parameters;

//    public static List<ParameterTypeVO> parse(HashMap<String, List<ViewParameterVO>> prl)
//    {
//        List<ParameterTypeVO> res = new ArrayList<>();
//        int i = 1;
//        for(Map.Entry<String, List<ViewParameterVO>> pr : prl.entrySet())
//        {
//            ParameterTypeVO tcr = new ParameterTypeVO();
//            tcr.setValue(i);
//            tcr.setLabel(pr.getKey());
//            tcr.setParameters(pr.getValue());
//            res.add(tcr);
//            i++;
//        }
//        return res;
//    }
}
