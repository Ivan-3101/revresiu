package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.model.TransactionClassesUI;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class EditTrasnsactionClassApiRequest {
    
    private Integer productID;
    private Integer channelID;
    private Integer decisionID;
    private Boolean payerMandatory;
    private Boolean payeeMandatory;
    private Boolean active;
    private Integer record_status;
    private JsonNode decision_params;
    private JsonNode attribs;
    private Integer skip_processing;

    public static EditTrasnsactionClassApiRequest parseTransactionClassUi(TransactionClassesUI transactionClassesUI){
        EditTrasnsactionClassApiRequest  editTranasctionClassApiRequest=new EditTrasnsactionClassApiRequest();
        editTranasctionClassApiRequest.setActive(transactionClassesUI.isBActive());
        editTranasctionClassApiRequest.setChannelID(transactionClassesUI.getIChannelID());
        editTranasctionClassApiRequest.setDecisionID(transactionClassesUI.getIDecisionID());
        if(transactionClassesUI.getVcDecisionParams()!=null){
            editTranasctionClassApiRequest.setDecision_params(transactionClassesUI.getVcDecisionParams());
        }
        
        editTranasctionClassApiRequest.setPayeeMandatory(transactionClassesUI.isBPayeeMandatory());
        editTranasctionClassApiRequest.setPayerMandatory(transactionClassesUI.isBPayerMandatory());
        editTranasctionClassApiRequest.setProductID(transactionClassesUI.getIProductID().getIProductID());
        editTranasctionClassApiRequest.setRecord_status(transactionClassesUI.getIRecordStatus());
        editTranasctionClassApiRequest.setAttribs(transactionClassesUI.getAttribs());
        editTranasctionClassApiRequest.setSkip_processing(transactionClassesUI.getSkipProcessing());
        return editTranasctionClassApiRequest;
    }
}
