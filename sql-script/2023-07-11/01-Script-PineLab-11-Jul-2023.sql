

DELETE FROM ui.templateresponse	WHERE templateid=15;
INSERT INTO ui.templateresponse (templateid, activeflag, jsonresponse, responses, templatename) VALUES (15, 'Y', '{
    "messageName": "response_from_merchant",
    "businessKey": "1687152671",
    "processVariables": {
        "attachmentList": {
            "value": " [\n      {\n        \"filename\": \"receipt.pdf\" \n      },\n      {\n        \"filename\": \"invoice.jpg\"\n      }\n    ]\n",
            "type": "string"
        }
    }
}', 'Doc', 'RMS_ReqInfo');


