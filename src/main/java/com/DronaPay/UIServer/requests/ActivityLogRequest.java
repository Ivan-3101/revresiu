package com.DronaPay.UIServer.requests;

import lombok.Data;
import lombok.Getter;

@Getter
public class ActivityLogRequest {

	private String activity;
	private String parameters;
}
