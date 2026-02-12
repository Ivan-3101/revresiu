

DELETE FROM ui.templateresponse	WHERE templateid=13 OR templateid=14;
INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (13, 'Y', '{
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



INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (14, 'Y', '{
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

INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (16, 'N', '{
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

INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (17, 'N', '{
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
INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (18, 'N', '{
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
INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (19, 'N', '{
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
INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (20, 'N', '{
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

INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (21, 'N', '{
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