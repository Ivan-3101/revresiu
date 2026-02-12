package com.DronaPay.UIServer.response;

import java.util.List;

import com.DronaPay.UIServer.ResponseVO.AppUser;
import lombok.Data;

@Data
public class AppUsers {

	private Boolean view;
	private Boolean add;
	private Boolean approve;
	private List<AppUser> appUser;
}
