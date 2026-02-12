package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class GetAppUserDetailsRequest {

	private Integer id;
	private Boolean audit;
	private String vcorgid;
}
