package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.*;
import lombok.Getter;
import org.hibernate.validator.constraints.Range;

import java.util.List;


@NotNull
@Getter
public class NewWebUserAuditRequestGt {

//    @NotNull
//    @NotEmpty(message = "Username Cannot be Empty")
//    @Range(min = 1, max = 64, message = "Username should be between 1 and 64 characters")
//
//    private String username;

    //    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$", message = "Password doesn't meet minimum requirement")
//    @NotNull(message = "Password cannot be null")
//    private String password;


//    @Range(min = 1, max = 64, message = "Email should be between 1 and 64 characters")
//    @Email(message = "Email is not Valid", regexp = "[a-zA-Z0-9\\._]+@[a-zA-Z0-9\\.]+\\.[a-zA-Z]")
    @NotNull(message = "Email cannot be null")
    @Size(min = 1, max = 64, message = "Email should be between 1 and 64 characters")
    @Email(message = "Email is not valid")
    @NotEmpty(message = "Email cannot be empty")
    private String emailid;

    private String contact;

    @Pattern(regexp = "^(\\d{10})?$", message = "Please provide only number for mobile")
//    @Size(min = 10, max = 10)
    private String mobile;

    private String profileimg;

    @NotEmpty(message = "First Name cannot be empty")
    @NotNull(message = "First Name Cannot be Null")
    private String firstname;

    @NotEmpty(message = "Org id cannot be empty")
    @NotNull(message = "Org id Cannot be Null")
    private String vcorgid;

    @NotEmpty(message = "Last Name cannot be empty")
    @NotNull(message = "Last Name Cannot be Null")
    private String lastname;

    @Pattern(
    regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.\\-\\(\\)\\+~!=:\\$`\\?\"}]*$",
    message = "Address can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), empty space, " +
              "asterisk (*), hash (#), percentage (%), single inverted commas ('), forward slash (/), backward slash (\\), " +
              "ampersand (&), dot (.), left/right parentheses (()), plus (+), tilde (~), exclamation (!), equals (=), " +
              "colon (:), dollar ($), backtick (`), question mark (?), double quote (\"), and right curly brace (})"
)
private String address;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@().-]*$", message = "Designation can only contain alphabets, numbers, hyphen (-), " +
            "comma (,), underscore (_), at (@), empty space, brackets (), and dot (.)")
    private String designation;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Maker remark can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), empty space, asterisk (*), hash (#), percentage (%), " +
            "single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), and dot (.)")
    private String remark;

    //	@NotEmpty(message="User Permission Request cannot be empty")
//	@NotNull(message="User Permission Request Cannot be Null")
    private UserPermissionRequest userpermissions;

//    @NotEmpty(message = "User group cannot be empty")
//    @NotNull(message = "User group Cannot be Null")
    private List<UserPermissionRequest> usergroups;

//    @NotEmpty(message = "User tenant cannot be empty")
//    @NotNull(message = "User tenant Cannot be Null")
    private List<Integer> usertenants;

    // @NotEmpty(message = "User workflow cannot be empty")
//    @NotNull(message = "User workflow Cannot be Null")
    private List<UserPermissionRequest> userworkflows;

//    @NotNull(message = "User classes Cannot be Null")
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

    public String getUsername() {
        return emailid;
    }

    @Override
    public String toString() {
        return "NewWebUserAuditRequest{" +

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
