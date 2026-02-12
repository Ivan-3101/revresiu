package com.DronaPay.UIServer.requests;

import lombok.Data;


@Data
public class UserPermissionRequest {
	private Integer value;
	private String label;
	private Integer itenantId;
}
