UPDATE ui.workflowmasters
	SET   filterparams='[
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
  },
  {
    "name": "customerName",
    "data_type": "string",
    "value_config": [
      {
        "value": "/observations/payerVPA/account/customer/customerName",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "networkScore",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/network_score",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/network_score",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "authResponseCode",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/response_code",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/response_code",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "authResponseCode",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/response_code",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/response_code",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "posEntryMode",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pos_entry_mode",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "mcc",
    "data_type": "string",
    "value_config": [
      {
        "value": "/payee/mcc",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "merchantLocation",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/merchant_city",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/merchant_city",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "cardAcceptorCountryCode",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/merchant_state_or_country_code",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/merchant_state_or_country_code",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "acquirerCountryCode",
    "data_type": "string",
    "value_config": [
      {
        "value": "/payee/currency",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "motoEciRecurring",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/moto_eci_recurring",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "issuerCountryCode",
    "data_type": "string",
    "value_config": [
      {
        "value": "/payer/currency",
        "extract_from": "trans_json"
      }
    ]
  }, 
  {
    "name": "transaction_id",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/id",
        "extract_from": "trans_json"
      }
    ]
  }, 
  {
    "name": "cardAcceptorId",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/merchant_id_code",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/merchant_id_code",
        "extract_from": "trans_json"
      }
    ]
  },
  {
    "name": "cardStatus",
    "data_type": "string",
    "value_config": [
      {
        "value": "/txn/attribs/pismo_raw/fields/original_network_data/de61_pos_data/sf5_pos_card_presence",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/original_network_data/de61_pos_data/sf5_pos_card_presence",
        "extract_from": "trans_json"
      },
       {
        "value": "/txn/attribs/pismo_raw/fields/original_network_data/de61_pos_data_code/sf6_card_present_data",
        "extract_from": "trans_json"
      },
      {
        "value": "/txn/attribs/pismo_raw/raw/original_network_data/de61_pos_data_code/sf6_card_present_data",
        "extract_from": "trans_json"
      }
    ]
  }
]'
	WHERE workflowkey IN ('CUB_RiskNotification','USFB_RiskNotification','SSFB_RiskNotification','ESAF_RiskNotification');