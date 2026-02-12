UPDATE ui.workflowmasters
	SET  filterparams='[
  {
    "name": "TransactionClass",
    "data_type": "string",
    "value_config": {
      "value": "/txn/class",
      "extract_from": "trans_json"
    }
  },
  {
    "name": "PaymentChannel",
    "data_type": "string",
    "value_config": {
      "value": "txn/attribs/device/type",
      "extract_from": "trans_json"
    }
  },
  {
    "name": "ReferenceNumber",
    "data_type": "string",
    "value_config": {
      "value": "txn/attribs/referenceNumber",
      "extract_from": "trans_json"
    }
  },
  {
    "name": "BeneficiaryAccountNumber",
    "data_type": "string",
    "value_config": {
      "value": "payee/attribs/account_detail/accountNumber",
      "extract_from": "trans_json"
    }
  },
  {
    "name": "BeneficiarybranchIfsc",
    "data_type": "string",
    "value_config": {
      "value": "payee/attribs/account_detail/bankIfsc",
      "extract_from": "trans_json"
    }
  }
]'
	WHERE workflowkey='JPB_RiskNotification';