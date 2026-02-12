UPDATE ui.rules
	SET  
	vcquery='Select ilivemessageid,vcpayeeaccountexternalid, vcpayeeaddr, vcpayeecustomerexternalid from analytics.trans where ipayeraccountid =  :iaccountid and itenantid = :tenantid and dobservationamount >= :txn_threshold  and dttrxntime >= :tdate_min
and dttrxntime <=CURRENT_DATE;', 
	vcqueryresultmap='[
  {
    "api_key": "account_externalId",
    "result_key": "vcpayeeaccountexternalid"
  },
  {
    "api_key": "payment_address_externalId",
    "result_key": "vcpayeeaddr"
  },
  {
    "api_key": "payment_address",
    "result_key": "vcpayeeaddr"
  },
  {
    "api_key": "customer_externalId",
    "result_key": "vcpayeecustomerexternalid"
  },
  {
    "api_key": "reqid",
    "result_key": "ilivemessageid"
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
    "attrib": "source_customer_externalId",
    "trans_path": "/observations/customer/vcexternalcustid",
    "result_path": ""
  },
  {
    "value": "",
    "attrib": "source_account_externalId",
    "trans_path": "/observations/account/vcexternalaccountid",
    "result_path": ""
  }  ,
  {
    "value": "",
    "attrib": "source_payment_address_externalId",
    "trans_path": "/observations/vpa/vcexternaladdressid",
    "result_path": ""
  }
]'
	WHERE vcrulename IN ('CREDIT_FROM_KNOWN_FRAUDSTERS','CREDIT_FROM_GOLDEN_SET_OF_FRAUDSTERS','LEA Tagged Account');