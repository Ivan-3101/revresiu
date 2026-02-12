package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.util.List;


@NotNull
@Data
public class NewWebUserAuditRequest {

    @NotNull
    @NotEmpty(message = "Username Cannot be Empty")
    private String username;

//    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$", message = "Password doesn't meet minmum requirement")
//    @NotNull(message = "Password cannot be null")
//    private String password;

    @Email(message = "Email is not Valid", regexp = "[a-zA-Z0-9\\._]+@[a-zA-Z0-9\\.]+\\.[a-zA-Z]")
    @NotEmpty(message = "Email cannot be empty")
    private String emailid;

    private String contact;

    @Pattern(regexp = "^\\d{10}$", message = "Please provide only number for mobile")
    @Size(min = 10, max = 10)
    private String mobile;
    private String profileimg;

    @NotEmpty(message = "First Name cannot be empty")
    @NotNull(message = "First Name Cannot be Null")
    private String firstname;

    @NotEmpty(message = "Last Name cannot be empty")
    @NotNull(message = "Last Name Cannot be Null")
    private String lastname;
    private String address;
    private String designation;
    private String remark;

    private String action;

    //	@NotEmpty(message="User Permission Request cannot be empty")
//	@NotNull(message="User Permission Request Cannot be Null")
    private UserPermissionRequest userpermissions;

    @NotEmpty(message = "User group cannot be empty")
    @NotNull(message = "User group Cannot be Null")
    private List<UserPermissionRequest> usergroups;

    private List<UserPermissionRequest> usertenants;

    private List<UserPermissionRequest> userworkflows;

    private List<UserPermissionRequest> userclasses;

//	public static NewWebUserAuditRequest  parse(WebUserAudit wua)
//	{
//		NewWebUserAuditRequest nwuar = new NewWebUserAuditRequest();
//		nwuar.setUsername(wua.getVcUserName());
//		nwuar.setPassword(wua.getVcPassword());
//		nwuar.setEmailid(wua.getVcEmailID());
//		nwuar.setContact(wua.getVcContact());
//		nwuar.setMobile(wua.getVcMobile());
//		nwuar.setProfileimg(wua.getVcProfileImg());
//		nwuar.setFirstname(wua.getVcFirstName());
//		nwuar.setLastname(wua.getVcLastName());
//		nwuar.setAddress(wua.getVcAddress());
//		nwuar.setDesignation(wua.getVcDesignation());
//		nwuar.setRemark(wua.getVcRemark());
//		nwuar.setUserpermissions(UserPermissionRequest.parseRole(wua.getUserPermissions()));
//		nwuar.setUsergroup(UserPermissionRequest.parseGroup(wua.getUserGroup()));
//
//		return nwuar;
//	}
//
//	public static NewWebUserAuditRequest  parse(WebUser wu)
//	{
//		NewWebUserAuditRequest nwuar = new NewWebUserAuditRequest();
//		nwuar.setUsername(wu.getVcUserName());
//		nwuar.setPassword(wu.getVcPassword());
//		nwuar.setEmailid(wu.getVcEmailID());
//		nwuar.setContact(wu.getVcContact());
//		nwuar.setMobile(wu.getVcMobile());
//		nwuar.setProfileimg(wu.getVcProfileImg());
//		nwuar.setFirstname(wu.getVcFirstName());
//		nwuar.setLastname(wu.getVcLastName());
//		nwuar.setAddress(wu.getVcAddress());
//		nwuar.setDesignation(wu.getVcDesignation());
//		nwuar.setUserpermissions(UserPermissionRequest.parseRole(wu.getUserPermissions()));
//		nwuar.setUsergroup(UserPermissionRequest.parseGroup(wu.getUserGroup()));
//		return nwuar;
//	}

    @Override
    public String toString() {
        return "NewWebUserAuditRequest{" +
                "username='" + username + '\'' +
                ", emailid='" + emailid + '\'' +
                ", contact='" + contact + '\'' +
                ", mobile='" + mobile + '\'' +
                ", profileimg='" + profileimg + '\'' +
                ", firstname='" + firstname + '\'' +
                ", lastname='" + lastname + '\'' +
                ", address='" + address + '\'' +
                ", designation='" + designation + '\'' +
                ", remark='" + remark + '\'' +
                ", userpermissions=" + userpermissions +
                ", usergroup=" + usergroups +
                '}';
    }
}
