package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class EditAiAgentRequest {

    @NotNull(message = "Agent id cannot be null")
    private Integer iagentId;

    @NotBlank(message = "Agent name cannot be blank")
    @NotNull(message = "Agent name cannot be blank")
    @NotEmpty(message = "Agent name cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ._\\-/\\\\&()\\[\\]{}]+$", message = "Agent name can only contain letters, numbers, space, " +
            "dot (.), underscore (_), hyphen (-), forward slash (/), backward slash (\\), ampersand (&) and brackets")
    private String agentName;

    @NotBlank(message = "Agent description cannot be blank")
    @NotNull(message = "Agent description cannot be blank")
    @NotEmpty(message = "Agent description cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Agent description can only contain letters, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quote ('), " +
            "slashes (/ or \\), ampersand (&) and dot (.)")
    private String agentDescription;

    @NotBlank(message = "Initiation cannot be blank")
    @NotNull(message = "Initiation cannot be null")
    @NotEmpty(message = "Initiation cannot be null")
    private String initiation;

    @NotBlank(message = "Policy cannot be blank")
    @NotNull(message = "Policy cannot be null")
    @NotEmpty(message = "Policy cannot be null")
    private String policy;

    @NotBlank(message = "Prompt cannot be blank")
    @NotNull(message = "Prompt cannot be null")
    @NotEmpty(message = "Prompt cannot be null")
    private String prompt;

    private JsonNode config;

    @NotBlank(message = "Maker remark cannot be blank")
    @NotNull(message = "Maker remark cannot be blank")
    @NotEmpty(message = "Maker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.()\\[\\]{}-]+$", message = "Maker remark can only contain letters, numbers, " +
            "hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quote ('), " +
            "slashes (/ or \\), ampersand (&), dot (.) and brackets")
    private String makerRemark;

    @NotNull(message = "Tenant cannot be blank")
    private Integer itenantId;

    @NotNull(message = "Audit cannot be null")
    private Boolean audit;

}
