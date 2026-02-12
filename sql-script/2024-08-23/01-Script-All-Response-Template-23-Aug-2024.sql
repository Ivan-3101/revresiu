DELETE FROM ui.templateresponse;

INSERT INTO ui.templateresponse VALUES (8, 'Y', '{
    "messageName": "GetFeedback",
   "businessKey": "Doom10",
  "processVariables" : {
                  "Feedback":{
                      "value":"Value_Fraud",
                      "type":"string"}
  }
}', 'Report Fraud', 'N_Feedback');
INSERT INTO ui.templateresponse VALUES (9, 'N
', '{
    "messageName": "GetFeedback",
   "businessKey": "Doom10",
  "processVariables" : {
                  "Feedback":{
                      "value":"Value_Close",
                      "type":"string"}
  }
}', 'Close Task
', 'N_Feedback');
INSERT INTO ui.templateresponse VALUES (10, 'Y', '{
    "messageName": "chargebackmessage1",
   "businessKey": "Doom4",
  "processVariables" : {
    "Document" : {"value" : "documnet url", "type": "string" },
    "MerchantResponse":{
                      "value":"No Refund",
                      "type":"string"}
  }
}', 'Doc', 'UC_ReqInfoDoc');
INSERT INTO ui.templateresponse VALUES (4, 'Y', '{
    "messageName": "doubledebitmessage1",
   "businessKey": "Doom17",
  "processVariables" : {
    
                  "separate":{
                      "value":"Yes",
                      "type":"string"}
  }
}', 'Separate', 'DD_ReqInfo');
INSERT INTO ui.templateresponse VALUES (5, 'N', '{
    "messageName": "doubledebitmessage1",
   "businessKey": "Doom17",
  "processVariables" : {
    
                  "separate":{
                      "value":"No",
                      "type":"string"}
  }
}', 'Not Separate', 'DD_ReqInfo');
INSERT INTO ui.templateresponse VALUES (6, 'Y', '{
  "messageName": "doubledebitmessage2",
  "businessKey": "Doom17",
  "processVariables": {
    "Document": {
      "value": "url",
      "type": "string"
    },
    "MerchantResponse": {
      "value": "No Refund",
      "type": "string"
    }
  }
}', 'Doc', 'DD_ReqDoc');
INSERT INTO ui.templateresponse VALUES (1, 'N', '{
   "messageName":"receivedDocument1",
   "businessKey":"Doom17",
   "processVariables":{
      "MerchantResponse":{
         "value":"Initiate Refund",
         "type":"string"
      }
   }
}', 'Refund', 'MRS_ReqInfoDoc');
INSERT INTO ui.templateresponse VALUES (2, 'Y', '{
   "messageName":"receivedDocument1",
   "businessKey":"Doom17",
   "processVariables":{
       "Document": {
      "value": "url",
      "type": "string"
    },
    "MerchantResponse": {
      "value": "Upload Documents",
      "type": "string"
    }
   }
}', 'Doc', 'MRS_ReqInfoDoc');
INSERT INTO ui.templateresponse VALUES (3, 'Y', '{
   "messageName":"receivedDocument2",
   "businessKey":"Doom17",
   "processVariables":{
       "Document": {
      "value": "urlchange",
      "type": "string"
    },
    "MerchantResponse": {
      "value": "Corrected Document",
      "type": "string"
    }
   }
}', 'Doc', 'MRS_ReqCorrectedDoc');
INSERT INTO ui.templateresponse VALUES (7, 'Y', '{
    "messageName": "doubledebitmessage2",
   "businessKey": "Doom17",
  "processVariables" : {
     "Document": {
      "value": "urlchange",
      "type": "string"
    },
                  "MerchantResponse":{
                      "value":"Corrected Doc",
                      "type":"string"}
  }
}
', 'Doc', 'DD_ReqCorrectedDoc');
INSERT INTO ui.templateresponse VALUES (16, 'N', '{
  "messageName" : "response_from_settlement_1",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "PENDING",
            "type": "string"
        },
      "message":{
          "value":"Request Received",
           "type":"string"
         }
    }
  
}', 'Settlement', 'RMS_Settlement_1');
INSERT INTO ui.templateresponse VALUES (18, 'N', '{
  "messageName" : "response_from_settlement_1",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "PARTIAL_SUCCESS",
            "type": "string"
        },
      "message":{
          "value":"Request is recieved and is in progress",
           "type":"string"
         }
    }
  
}', 'Settlement', 'RMS_Settlement_1');
INSERT INTO ui.templateresponse VALUES (19, 'N', '{
  "messageName" : "receive_response_settlement_2",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "FAILED",
            "type": "string"
        },
      "message":{
          "value":"All transactions release failed",
           "type":"string"
         }
    }
  
}', 'Settlement', 'RMS_Settlement_2');
INSERT INTO ui.templateresponse VALUES (20, 'N', '{
  "messageName" : "receive_response_settlement_2",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "PENDING",
            "type": "string"
        },
      "message":{
          "value":"Request received",
           "type":"string"
         }
    }
  
}', 'Settlement', 'RMS_Settlement_2');
INSERT INTO ui.templateresponse VALUES (21, 'N', '{
  "messageName" : "receive_response_settlement_2",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "PARTIAL_SUCCESS",
            "type": "string"
        },
      "message":{
          "value":"Request received and is in progress",
           "type":"string"
         }
    }
  
}', 'Settlement', 'RMS_Settlement_2');
INSERT INTO ui.templateresponse VALUES (12, 'Y', '{
    "messageName": "GetFeedback",
   "businessKey": "Doom17",
  "processVariables" : {
    
                  "fraud":{
                      "value":"yes",
                      "type":"string"}
  }
}', 'Confirm Fraud', 'RN_FeedBack');
INSERT INTO ui.templateresponse VALUES (11, 'N', '{
    "messageName": "GetFeedback",
   "businessKey": "Doom17",
  "processVariables" : {
    
                  "fraud":{
                      "value":"no",
                      "type":"string"}
  }
}', 'Blacklist', 'RN_FeedBack');
INSERT INTO ui.templateresponse VALUES (14, 'Y', '{
  "messageName" : "receive_response_settlement_2",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "SUCCESS",
            "type": "string"
        },
      "message":{
          "value":"All transactions released successfully",
           "type":"string"
         }
    }
  
}', 'Settlement', 'RMS_Settlement_2');
INSERT INTO ui.templateresponse VALUES (15, 'Y', '{
    "messageName": "response_from_merchant",
    "businessKey": "1687152671",
    "processVariables": {
        "attachmentList": {
            "value": " [\n      {\n        \"filename\": \"receipt.pdf\" \n      },\n      {\n        \"filename\": \"invoice.jpg\"\n      }\n    ]\n",
            "type": "string"
        },
      "subject":{
       "value":"This is test subject",
     "type": "string"
       },
      "body":{
       "value":"This is test body",
     "type": "string"
       }
    }
}', 'Doc', 'RMS_ReqInfo');
INSERT INTO ui.templateresponse VALUES (17, 'N', '{
  "messageName" : "response_from_settlement_1",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "FAILED",
            "type": "string"
        },
      "message":{
          "value":"All Transactions already released to merchant",
           "type":"string"
         }
    }
  
}', 'Settlement', 'RMS_Settlement_1');
INSERT INTO ui.templateresponse VALUES (13, 'Y', '{
  "messageName" : "response_from_settlement_1",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "SUCCESS",
            "type": "string"
        },
      "message":{
          "value":"All transactions holded successfully",
           "type":"string"
         }
    }
  
}', 'Settlement', 'RMS_Settlement_1');
INSERT INTO ui.templateresponse VALUES (22, 'N', '{
   "messageName":"IVRResponse",
   "businessKey":"Doom17",
   "processVariables":{
      "fraud":{
         "value":"yes",
         "type":"string"
      }
   }
}', 'IVR Response', 'JPB_IVRTemplate');
INSERT INTO ui.templateresponse VALUES (23, 'Y', '{
   "messageName":"IVRResponse",
   "businessKey":"Doom17",
   "processVariables":{
      "fraud":{
         "value":"no",
         "type":"string"
      }
   }
}', 'IVRResponse', 'JPB_IVRTemplate');
INSERT INTO ui.templateresponse VALUES (25, 'N', '{
"responsecode":400, 
"body":{}
}', 'Settlement invalid data', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (27, 'N', '{
"responsecode":403, 
"body":{
  "errors": [
    {
      "title": "OrchestratorException",
      "status": 403,
      "detail": "Exception occurred in orchestrator module"
    }
  ]
}
}', 'Unauthorized Settlement', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (28, 'N', '{
"responsecode":409, 
"body":{
  "type": "ContstraintViolationException",
  "message": "No record found with requestId"
}
}', 'Record not found', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (36, 'N', '{
"responsecode":200, 
"type":"partial",
"HOLD":{
  "messageName" : "response_from_settlement_1",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "FAILED",
            "type": "string"
        },
      "message":{
          "value":"All transactions release failed",
           "type":"string"
         }
    }
  
},
"RELEASE":{
  "messageName" : "receive_response_settlement_2",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "FAILED",
            "type": "string"
        },
      "message":{
          "value":"All transactions release failed",
           "type":"string"
         }
    }
  
}
}', 'Partial', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (32, 'Y', '{
"responsecode":200, 
"type":"Failed"
"body":{
  "status": "FAILED",
  "message": "All Transactions already released to merchant",
  "riskTransactions": [
    {
      "status": "FAILED",
      "riskTransaction": {
        "tenantId": "1",
        "transactionId": "213123",
        "transactionSource": "ONLINE",
        "status": "HOLD",
        "remarks": "Hold as amount > 100000"
      },
      "error": {
        "type": "HoldException",
        "message": "Transaction already released to merchant"
      }
    }
  ]
}
}', 'Failed', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (31, 'N', '{
"responsecode":200, 
"type":"partial"
"body":{
  "status": "FAILED",
  "message": "All Transactions already released to merchant",
  "riskTransactions": [
    {
      "status": "FAILED",
      "riskTransaction": {
        "tenantId": "1",
        "transactionId": "213123",
        "transactionSource": "ONLINE",
        "status": "HOLD",
        "remarks": "Hold as amount > 100000"
      },
      "error": {
        "type": "HoldException",
        "message": "Transaction already released to merchant"
      }
    }
  ]
}
}', 'Partial', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (35, 'N', '{
"responsecode":200, 
"type":"Failed",
"HOLD":{
  "messageName" : "response_from_settlement_1",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "FAILED",
            "type": "string"
        },
      "message":{
          "value":"All transactions release failed",
           "type":"string"
         }
    }
  
},
"RELEASE":{
  "messageName" : "receive_response_settlement_2",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "FAILED",
            "type": "string"
        },
      "message":{
          "value":"All transactions release failed",
           "type":"string"
         }
    }
  
}
}', 'Failed', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (29, 'N', '{
"responsecode":500, 
"body":{}
}', 'Internal Server Error', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (34, 'N', '{
"responsecode":409, 
"body":{
  "type": "ContstraintViolationException",
  "message": "Duplicate request with given request id"
}
}', 'Duplicate Record', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (26, 'N', '{
"responsecode":401, 
"body":{
  "errors": [
    {
      "title": "AccessDeniedException",
      "status": 401,
      "detail": "Required scope not present in Authorization token"
    }
  ]
}
}
', 'Settlement unauthorized', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (24, 'N', '{
"responsecode":502, 
"body":"{}"
}', 'Settlement Engine Down', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (33, 'N', '{
"responsecode":400, 
"body":{}
}', 'Settlement invalid data', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (30, 'N', '{
"responsecode":200, 
"type":"full",
"body":{
  "status": "FAILED",
  "message": "All Transactions already released to merchant",
  "riskTransactions": [
    {
      "status": "FAILED",
      "riskTransaction": {
        "tenantId": "1",
        "transactionId": "213123",
        "transactionSource": "ONLINE",
        "status": "HOLD",
        "remarks": "Hold as amount > 100000"
      },
      "error": {
        "type": "HoldException",
        "message": "Transaction already released to merchant"
      }
    }
  ]
}
}', 'Success', 'Enquire_RMS');
INSERT INTO ui.templateresponse VALUES (41, 'N', '{
"responsecode":502, 
"body":"<html></html>"
}', 'Settlement Engine Down', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (37, 'Y', '{
"responsecode":200, 
"type":"full",
"HOLD":{
  "messageName" : "response_from_settlement_1",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "SUCCESS",
            "type": "string"
        },
      "message":{
          "value":"All transactions held successfully",
           "type":"string"
         }
    }
  
},
"RELEASE":{
  "messageName" : "receive_response_settlement_2",
  "businessKey" : "1687236337",
"processVariables": {
        "status": {
            "value": "SUCCESS",
            "type": "string"
        },
      "message":{
          "value":"All transactions released successfully",
           "type":"string"
         }
    }
  
}
}', 'Success', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (40, 'N', '{
"responsecode":403, 
"body":{
  "errors": [
    {
      "title": "OrchestratorException",
      "status": 403,
      "detail": "Exception occurred in orchestrator module"
    }
  ]
}
}', 'Unauthorized Settlement', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (43, 'N', '{}', 'No Response', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (39, 'N', '{
"responsecode":401, 
"body":{
  "errors": [
    {
      "title": "AccessDeniedException",
      "status": 401,
      "detail": "Required scope not present in Authorization token"
    }
  ]
}
}
', 'Settlement unauthorized', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (38, 'N', '{
"responsecode":500, 
"body":{}
}', 'Internal Server Error', 'RMS_Settlement');
INSERT INTO ui.templateresponse VALUES (42, 'N', '{
  "responsecode": 200,
  "type": "full",
  "HOLD": {
  },
  "RELEASE": {
    
  }
}', 'Pending', 'RMS_Settlement');