package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.Getter;

@Getter
public class DeleteRequest {

	private Integer id;
	private Boolean audit;

	@Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Maker remark can only contain alphabets, numbers, " +
			"hyphen (-), comma (,), underscore (_), at (@), empty space, asterisk (*), hash (#), percentage (%), " +
			"single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), and dot (.)")
	private String remark;

	private String vcorgid;
}
