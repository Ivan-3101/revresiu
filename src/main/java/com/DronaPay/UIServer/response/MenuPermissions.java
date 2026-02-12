package com.DronaPay.UIServer.response;

import lombok.Data;

@Data
public class MenuPermissions {

	private boolean add = false;
	private boolean edit = false;
	private boolean delete = false;
	private boolean view = false;
	private boolean publish = false;
	private boolean approve = false;
	
}
