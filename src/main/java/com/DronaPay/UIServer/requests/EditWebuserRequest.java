package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.*;
import lombok.Getter;
import org.hibernate.validator.constraints.Range;

import java.util.List;

@Getter
public class EditWebuserRequest {

    private String vcorgid;
    private Integer id;
    private Boolean audit;

//    @NotEmpty
//    @NotNull(message = "User name cannot be null")
//    @Range(min = 1, max = 64, message = "Username should be between 1 and 64 characters")
//    private String username;

//    @NotEmpty
//    @NotNull(message = "Password cannot be null")
//    private String password;

//    @Range(min = 1, max = 64, message = "Email should be between 1 and 64 characters")
//    @Email(message = "Please Enter Valid Email Address", regexp = "[a-zA-Z0-9\\._]+@[a-zA-Z0-9\\.]+\\.[a-zA-Z]")
    @NotEmpty(message = "User name cannot be empty")
    @NotNull(message = "User name cannot be null")
    @Size(min = 1, max = 64, message = "Email should be between 1 and 64 characters")
    @Email(message = "Please Enter Valid Email Address")
    private String emailid;

//    @Range(min = 10, max = 10, message = "Contact number should be just 10 digit")
    @Pattern(regexp = "^(\\d{10})?$", message = "Please provide only number for contact")
    private String contact;

//    @Range(min = 10, max = 10, message = "Contact number should be just 10 digit")
    @Pattern(regexp = "^(\\d{10})?$", message = "Please provide only number for mobile")
    private String mobile;

    private String profileimg;

    @NotEmpty(message = "First Name cannot be empty")
    @NotNull(message = "First Name cannot be null")
    private String firstname;

    @NotEmpty(message = "Last Name cannot be empty")
    @NotNull(message = "Last Name cannot be null")
    private String lastname;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]*$", message = "Address can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), empty space, asterisk (*), hash (#), percentage (%), " +
            "single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), and dot (.)")
    private String address;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@().-]*$", message = "Designation can only contain alphabets, numbers, hyphen (-), " +
            "comma (,), underscore (_), at (@), empty space, brackets (), and dot (.)")
    private String designation;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Maker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), empty space, asterisk (*), hash (#), percentage (%), " +
            "single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), and dot (.)")
    private String remark;

//    @NotEmpty(message = "User Permission Request cannot be empty")
//    @NotNull(message = "User Permission Request cannot be null")
    private UserPermissionRequest userpermissions;
    private List<UserPermissionRequest> usergroups;
    
    private List<Integer> usertenants;

    // @NotEmpty(message = "User workflow cannot be empty")
//    @NotNull(message = "User workflow Cannot be Null")
    private List<UserPermissionRequest> userworkflows;

//    @NotNull(message = "User classes Cannot be Null")
    private List<UserPermissionRequest> userclasses;

//	public static EditWebuserRequest  parse(WebUserAudit wua)
//	{
//		EditWebuserRequest nwuar = new EditWebuserRequest();
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
//		nwuar.setUserpermissions(UserPermissionRequestMapper.parseRole(wua.getUserPermissions()));
//		nwuar.setUsergroup(UserPermissionRequestMapper.parseGroup(wua.getUserGroup()));
//
//		return nwuar;
//	}
//
//	public static EditWebuserRequest  parse(WebUser wu)
//	{
//		EditWebuserRequest nwuar = new EditWebuserRequest();
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
//		nwuar.setUserpermissions(UserPermissionRequestMapper.parseRole(wu.getUserPermissions()));
//		nwuar.setUsergroup(UserPermissionRequestMapper.parseGroup(wu.getUserGroup()));
//		return nwuar;
//	}

    public String getUsername() {
        return emailid;
    }

    @Override
    public String toString() {
        return "EditWebuserRequest{" +
                "id=" + id +
                ", audit=" + audit +
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
