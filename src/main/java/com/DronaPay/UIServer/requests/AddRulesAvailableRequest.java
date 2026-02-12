package com.DronaPay.UIServer.requests;

import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class AddRulesAvailableRequest {
    private Boolean bactive;
    private Boolean bcustom;
    private Boolean bpayee;
    private Boolean bpayer;
    private Boolean btransaction;
    private String ruledimension;
    private String rulestate;
    private String vclabel;

    @Pattern(
    regexp = "^[a-zA-Z0-9 ,_'/\\\\&><=+().:%@#-]+$",
    message = "Rule description can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), " +
              "empty space, single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), " +
              "greater than (>), less than (<), equals (=), plus (+), brackets (), colon (:), percentage (%), " +
              "at symbol (@), hash (#), and dot (.)"
)
private String vcruledescription;

@Pattern(
    regexp = "^[a-zA-Z0-9 ,_'/\\\\&><=+().:%@#-]+$",
    message = "Rule name can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), " +
              "empty space, single inverted commas ('), forward slash (/), backward slash (\\), ampersand (&), " +
              "greater than (>), less than (<), equals (=), plus (+), brackets (), colon (:), percentage (%), " +
              "at symbol (@), hash (#), and dot (.)"
)
private String vcrulename;


    private String vcruleparams;
    private String vcruletype;
    private String vcruledetail;
    private Integer tenantId;
}
