package com.DronaPay.UIServer.requests;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;

@Getter
public class AddTransactionClassRequest {

    @NotNull(message = "Class name cannot be blank")
    @NotBlank(message = "Class name cannot be blank")
    @NotEmpty(message = "Class name cannot be blank")
        @Pattern(
        regexp = "^[a-zA-Z0-9 _\\-~/+\\\\]+$",
        message = "Class name can only contain alphabets, numbers, space, underscore (_), hyphen (-), tilde (~), forward slash (/), plus (+), and backslash (\\)"
        )
        private String transactionIdentifier;


    private Integer defaultDecisionId;
    @NotNull(message = "Product Id cannot be blank")
    private Integer productId;
    @NotNull(message = "Payer mandatory cannot be blank")
    private Boolean payer;
    @NotNull(message = "Payee mandatory cannot be blank")
    private Boolean payee;
    @NotNull(message = "Channel id cannot be blank")
    private Integer channelId;
    @NotNull(message = "Maker remark cannot be blank")
    @NotBlank(message = "Maker remark cannot be blank")
    @NotEmpty(message = "Maker remark cannot be blank")
    @Pattern(regexp = "^[a-zA-Z0-9 ,_@*#%'/\\\\&.-]+$", message = "Maker remark can only contain alphabets, " +
            "numbers, space, comma (,), underscore (_), at (@), asterisk (*), hash (#), percentage (%), " +
            "single quotes (' '), forward slash (/), backward slash (\\), ampersand (&) and dot (.)")
    private String makerRemark;

    private Integer skipProcessing;

    private JsonNode attribs;

    private JsonNode decisionParams;
    @Valid
    private AddNewDecisionRequest addNewDecision;

    private Integer itenantId;
}
