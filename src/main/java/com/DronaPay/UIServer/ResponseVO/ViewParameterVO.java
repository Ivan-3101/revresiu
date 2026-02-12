package com.DronaPay.UIServer.ResponseVO;

import lombok.Builder;

import lombok.Data;

//import java.util.ArrayList;
//import java.util.List;

@Builder
@Data
public class ViewParameterVO {
    private String parameterName;
    private String dataType;
    private String description;
    private Integer iparameterID;
    private Boolean added;


//    public static List<ViewParameterVO> parse(List<Parameter> pl)
//    {
//        List<ViewParameterVO> res = new ArrayList<>();
//        for(Parameter p : pl)
//        {
//            ViewParameterVO temp = new ViewParameterVO();
//            temp.setParameterName(p.getVcParameterName());
//            temp.setDataType(p.getVcDataType());
//            temp.setDescription(p.getVcDescription());
//            temp.setAdded(false);
//            res.add(temp);
//        }
//        return res;
//    }
}
