UPDATE ui.workflowmasters
	SET  filterparams='[
  {
    "name": "TransactionClass",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/class",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "transactiontype",
    "data_type": "int",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/transaction_type",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/transaction_type",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "lastfourdigit",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/last_four_digits",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/last_four_digits",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "cardtype",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/card_type",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/card_type",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "cardid",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/card_id",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/card_id",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "accountid",
    "data_type": "int",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/account_id",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/account_id",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "merchantname",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/merchant_name",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/merchant_name",
        "extract_from": "trans_json"
      }
    ]
  }
]
'

WHERE workflowkey IN ('CUB_RiskNotification','USFB_RiskNotification','ESAF_RiskNotification','SSFB_RiskNotification');