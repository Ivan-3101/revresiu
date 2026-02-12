package com.DronaPay.UIServer.VOMapper;


import com.DronaPay.UIServer.ResponseVO.ListDropDownVO;
import com.DronaPay.UIServer.model.ValidationFieldsList;


import java.util.ArrayList;
import java.util.List;

public class ListDropDownVoMapper {

	public static List<ListDropDownVO> parse(List<ValidationFieldsList> validationFieldsList) {
		List<ListDropDownVO> res = new ArrayList<>();
		for (ValidationFieldsList vfl : validationFieldsList) {
			ListDropDownVO temp = ListDropDownVO.builder()
					.label(vfl.getVcFieldDisplayName())
					.value(vfl.getVcInternalField())
					.scorePath(vfl.getVcScoreApiPath())
					.validation(vfl.getVcValidation())
					.build();
			res.add(temp);
		}
		return res;
	}



}
