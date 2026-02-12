ALTER TABLE ui.rules ADD COLUMN vcquery text, ADD COLUMN bapicall boolean,ADD COLUMN bexecutequery boolean, ADD COLUMN vcqueryresultmap jsonb, ADD COLUMN vcqueryfilterparams jsonb, ADD COLUMN vcresponseapiattribs jsonb;
UPDATE ui.rules	SET  bapicall=false, bexecutequery=false;

UPDATE ui.rules
	SET  
	vcquery='Select vcpayeeaccountexternalid, vcpayeeaddr, vcpayeecustomerexternalid from transactions.trans where ipayeraccountid =  :iaccountid and dobservationamount >= :txn_threshold  and dttrxntime >= :tdate_min
and dttrxntime <=CURRENT_DATE;', 
bapicall=true, 
bexecutequery=true, 
	vcqueryresultmap='[
  {
    "api_key": "acc_externalId",
    "result_key": "vcpayeeaccountexternalid"
  },
  {
    "api_key": "vpa_externalId",
    "result_key": "vcpayeeaddr"
  },
  {
    "api_key": "cust_externalId",
    "result_key": "vcpayeecustomerexternalid"
  }
]', 
	vcqueryfilterparams='[
  {
    "value": 500,
    "parameter_name": "txn_threshold",
    "parameter_type": "Integer",
    "trans_json_pointer": null,
    "result_json_pointer": null
  },
  {
    "value": null,
    "parameter_name": "iaccountid",
    "parameter_type": "Integer",
    "trans_json_pointer": "/observations/account/iaccountid",
    "result_json_pointer": null
  },
  {
    "value": null,
    "calculate": {
      "unit": "DAYS",
      "value": 90,
      "operator": "substract"
    },
    "parameter_name": "tdate_min",
    "parameter_type": "Calculate_Date",
    "trans_json_pointer": "/ts",
    "result_json_pointer": null
  }
]', 
	vcresponseapiattribs='[
  {
    "value": "",
    "attrib": "customer_externalId",
    "trans_path": "/observations/customer/vcexternalcustid",
    "result_path": ""
  },
  {
    "value": "",
    "attrib": "account_externalId",
    "trans_path": "/observations/account/vcexternalaccountid",
    "result_path": ""
  }
]'
	WHERE iruleid=10162;