package com.DronaPay.UIServer.response;

import java.util.ArrayList;
import java.util.List;

import com.DronaPay.UIServer.model.RoleDesc;
import com.DronaPay.UIServer.model.WebUser;

import lombok.Data;

// @Data
// public class RoleResponse {

// 	private Integer value;
// 	private String label;
// 	private Integer itenantId;

// 	public static List<RoleResponse> parse(List<RoleDesc> rdl, WebUser user) {
// 		List<RoleResponse> res = new ArrayList<>();
// 		for (RoleDesc rd : rdl) {
// 			if (user.getIuserID() != 1 && user.getIuserID() != 2) {
// 				if (!rd.getVcRoleName().equals("God")) {
// 					RoleResponse temp = new RoleResponse();
// 					temp.setValue(rd.getIRoleID());
// 					temp.setLabel(rd.getVcRoleName());
// 					temp.setItenantId(rd.getItenantId());
// 					res.add(temp);
// 				}

// 			} else {
// 				RoleResponse temp = new RoleResponse();
// 				temp.setValue(rd.getIRoleID());
// 				temp.setLabel(rd.getVcRoleName());
// 				temp.setItenantId(rd.getItenantId());
// 				res.add(temp);
// 			}

// 		}
// 		return res;
// 	}
// }
