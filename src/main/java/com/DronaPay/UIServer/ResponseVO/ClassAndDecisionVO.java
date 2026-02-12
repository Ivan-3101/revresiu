package com.DronaPay.UIServer.ResponseVO;


import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ClassAndDecisionVO {
    private Integer value;
    private String label;
    private Integer productid;
    private DecisionVo decisionVO;

//    public static List<ClassAndDecisionVO> parse(List<TransactionClasses> transactionClassesList)
//    {
//        List<ClassAndDecisionVO> res = new ArrayList<>();
//        for(TransactionClasses tcl : transactionClassesList)
//        {
//            ClassAndDecisionVO temp = new ClassAndDecisionVO();
//            temp.setValue(tcl.getIClassID());
//            temp.setLabel(tcl.getVcClassName());
//            temp.setProductid(tcl.getIProductID().getIProductID());
//            temp.setDecisionVO(DecisionVo.parse(tcl.getIDecisionID()));
//            res.add(temp);
//        }
//        return res;
//    }
}
