DELETE FROM batch.batch_job_types
    WHERE jobtypeid IN
        (4);
INSERT INTO batch.batch_job_types (
jobtypeid, jobtype, maxrecords, maxrowsize, numthreads, processing_url, iserverid) VALUES (
'4'::integer, 'Customer'::character varying, '1'::integer, '5000'::integer, '8'::integer, '/api/v1/testing/batch/job/customer'::character varying, '3'::integer)
 returning jobtypeid;

UPDATE ui.masterconfig SET
configjson = '{
  "list": {
    "sheets": [
      {
        "sheet": "Whitelist Template",
        "columns": [
          {
            "label": "vcexternallistitemid",
            "value": "vcexternallistitemid",
            "bodyKey": "externalId"
          },
          {
            "type": "integer",
            "label": "ilisttype",
            "value": "ilisttype",
            "bodyKey": "listType"
          },
          {
            "label": "vcfield",
            "value": "vcfield",
            "bodyKey": "itemField"
          },
          {
            "label": "vcvalue",
            "value": "vcvalue",
            "bodyKey": "itemValue"
          },
          {
            "label": "vcsource",
            "value": "vcsource",
            "bodyKey": "source"
          },
          {
            "type": "startofdaydate",
            "label": "dteffectivefrom",
            "value": "dteffectivefrom",
            "bodyKey": "effectiveFrom"
          },
          {
            "type": "endofdaydate",
            "label": "dtexpiresat",
            "value": "dtexpiresat",
            "bodyKey": "expiresAt"
          },
          {
            "type": "jsonb",
            "label": "attribs",
            "value": "attribs"
          }
        ],
        "content": [
          {
            "attribs": "{\"rule\":true,\"action\":[]}",
            "vcfield": "payee_account_external_id",
            "vcvalue": "account_123",
            "vcsource": "FRM",
            "ilisttype": 2,
            "dtexpiresat": "2024-07-28",
            "dteffectivefrom": "2024-06-28",
            "vcexternallistitemid": "L-1716798175051"
          }
        ]
      },
      {
        "sheet": "Blacklist Template",
        "columns": [
          {
            "label": "vcexternallistitemid",
            "value": "vcexternallistitemid",
            "bodyKey": "externalId"
          },
          {
            "type": "integer",
            "label": "ilisttype",
            "value": "ilisttype",
            "bodyKey": "listType"
          },
          {
            "label": "vcfield",
            "value": "vcfield",
            "bodyKey": "itemField"
          },
          {
            "label": "vcvalue",
            "value": "vcvalue",
            "bodyKey": "itemValue"
          },
          {
            "label": "vcsource",
            "value": "vcsource",
            "bodyKey": "source"
          },
          {
            "type": "startofdaydate",
            "label": "dteffectivefrom",
            "value": "dteffectivefrom",
            "bodyKey": "effectiveFrom"
          },
          {
            "type": "endofdaydate",
            "label": "dtexpiresat",
            "value": "dtexpiresat",
            "bodyKey": "expiresAt"
          }
        ],
        "content": [
          {
            "vcfield": "payer_account_external_id",
            "vcvalue": "account_123",
            "vcsource": "FRM",
            "ilisttype": 0,
            "dtexpiresat": "2024-07-28",
            "dteffectivefrom": "2024-06-28",
            "vcexternallistitemid": "L-1716798175051"
          }
        ]
      },
      {
        "sheet": "Greylist Template",
        "columns": [
          {
            "label": "vcexternallistitemid",
            "value": "vcexternallistitemid",
            "bodyKey": "externalId"
          },
          {
            "type": "integer",
            "label": "ilisttype",
            "value": "ilisttype",
            "bodyKey": "listType"
          },
          {
            "label": "vcfield",
            "value": "vcfield",
            "bodyKey": "itemField"
          },
          {
            "label": "vcvalue",
            "value": "vcvalue",
            "bodyKey": "itemValue"
          },
          {
            "label": "vcsource",
            "value": "vcsource",
            "bodyKey": "source"
          },
          {
            "type": "startofdaydate",
            "label": "dteffectivefrom",
            "value": "dteffectivefrom",
            "bodyKey": "effectiveFrom"
          },
          {
            "type": "endofdaydate",
            "label": "dtexpiresat",
            "value": "dtexpiresat",
            "bodyKey": "expiresAt"
          }
        ],
        "content": [
          {
            "vcfield": "payee_account_external_id",
            "vcvalue": "account_123",
            "vcsource": "FRM",
            "ilisttype": 1,
            "dtexpiresat": "2024-07-28",
            "dteffectivefrom": "2024-06-28",
            "vcexternallistitemid": "L-1716798175051"
          }
        ]
      },
      {
        "sheet": "Field Mapping Enum",
        "columns": [
          {
            "label": "Display Name",
            "value": "Display Name"
          },
          {
            "label": "vcvalue",
            "value": "value"
          }
        ],
        "content": [
          {
            "value": "payer_account_external_id",
            "Display Name": "Payer Account"
          },
          {
            "value": "payee_account_external_id",
            "Display Name": "Payee Account"
          },
          {
            "value": "instructed_amount",
            "Display Name": "Transaction Amount"
          },
          {
            "value": "pin_code",
            "Display Name": "Payer Pincode"
          },
          {
            "value": "pin_code",
            "Display Name": "Payee Pincode"
          },
          {
            "value": "country",
            "Display Name": "Country Code"
          },
          {
            "value": "location",
            "Display Name": "Device Location"
          },
          {
            "value": "identity_emailID",
            "Display Name": "Payee Email"
          },
          {
            "value": "device_ip",
            "Display Name": "Device IP"
          },
          {
            "value": "payee_vpa",
            "Display Name": "Payee VPA"
          },
          {
            "value": "payer_vpa",
            "Display Name": "Payer VPA"
          },
          {
            "value": "card_number",
            "Display Name": "Payer Card"
          },
          {
            "value": "card_number",
            "Display Name": "Payee Card"
          },
          {
            "value": "default_mcc",
            "Display Name": "Merchant Category Code"
          },
          {
            "value": "payer_addr",
            "Display Name": "Payer Address"
          },
          {
            "value": "payee_addr",
            "Display Name": "Payee Address"
          },
          {
            "value": "card_number",
            "Display Name": "Payee Card"
          },
          {
            "value": "card_number",
            "Display Name": "Payer Card"
          },
          {
            "value": "payer_addr_watch",
            "Display Name": "Payer Address Watch List"
          },
          {
            "value": "payer_addr_suspicious",
            "Display Name": "Payer Address Suspicious"
          },
          {
            "value": "device_location",
            "Display Name": "Payer Country Code"
          },
          {
            "value": "mobile_num",
            "Display Name": "Payer Mobile number"
          },
          {
            "value": "device_location",
            "Display Name": "Payee Country Code"
          },
          {
            "value": "mobile_num",
            "Display Name": "Payee Mobile number"
          },
          {
            "value": "device_imei",
            "Display Name": "Device IMEI"
          },
          {
            "value": "identity_emailID",
            "Display Name": "Payer Email"
          }
        ]
      }
    ],
    "fileName": "List_Upload_template"
  },
  "simple_customer": {
    "sheets": [
      {
        "sheet": "Template",
        "columns": [
          {
            "label": "ifsc*",
            "value": "ifsc*",
            "bodyKey": "ifsc"
          },
          {
            "label": "email*",
            "value": "email*",
            "bodyKey": "email"
          },
          {
            "type": "boolean",
            "label": "merchant",
            "value": "merchant"
          },
          {
            "label": "externalId*",
            "value": "externalId*",
            "bodyKey": "externalId"
          },
          {
            "type": "integer",
            "label": "accountType*",
            "value": "accountType*"
          },
          {
            "label": "customerType",
            "value": "customerType"
          },
          {
            "type": "integer",
            "label": "default_mcc*",
            "value": "default_mcc*",
            "bodyKey": "default_mcc"
          },
          {
            "type": "integer",
            "label": "postal_code*",
            "value": "postal_code*",
            "bodyKey": "postal_code"
          },
          {
            "label": "verifiedName",
            "value": "verifiedName"
          },
          {
            "label": "customerName*",
            "value": "customerName*",
            "bodyKey": "customerName"
          },
          {
            "type": "integer",
            "label": "accountNumber*",
            "value": "accountNumber*",
            "bodyKey": "accountNumber"
          },
          {
            "label": "cust_categories",
            "value": "cust_categories"
          },
          {
            "label": "onboarding_date*",
            "value": "onboarding_date*",
            "bodyKey": "onboarding_date"
          },
          {
            "label": "payment_address*",
            "value": "payment_address*",
            "bodyKey": "payment_address"
          },
          {
            "label": "iso_country_code*",
            "value": "iso_country_code*",
            "bodyKey": "iso_country_code"
          },
          {
            "type": "integer",
            "label": "registered_mobile*",
            "value": "registered_mobile*",
            "bodyKey": "registered_mobile"
          },
          {
            "label": "address_geolocation",
            "value": "address_geolocation",
            "bodyKey": "address_geolocation"
          },
          {
            "label": "attribs__ip",
            "value": "attribs__ip"
          },
          {
            "label": "attribs__kyc_status",
            "value": "attribs__kyc_status"
          },
          {
            "label": "attribs__postal_code",
            "value": "attribs__postal_code"
          },
          {
            "label": "attribs__business_type",
            "value": "attribs__business_type"
          },
          {
            "label": "attribs__merchant_type",
            "value": "attribs__merchant_type"
          },
          {
            "type": "integer",
            "label": "attribs__daily_txn_count",
            "value": "attribs__daily_txn_count"
          },
          {
            "label": "attribs__mcc_description",
            "value": "attribs__mcc_description"
          },
          {
            "label": "attribs__pob_expiry_date",
            "value": "attribs__pob_expiry_date"
          },
          {
            "type": "integer",
            "label": "attribs__daily_txn_amount",
            "value": "attribs__daily_txn_amount"
          },
          {
            "label": "attribs__business_division",
            "value": "attribs__business_division"
          },
          {
            "type": "integer",
            "label": "attribs__open_refund_limit",
            "value": "attribs__open_refund_limit"
          },
          {
            "type": "integer",
            "label": "attribs__closed_refund_limit",
            "value": "attribs__closed_refund_limit"
          },
          {
            "label": "attribs__proof_business_type",
            "value": "attribs__proof_business_type"
          },
          {
            "type": "integer",
            "label": "attribs__open_daily_txn_count",
            "value": "attribs__open_daily_txn_count"
          },
          {
            "type": "integer",
            "label": "attribs__open_daily_txn_amount",
            "value": "attribs__open_daily_txn_amount"
          },
          {
            "type": "integer",
            "label": "attribs__closed_daily_txn_count",
            "value": "attribs__closed_daily_txn_count"
          },
          {
            "type": "integer",
            "label": "attribs__closed_daily_txn_amount",
            "value": "attribs__closed_daily_txn_amount"
          },
          {
            "label": "attribs__internationalFlagUpdate",
            "value": "attribs__internationalFlagUpdate"
          },
          {
            "type": "integer",
            "label": "attribs__open_daily_txn_refund_count",
            "value": "attribs__open_daily_txn_refund_count"
          },
          {
            "type": "integer",
            "label": "attribs__closed_daily_txn_refund_count",
            "value": "attribs__closed_daily_txn_refund_count"
          }
        ],
        "content": [
          {
            "ifsc*": "HDFC0001",
            "email*": "jogn.doe@gmail.con",
            "merchant": "FALSE",
            "attribs__ip": "",
            "externalId*": "dhkh338983082",
            "accountType*": 1,
            "customerType": "PERSON",
            "default_mcc*": 0,
            "postal_code*": 400671,
            "verifiedName": "",
            "customerName*": "JOHN DOE",
            "accountNumber*": 6700023456,
            "cust_categories": "",
            "onboarding_date*": "2019-09-07T15:50-04:00",
            "payment_address*": "john_doe",
            "iso_country_code*": "IN",
            "registered_mobile*": 9123412345,
            "address_geolocation": "",
            "attribs__kyc_status": "",
            "attribs__postal_code": "",
            "attribs__business_type": "",
            "attribs__merchant_type": "",
            "attribs__daily_txn_count": "",
            "attribs__mcc_description": "",
            "attribs__pob_expiry_date": "",
            "attribs__daily_txn_amount": "",
            "attribs__business_division": "",
            "attribs__open_refund_limit": "",
            "attribs__closed_refund_limit": "",
            "attribs__proof_business_type": "",
            "attribs__open_daily_txn_count": "",
            "attribs__open_daily_txn_amount": "",
            "attribs__closed_daily_txn_count": "",
            "attribs__closed_daily_txn_amount": "",
            "attribs__internationalFlagUpdate": "",
            "attribs__open_daily_txn_refund_count": "",
            "attribs__closed_daily_txn_refund_count": ""
          },
          {
            "ifsc*": "SBI112304",
            "email*": "seller@ybl.com",
            "merchant": "TRUE",
            "attribs__ip": "101.188.67.134",
            "externalId*": "YB12345",
            "accountType*": 2,
            "customerType": "ENTITY",
            "default_mcc*": 5000,
            "postal_code*": 400671,
            "verifiedName": "",
            "customerName*": "SELLER",
            "accountNumber*": 6700023456,
            "cust_categories": "",
            "onboarding_date*": "2019-09-07T15:50-04:00",
            "payment_address*": "YBB1234",
            "iso_country_code*": "IN",
            "registered_mobile*": 9123412345,
            "address_geolocation": "12.913046, 77.596858",
            "attribs__kyc_status": "ACTIVE",
            "attribs__postal_code": "400080",
            "attribs__business_type": "XYZ",
            "attribs__merchant_type": "PROPRIETARY",
            "attribs__daily_txn_count": 100,
            "attribs__mcc_description": "Description of MCC",
            "attribs__pob_expiry_date": "EXPIRY_DATE",
            "attribs__daily_txn_amount": 5000,
            "attribs__business_division": "ABC",
            "attribs__open_refund_limit": 50,
            "attribs__closed_refund_limit": 100,
            "attribs__proof_business_type": "286918236",
            "attribs__open_daily_txn_count": 20,
            "attribs__open_daily_txn_amount": 2000,
            "attribs__closed_daily_txn_count": 70,
            "attribs__closed_daily_txn_amount": 3000,
            "attribs__internationalFlagUpdate": "Y",
            "attribs__open_daily_txn_refund_count": 30,
            "attribs__closed_daily_txn_refund_count": 20
          }
        ]
      }
    ],
    "fileName": "Simple_Customer_template"
  }
} '::jsonb WHERE
configname= 'Bulk Upload Config';
