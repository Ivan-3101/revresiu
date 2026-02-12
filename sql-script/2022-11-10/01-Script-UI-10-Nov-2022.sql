INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (11, 'N', '{
    "messageName": "GetFeedback",
   "businessKey": "Doom17",
  "processVariables" : {
    
                  "fraud":{
                      "value":"no",
                      "type":"string"}
  }
}', 'Blacklist', 'RN_FeedBack');
INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (12, 'Y', '{
    "messageName": "GetFeedback",
   "businessKey": "Doom17",
  "processVariables" : {
    
                  "fraud":{
                      "value":"yes",
                      "type":"string"}
  }
}', 'Confirm Fraud', 'RN_FeedBack');