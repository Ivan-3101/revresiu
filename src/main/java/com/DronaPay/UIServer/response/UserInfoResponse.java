package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.requests.UserPermissionRequest;
import lombok.Data;

import java.time.ZonedDateTime;
import java.util.List;

@Data
public class UserInfoResponse {

    private Integer iuserid;
    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String contact;
    private String mobile;
    private String profileImg;
    private String address;
    private String designation;
    private String timezone;
    private ZonedDateTime lastLoginTime;
    private Boolean bView;
    private List<UserPermissionRequest> tenantsDropdown;
    private String vcOrgId;

//	public static UserInfoResponse parse(WebUser webUser)
//	{
//		UserInfoResponse temp = new UserInfoResponse();
//		temp.setFirstName(webUser.getVcFirstName());
//		temp.setLastName(webUser.getVcLastName());
//		temp.setUserName(webUser.getVcUserName());
//		temp.setEmail(webUser.getVcEmailID());
//		temp.setContact(webUser.getVcContact());
//		temp.setMobile(webUser.getVcMobile());
//		temp.setProfileImg(webUser.getVcProfileImg());
//		temp.setAddress(webUser.getVcAddress());
//		temp.setDesignation(webUser.getVcDesignation());
//		temp.setTimezone(webUser.getTimeZone());
//		return temp;
//	}
}
