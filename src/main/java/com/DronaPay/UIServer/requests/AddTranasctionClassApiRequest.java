package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.model.TransactionClassesUI;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AddTranasctionClassApiRequest {
    
    private String txnClassName;
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

    public static AddTranasctionClassApiRequest parseTransactionClassUi(TransactionClassesUI transactionClassesUI){
        AddTranasctionClassApiRequest  addTranasctionClassApiRequest=new AddTranasctionClassApiRequest();
        addTranasctionClassApiRequest.setActive(transactionClassesUI.isBActive());
        addTranasctionClassApiRequest.setChannelID(transactionClassesUI.getIChannelID());
        addTranasctionClassApiRequest.setDecisionID(transactionClassesUI.getIDecisionID());
        if(transactionClassesUI.getVcDecisionParams()!=null){
                addTranasctionClassApiRequest.setDecision_params(transactionClassesUI.getVcDecisionParams());
        }
        addTranasctionClassApiRequest.setPayeeMandatory(transactionClassesUI.isBPayeeMandatory());
        addTranasctionClassApiRequest.setPayerMandatory(transactionClassesUI.isBPayerMandatory());
        addTranasctionClassApiRequest.setProductID(transactionClassesUI.getIProductID().getIProductID());
        addTranasctionClassApiRequest.setRecord_status(transactionClassesUI.getIRecordStatus());
        addTranasctionClassApiRequest.setTxnClassName(transactionClassesUI.getVcClassName());
        if(transactionClassesUI.getAttribs() != null){
        addTranasctionClassApiRequest.setAttribs(transactionClassesUI.getAttribs());}
        addTranasctionClassApiRequest.setSkip_processing(transactionClassesUI.getSkipProcessing());
        return addTranasctionClassApiRequest;
    }
}
