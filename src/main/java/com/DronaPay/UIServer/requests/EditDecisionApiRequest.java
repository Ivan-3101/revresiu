package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.model.DecisionUi;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class EditDecisionApiRequest {

    private Integer productId;
    private String decisionName;
    private String decisionDetail;
    private String decisionMapInfo;
    private Boolean active;
    private Integer record_status;
    private JsonNode resultParams;
    private JsonNode attribs;

    public static EditDecisionApiRequest parseDecisionUi(DecisionUi decisionUi) {

        EditDecisionApiRequest editDecisionApiRequest = new EditDecisionApiRequest();
        editDecisionApiRequest.setActive(decisionUi.isBactive());
        editDecisionApiRequest.setDecisionDetail(decisionUi.getVcDecisionDetail());
        editDecisionApiRequest.setDecisionMapInfo(decisionUi.getVcDecisionMapInfo());
        editDecisionApiRequest.setDecisionName(decisionUi.getVcDecisionName());
        editDecisionApiRequest.setProductId(decisionUi.getIProductID().getIProductID());
        editDecisionApiRequest.setRecord_status(decisionUi.getIRecordStatus());
        if (decisionUi.getVcResultParams() != null) {

            editDecisionApiRequest.setResultParams(decisionUi.getVcResultParams());
        }
        if (decisionUi.getAttribs() != null) {
            editDecisionApiRequest.setAttribs(decisionUi.getAttribs());
        }

        return editDecisionApiRequest;
    }

}
