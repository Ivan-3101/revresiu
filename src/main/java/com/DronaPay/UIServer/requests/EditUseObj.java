package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.Getter;

@Getter
public class EditUseObj {


    private String vcFirstName;
    private String vcLastName;
    private String vcEmailID;
    private String vcContact;
    private String vcMobile;
    private String vcProfileImg;
    private String timezone;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]*$", message = "Address can only contain alphabets, numbers, " +
            "hyphen (-), comma (,), underscore (_), rate (@), empty space, asterisk (*), hash (#), percentage (%), " +
            "single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), and dot (.)")
    private String vcAddress;

    @Pattern(regexp = "^[a-zA-Z0-9 ,_@().-]*$", message = "Designation can only contain alphabets, numbers, hyphen (-), " +
            "comma (,), underscore (_), rate (@), empty space, brackets (), and dot (.)")
    private String vcDesignation;
    
}
