package com.DronaPay.UIServer.VOMapper;

import java.util.ArrayList;
import java.util.List;

import com.DronaPay.UIServer.ResponseVO.ClassAndDecisionVO;
import com.DronaPay.UIServer.model.TransactionClassesUI;

public class ClassAndDecisionVOMapper {

	// public static List<ClassAndDecisionVO> parse(List<TransactionClassesUI> transactionClassesList) {
	// 	List<ClassAndDecisionVO> res = new ArrayList<>();
	// 	for (TransactionClassesUI tcl : transactionClassesList) {
	// 		ClassAndDecisionVO temp = ClassAndDecisionVO.builder().value(tcl.getIclassID()).label(tcl.getVcClassName())
	// 				.productid(tcl.getIProductID().getIProductID())
	// 				.decisionVO(DecisionVoMapper.parse(tcl.getIDecisionID())).build();
	// 		res.add(temp);
	// 	}
	// 	return res;
	// }

}
