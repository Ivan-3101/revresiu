package com.DronaPay.UIServer.VOMapper;

import java.util.ArrayList;
import java.util.List;

import com.DronaPay.UIServer.ResponseVO.ViewParameterVO;
import com.DronaPay.UIServer.model.Parameter;

public class ViewParameterVOMapper {

	public static List<ViewParameterVO> parse(List<Parameter> pl) {
		List<ViewParameterVO> res = new ArrayList<>();
		for (Parameter p : pl) {
			ViewParameterVO temp = ViewParameterVO.builder().parameterName(p.getVcParameterName())
					.dataType(p.getVcDataType()).description(p.getVcDescription()).added(false).iparameterID(p.getIParameterID()).build();
			res.add(temp);
		}
		return res;
	}

}
