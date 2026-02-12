package com.DronaPay.UIServer.VOMapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.DronaPay.UIServer.ResponseVO.ParameterTypeVO;
import com.DronaPay.UIServer.ResponseVO.ViewParameterVO;

public class ParameterTypeVOMapper {

	public static List<ParameterTypeVO> parse(HashMap<String, List<ViewParameterVO>> prl) {
		List<ParameterTypeVO> res = new ArrayList<>();
		int i = 1;
		for (Map.Entry<String, List<ViewParameterVO>> pr : prl.entrySet()) {
			ParameterTypeVO tcr = ParameterTypeVO.builder().value(i).label(pr.getKey()).parameters(pr.getValue())
					.build();

			res.add(tcr);
			i++;
		}
		return res;
	}

}
