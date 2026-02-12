package com.DronaPay.UIServer.response;

import java.util.List;

import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.requests.UserPermissionRequest;

import lombok.Data;

@Data
public class UserRoleGroupWorkflowClassMapResponse {

	List<UserPermissionRequest> role;
	List<UserPermissionRequest> group;
	List<UserPermissionRequest> workflow;
	List<UserPermissionRequest> transactionClass;
}
