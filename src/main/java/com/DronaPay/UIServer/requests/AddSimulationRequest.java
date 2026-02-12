package com.DronaPay.UIServer.requests;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;

@Getter
public class AddSimulationRequest {

    @Pattern(regexp = "^[a-zA-Z0-9 ,_/%\\\\.-]+$", message = "Description can only contain alphabets, numbers, underscore (_), hyphen (-), empty space, percentage (%), forward slash (/), backward slash (\\), comma (,) and dot (.)")
    private String note;

    private Integer idecisionid;
    private Integer iruleid;
    private Boolean isbatch;
    private Integer itenantid;
}
