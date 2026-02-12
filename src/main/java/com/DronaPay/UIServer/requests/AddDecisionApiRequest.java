package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.model.DecisionUi;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AddDecisionApiRequest {
    
    private Integer productId;
    private String decisionName;
    private String decisionDetail;
    private String decisionMapInfo;
    private Boolean active;
    private Integer record_status;
    private JsonNode resultParams;
    private JsonNode attribs;
    public static AddDecisionApiRequest parseDecisionUi(DecisionUi decisionUi){

        AddDecisionApiRequest addDecisionApiRequest=new AddDecisionApiRequest();
        addDecisionApiRequest.setActive(decisionUi.isBactive());
        addDecisionApiRequest.setDecisionDetail(decisionUi.getVcDecisionDetail());
        addDecisionApiRequest.setDecisionMapInfo(decisionUi.getVcDecisionMapInfo());
        addDecisionApiRequest.setDecisionName(decisionUi.getVcDecisionName());
        addDecisionApiRequest.setProductId(decisionUi.getIProductID().getIProductID());
        addDecisionApiRequest.setRecord_status(decisionUi.getIRecordStatus());
        if(decisionUi.getVcResultParams()!=null){
            addDecisionApiRequest.setResultParams(decisionUi.getVcResultParams());
        }
        if(decisionUi.getAttribs() != null) {
            addDecisionApiRequest.setAttribs(decisionUi.getAttribs());
        }

        return addDecisionApiRequest;
    }
}
