package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class UnlockRequest {

	private Integer id;
	private Boolean audit;
	private String remark;
	private String vcorgid;
}
