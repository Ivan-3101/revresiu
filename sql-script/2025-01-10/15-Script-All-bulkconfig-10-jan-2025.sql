INSERT INTO ui.masterconfig (
iconfigid, bdelete, configjson, configname) VALUES (
(select max(iconfigid) + 1 from ui.masterconfig)::integer, false::boolean, '{
  "historicProfile": [
    { "value": "account", "label": "Account" },
    { "value": "vpa", "label": "VPA" },
    { "value": "mcc", "label": "MCC" },
    { "value": "location", "label": "Location" }
  ],
  "metadata": [
    {
      "label": "Trans",
      "value": "trans"
    },
    {
      "label": "Customer",
      "value": "customer"
    },
    {
      "label": "Account",
      "value": "account"
    },
    {
      "label": "VPA",
      "value": "vpa"
    }
  ]
}
'::jsonb, 'Metadata Level Config'::character varying)
 returning iconfigid;


UPDATE ui.masterconfig SET
configjson = '{
  "tableoptions": [
    {
      "label": "account_monthly",
      "value": "account_monthly",
      "valueLogic": ["account", "monthly"]
    },
    {
      "label": "account_weekly",
      "value": "account_weekly",
      "valueLogic": ["account", "weekly"]
    },
    {
      "label": "account",
      "value": "account",
      "valueLogic": ["account", "daily"]
    },
    {
      "label": "vpa_monthly",
      "value": "vpa_monthly",
      "valueLogic": ["vpa", "monthly"]
    },
    {
      "label": "vpa",
      "value": "vpa",
      "valueLogic": ["vpa", "daily"]
    },
    {
      "label": "vpa_weekly",
      "value": "vpa_weekly",
      "valueLogic": ["vpa", "weekly"]
    }
  ],
  "entityoptions": [
    {
      "label": "Account",
      "value": "account"
    },
    {
      "label": "Vpa",
      "value": "vpa"
    }
  ],
  "durationoptions": [
    {
      "label": "Daily",
      "value": "daily"
    },
    {
      "label": "Monthly",
      "value": "monthly"
    },
    {
      "label": "Weekly",
      "value": "weekly"
    }
  ],
  "scorringAggregationOptions": [
    {
      "label": "Min",
      "value": {
        "reduce": [
          {
            "var": "scores"
          },
          {
            "if": [
              {
                "<": [
                  {
                    "var": "current.score"
                  },
                  {
                    "var": "accumulator"
                  }
                ]
              },
              {
                "var": "accumulator"
              },
              {
                "var": "current.score"
              }
            ]
          },
          0
        ]
      }
    },
    {
      "label": "Max",
      "value": {
        "reduce": [
          {
            "var": "scores"
          },
          {
            "if": [
              {
                ">": [
                  {
                    "var": "current.score"
                  },
                  {
                    "var": "accumulator"
                  }
                ]
              },
              {
                "var": "accumulator"
              },
              {
                "var": "current.score"
              }
            ]
          },
          0
        ]
      }
    },
    {
      "label": "Sum",
      "value": {
        "reduce": [
          {
            "var": "scores"
          },
          {
            "+": [
              {
                "var": "current"
              },
              {
                "var": "accumulator"
              }
            ]
          },
          0
        ]
      }
    }
  ]
}
'::jsonb WHERE
configname = 'Decision Form Config';

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
        "sheet": "Customlist Template",
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
            "attribs": "{\"parametername\":\"vah\",\"arr\":[{\"cr\":1}]}",
            "vcfield": "payee_account_external_id",
            "vcvalue": "account_123",
            "vcsource": "FRM",
            "ilisttype": 3,
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
            "label": "attribs__accountType",
            "value": "attribs__accountType",
            "itenantid": 10,
            "type": "integer",
            "attribvalue": 2
          },
          { "label": "attribs__gender", "value": "attribs__gender", "itenantid": 10, "attribvalue": "F" },
          { "label": "attribs__kyc", "value": "attribs__kyc", "itenantid": 10, "type": "integer", "attribvalue": 1234 },
          { "label": "attribs__risk", "value": "attribs__risk", "itenantid": 10, "attribvalue": "Low" },
          {
            "label": "attribs__dealer_id",
            "value": "attribs__dealer_id",
            "itenantid": 10,
            "type": "integer",
            "attribvalue": 123
          },
          {
            "label": "attribs__mobile_id",
            "value": "attribs__mobile_id",
            "itenantid": 10,
            "type": "integer",
            "attribvalue": 123
          },
          {
            "label": "attribs__marital_status",
            "value": "attribs__marital_status",
            "itenantid": 10,
            "attribvalue": "NA"
          },
          { "label": "attribs__ovd_type", "value": "attribs__ovd_type", "itenantid": 10, "attribvalue": "ad" },
          {
            "label": "attribs__ovd_number",
            "value": "attribs__ovd_number",
            "itenantid": 10,
            "type": "integer",
            "attribvalue": 123
          },
          {
            "label": "attribs__customer_onboard_type",
            "value": "attribs__customer_onboard_type",
            "itenantid": 10,
            "attribvalue": "online"
          },
          {
            "label": "attribs__gross_income",
            "value": "attribs__gross_income",
            "itenantid": 10,
            "type": "integer",
            "attribvalue": 5000
          },
          {
            "label": "attribs__source_of_income",
            "value": "attribs__source_of_income",
            "itenantid": 10,
            "attribvalue": "NA"
          },
          { "label": "attribs__occupation", "value": "attribs__occupation", "itenantid": 10, "attribvalue": "NA}" },
          {
            "label": "attribs__termination_status",
            "value": "attribs__termination_status",
            "itenantid": 10,
            "attribvalue": "NA"
          },
          { "label": "attribs__city", "value": "attribs__city", "itenantid": 10, "attribvalue": "TN" },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 10, "attribvalue": "MH" },
          {
            "label": "attribs__Mobile_no_UpdateTime",
            "value": "attribs__Mobile_no_UpdateTime",
            "itenantid": 12,
            "attribvalue": 2024
          },
          {
            "label": "attribs__accountType",
            "value": "attribs__accountType",
            "itenantid": 12,
            "type": "integer",
            "attribvalue": 2
          },
          {
            "label": "attribs__accountSubType",
            "value": "attribs__accountSubType",
            "itenantid": 12,
            "type": "integer",
            "attribvalue": 99
          },
          { "label": "attribs__gender", "value": "attribs__gender", "itenantid": 12, "attribvalue": "M" },
          { "label": "attribs__kyc", "value": "attribs__kyc", "itenantid": 12, "attribvalue": "AOTPSA" },
          { "label": "attribs__risk", "value": "attribs__risk", "itenantid": 12, "attribvalue": "Low" },
          {
            "label": "attribs__dealer_id",
            "value": "attribs__dealer_id",
            "itenantid": 12,
            "type": "integer",
            "attribvalue": 123
          },
          {
            "label": "attribs__mobile_id",
            "value": "attribs__mobile_id",
            "itenantid": 12,
            "type": "integer",
            "attribvalue": 123
          },
          {
            "label": "attribs__marital_status",
            "value": "attribs__marital_status",
            "itenantid": 12,
            "attribvalue": "NA"
          },
          { "label": "attribs__ovd_type", "value": "attribs__ovd_type", "itenantid": 12, "attribvalue": "ad" },
          {
            "label": "attribs__ovd_number",
            "value": "attribs__ovd_number",
            "itenantid": 12,
            "type": "integer",
            "attribvalue": 123
          },
          {
            "label": "attribs__customer_onboard_type",
            "value": "attribs__customer_onboard_type",
            "itenantid": 12,
            "attribvalue": "online"
          },
          {
            "label": "attribs__gross_income",
            "value": "attribs__gross_income",
            "itenantid": 12,
            "type": "integer",
            "attribvalue": 5000
          },
          {
            "label": "attribs__source_of_income",
            "value": "attribs__source_of_income",
            "itenantid": 12,
            "attribvalue": "NA"
          },
          { "label": "attribs__occupation", "value": "attribs__occupation", "itenantid": 12, "attribvalue": "NA}" },
          {
            "label": "attribs__termination_status",
            "value": "attribs__termination_status",
            "itenantid": 12,
            "attribvalue": "NA"
          },
          {
            "label": "attribs__ucic_id",
            "value": "attribs__ucic_id",
            "itenantid": 12,
            "type": "integer",
            "attribvalue": 543241
          },
          { "label": "attribs__city", "value": "attribs__city", "itenantid": 12, "attribvalue": "TN" },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 12, "attribvalue": "MH" },
          {
            "label": "attribs__address",
            "value": "attribs__address",
            "itenantid": 5,
            "attribvalue": "somewhere building, somwehere street"
          },
          { "label": "attribs__city", "value": "attribs__city", "itenantid": 5, "attribvalue": "mum" },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 5, "attribvalue": "mah" },
          {
            "label": "attribs__turnover",
            "value": "attribs__turnover",
            "itenantid": 5,
            "type": "integer",
            "attribvalue": 10
          },
          {
            "label": "attribs__declared_salary_max",
            "value": "attribs__declared_salary_max",
            "itenantid": 5,
            "type": "integer",
            "attribvalue": 240000000
          },
          { "label": "attribs__kyc_type", "value": "attribs__kyc_type", "itenantid": 5, "attribvalue": "MIN_KYC" },
          { "label": "attribs__city", "value": "attribs__city", "itenantid": 17, "attribvalue": "Bangalore" },
          { "label": "attribs__district", "value": "attribs__district", "itenantid": 17, "attribvalue": "KARNATAKA" },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 17, "attribvalue": "Telangana" },
          {
            "label": "attribs__pincode",
            "value": "attribs__pincode",
            "itenantid": 17,
            "type": "integer",
            "attribvalue": 400052
          },
          { "label": "attribs__country", "value": "attribs__country", "itenantid": 17, "attribvalue": "India" },
          {
            "label": "attribs__latitude",
            "value": "attribs__latitude",
            "itenantid": 17,
            "type": "integer",
            "attribvalue": 98
          },
          {
            "label": "attribs__longitude",
            "value": "attribs__longitude",
            "itenantid": 17,
            "type": "integer",
            "attribvalue": 34
          },
          {
            "label": "attribs__turnoverType",
            "value": "attribs__turnoverType",
            "itenantid": 17,
            "attribvalue": "SMALL"
          },
          {
            "label": "attribs__acceptanceType",
            "value": "attribs__acceptanceType",
            "itenantid": 17,
            "attribvalue": "OFFLINE"
          },
          {
            "label": "attribs__ownershipType",
            "value": "attribs__ownershipType",
            "itenantid": 17,
            "attribvalue": "PROPRIETOR"
          },
          { "label": "attribs__pan", "value": "attribs__pan", "itenantid": 17, "attribvalue": "DMWPS3969D" },
          { "label": "attribs__gstn", "value": "attribs__gstn", "itenantid": 17, "type": "integer", "attribvalue": 27 },
          { "label": "attribs__cin", "value": "attribs__cin", "itenantid": 17, "attribvalue": "U74120MH2015PTC265316" },
          { "label": "attribs__llpin", "value": "attribs__llpin", "itenantid": 17, "attribvalue": "AAA-1234" },
          {
            "label": "attribs__udyogAadhaar",
            "value": "attribs__udyogAadhaar",
            "itenantid": 17,
            "attribvalue": "XXXXXXXX7692"
          },
          {
            "label": "attribs__electricityBillNumber",
            "value": "attribs__electricityBillNumber",
            "itenantid": 17,
            "type": "integer",
            "attribvalue": 13254652
          },
          { "label": "attribs__dob", "value": "attribs__dob", "itenantid": 17, "type": "integer", "attribvalue": 2022 },
          { "label": "attribs__doi", "value": "attribs__doi", "itenantid": 17, "type": "integer", "attribvalue": 2022 },
          { "label": "attribs__tan", "value": "attribs__tan", "itenantid": 17, "attribvalue": "DMWPS3969D" },
          {
            "label": "attribs__dueDiligenceStatus",
            "value": "attribs__dueDiligenceStatus",
            "itenantid": 17,
            "attribvalue": "PAN-VERIFIED"
          },
          { "label": "attribs__status", "value": "attribs__status", "itenantid": 17, "attribvalue": "ACTIVE" },
          {
            "label": "attribs__modifiedAt",
            "value": "attribs__modifiedAt",
            "itenantid": 17,
            "type": "integer",
            "attribvalue": 2022
          },
          { "label": "attribs__partnerName", "value": "attribs__partnerName", "itenantid": 17, "attribvalue": "Paytm" },
          {
            "label": "attribs__ypmachsellerId",
            "value": "attribs__ypmachsellerId",
            "itenantid": 17,
            "type": "integer",
            "attribvalue": 256571
          },
          {
            "label": "attribs__partnerReferenceNumber",
            "value": "attribs__partnerReferenceNumber",
            "itenantid": 17,
            "attribvalue": "PT000BCD"
          },
          {
            "label": "attribs__sellerReferenceNumber",
            "value": "attribs__sellerReferenceNumber",
            "itenantid": 17,
            "attribvalue": "S222491000214"
          },
          {
            "label": "attribs__yppSellerId",
            "value": "attribs__yppSellerId",
            "itenantid": 17,
            "type": "integer",
            "attribvalue": 256571
          },
          {
            "label": "attribs__yppPartnerId",
            "value": "attribs__yppPartnerId",
            "itenantid": 17,
            "type": "integer",
            "attribvalue": 256571
          },
          {
            "label": "attribs__sellerIdentifier",
            "value": "attribs__sellerIdentifier",
            "itenantid": 17,
            "attribvalue": "SI91F5F4"
          },
          {
            "label": "attribs__address",
            "value": "attribs__address",
            "itenantid": 10,
            "attribvalue": "{{attribs.address}}"
          },
          {
            "label": "attribs__merchanttype",
            "value": "attribs__merchanttype",
            "itenantid": 10,
            "attribvalue": "{{attribs.merchant_type}}"
          },
          {
            "label": "attribs__kyc_status",
            "value": "attribs__kyc_status",
            "itenantid": 10,
            "attribvalue": "{{kycstatus}}"
          },
          {
            "label": "attribs__turnover",
            "value": "attribs__turnover",
            "itenantid": 10,
            "attribvalue": "{{attribs.annual_turnover}}"
          },
          { "label": "attribs__mcc", "value": "attribs__mcc", "itenantid": 10, "attribvalue": "{{attribs.mcc}}" },
          {
            "label": "attribs__category",
            "value": "attribs__category",
            "itenantid": 10,
            "attribvalue": "{{attribs.category}}"
          },
          { "label": "attribs__limit", "value": "attribs__limit", "itenantid": 6, "attribvalue": "{{account.limit}}" },
          {
            "label": "attribs__maxLimit",
            "value": "attribs__maxLimit",
            "itenantid": 6,
            "attribvalue": "{{account.maxLimit}}"
          },
          {
            "label": "attribs__programId",
            "value": "attribs__programId",
            "itenantid": 6,
            "attribvalue": "{{program_id}}"
          },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 6, "attribvalue": "{{state}}" },
          {
            "label": "attribs__withdrawalCreditLimit",
            "value": "attribs__withdrawalCreditLimit",
            "itenantid": 6,
            "attribvalue": "{{account.maxLimit}}"
          },
          { "label": "attribs__limit", "value": "attribs__limit", "itenantid": 7, "attribvalue": "{{account.limit}}" },
          {
            "label": "attribs__maxLimit",
            "value": "attribs__maxLimit",
            "itenantid": 7,
            "attribvalue": "{{account.maxLimit}}"
          },
          {
            "label": "attribs__programId",
            "value": "attribs__programId",
            "itenantid": 7,
            "attribvalue": "{{program_id}}"
          },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 7, "attribvalue": "{{state}}" },
          {
            "label": "attribs__withdrawalCreditLimit",
            "value": "attribs__withdrawalCreditLimit",
            "itenantid": 7,
            "attribvalue": "{{account.maxLimit}}"
          },
          { "label": "attribs__limit", "value": "attribs__limit", "itenantid": 20, "attribvalue": "{{account.limit}}" },
          {
            "label": "attribs__maxLimit",
            "value": "attribs__maxLimit",
            "itenantid": 20,
            "attribvalue": "{{account.maxLimit}}"
          },
          {
            "label": "attribs__programId",
            "value": "attribs__programId",
            "itenantid": 20,
            "attribvalue": "{{program_id}}"
          },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 20, "attribvalue": "{{state}}" },
          {
            "label": "attribs__withdrawalCreditLimit",
            "value": "attribs__withdrawalCreditLimit",
            "itenantid": 20,
            "attribvalue": "{{account.maxLimit}}"
          },
          { "label": "attribs__limit", "value": "attribs__limit", "itenantid": 24, "attribvalue": "{{account.limit}}" },
          {
            "label": "attribs__maxLimit",
            "value": "attribs__maxLimit",
            "itenantid": 24,
            "attribvalue": "{{account.maxLimit}}"
          },
          {
            "label": "attribs__programId",
            "value": "attribs__programId",
            "itenantid": 24,
            "attribvalue": "{{program_id}}"
          },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 24, "attribvalue": "{{state}}" },
          {
            "label": "attribs__withdrawalCreditLimit",
            "value": "attribs__withdrawalCreditLimit",
            "itenantid": 24,
            "attribvalue": "{{account.maxLimit}}"
          },
          { "label": "attribs__status", "value": "attribs__status", "itenantid": 14, "attribvalue": "Active" },
          {
            "label": "attribs__date_of_incorporation",
            "value": "attribs__date_of_incorporation",
            "itenantid": 14,
            "attribvalue": 20
          },
          {
            "label": "attribs__business_legal_name",
            "value": "attribs__business_legal_name",
            "itenantid": 14,
            "attribvalue": "XYZ"
          },
          { "label": "attribs__gender", "value": "attribs__gender", "itenantid": 14, "attribvalue": "Male" },
          {
            "label": "attribs__date_of_birth",
            "value": "attribs__date_of_birth",
            "itenantid": 14,
            "attribvalue": 20
          },
          {
            "label": "attribs__businessCategory",
            "value": "attribs__businessCategory",
            "itenantid": 14,
            "attribvalue": "XYZ"
          },
          {
            "label": "attribs__web_address",
            "value": "attribs__web_address",
            "itenantid": 14,
            "attribvalue": "www.xyz.com"
          },
          {
            "label": "attribs__address_line1",
            "value": "attribs__address_line1",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2
          },
          {
            "label": "attribs__address_line2",
            "value": "attribs__address_line2",
            "itenantid": 14,
            "attribvalue": "Gomti Nagar"
          },
          { "label": "attribs__city", "value": "attribs__city", "itenantid": 14, "attribvalue": "Lucknow" },
          { "label": "attribs__state", "value": "attribs__state", "itenantid": 14, "attribvalue": "UP" },
          { "label": "attribs__country", "value": "attribs__country", "itenantid": 14, "attribvalue": "India" },
          {
            "label": "attribs__postal_code",
            "value": "attribs__postal_code",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 226010
          },
          {
            "label": "attribs__groupId",
            "value": "attribs__groupId",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 12345678
          },
          {
            "label": "attribs__subGroupId",
            "value": "attribs__subGroupId",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 635872383
          },
          {
            "label": "attribs__businessChannel",
            "value": "attribs__businessChannel",
            "itenantid": 14,
            "attribvalue": "xyz"
          },
          {
            "label": "attribs__kyc_CreationDate",
            "value": "attribs__kyc_CreationDate",
            "itenantid": 14,
            "attribvalue": 20
          },
          {
            "label": "attribs__kyc_ApprovalDate",
            "value": "attribs__kyc_ApprovalDate",
            "itenantid": 14,
            "attribvalue": 20
          },
          {
            "label": "attribs__merchantCategory",
            "value": "attribs__merchantCategory",
            "itenantid": 14,
            "attribvalue": "xyz"
          },
          { "label": "attribs__poi_type", "value": "attribs__poi_type", "itenantid": 14, "attribvalue": "Adhar" },
          {
            "label": "attribs__poi_number",
            "value": "attribs__poi_number",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 98876253624783
          },
          {
            "label": "attribs__poi_expiry_date",
            "value": "attribs__poi_expiry_date",
            "itenantid": 14,
            "attribvalue": 20
          },
          { "label": "attribs__poa_type", "value": "attribs__poa_type", "itenantid": 14, "attribvalue": "abc" },
          {
            "label": "attribs__poa_number",
            "value": "attribs__poa_number",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 365234938327
          },
          {
            "label": "attribs__poa_expiry_date",
            "value": "attribs__poa_expiry_date",
            "itenantid": 14,
            "attribvalue": 20
          },
          { "label": "attribs__pob_type", "value": "attribs__pob_type", "itenantid": 14, "attribvalue": "somethign" },
          {
            "label": "attribs__pob_number",
            "value": "attribs__pob_number",
            "itenantid": 14,
            "attribvalue": "somehtign"
          },
          {
            "label": "attribs__pob_expiry_date",
            "value": "attribs__pob_expiry_date",
            "itenantid": 14,
            "attribvalue": 20
          },
          {
            "label": "attribs__cumulativeDailyTransactionVolume",
            "value": "attribs__cumulativeDailyTransactionVolume",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__cumulativeDailyTransactionCount",
            "value": "attribs__cumulativeDailyTransactionCount",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__cumulativeDailyTransactionExitCount",
            "value": "attribs__cumulativeDailyTransactionExitCount",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__cumulativeDailyTransactionExitVolume",
            "value": "attribs__cumulativeDailyTransactionExitVolume",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__cumulativeDailyRefundVolume",
            "value": "attribs__cumulativeDailyRefundVolume",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__cumulativeDailyRefundCount",
            "value": "attribs__cumulativeDailyRefundCount",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__cumulativeDailyRefundExitVolume",
            "value": "attribs__cumulativeDailyRefundExitVolume",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__cumulativeDailyRefundExitCount",
            "value": "attribs__cumulativeDailyRefundExitCount",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__dailyTransactionValue",
            "value": "attribs__dailyTransactionValue",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__dailyTransactionVolume",
            "value": "attribs__dailyTransactionVolume",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 2000
          },
          {
            "label": "attribs__deliveryPeriod",
            "value": "attribs__deliveryPeriod",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 9330
          },
          {
            "label": "attribs__internationalAcceptance",
            "value": "attribs__internationalAcceptance",
            "itenantid": 14,
            "attribvalue": "Y"
          },
          {
            "label": "attribs__business_type",
            "value": "attribs__business_type",
            "itenantid": 14,
            "attribvalue": "XYZ"
          },
          {
            "label": "attribs__business_division",
            "value": "attribs__business_division",
            "itenantid": 14,
            "attribvalue": "XYZ"
          },
          { "label": "attribs__merchantType", "value": "attribs__merchantType", "itenantid": 14, "attribvalue": "XYZ" },
          {
            "label": "attribs__proof_business_type",
            "value": "attribs__proof_business_type",
            "itenantid": 14,
            "attribvalue": "XYZ"
          },
          {
            "label": "attribs__program_category",
            "value": "attribs__program_category",
            "itenantid": 14,
            "attribvalue": "XYZ"
          },
          {
            "label": "attribs__program_referenceID",
            "value": "attribs__program_referenceID",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 123453211
          },
          { "label": "attribs__businessLine", "value": "attribs__businessLine", "itenantid": 14, "attribvalue": "XYZ" },
          {
            "label": "attribs__latitude",
            "value": "attribs__latitude",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 29
          },
          {
            "label": "attribs__longitude",
            "value": "attribs__longitude",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 30
          },
          {
            "label": "attribs__acceptanceType",
            "value": "attribs__acceptanceType",
            "itenantid": 14,
            "attribvalue": "XYZ"
          },
          {
            "label": "attribs__settlementFrequency",
            "value": "attribs__settlementFrequency",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 4990
          },
          {
            "label": "attribs__merchantBankName",
            "value": "attribs__merchantBankName",
            "itenantid": 14,
            "attribvalue": "Bank of India"
          },
          {
            "label": "attribs__auth_sign_firstName",
            "value": "attribs__auth_sign_firstName",
            "itenantid": 14,
            "attribvalue": ""
          },
          {
            "label": "attribs__auth_sign_middleName",
            "value": "attribs__auth_sign_middleName",
            "itenantid": 14,
            "attribvalue": ""
          },
          {
            "label": "attribs__auth_sign_lasttName",
            "value": "attribs__auth_sign_lasttName",
            "itenantid": 14,
            "attribvalue": ""
          },
          {
            "label": "attribs__auth_sign_registered_mobile",
            "value": "attribs__auth_sign_registered_mobile",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 9651888784
          },
          {
            "label": "attribs__auth_sign_email",
            "value": "attribs__auth_sign_email",
            "itenantid": 14,
            "attribvalue": "shivi.kaushik@gmail.com"
          },
          {
            "label": "attribs__auth_sign_address_line1",
            "value": "attribs__auth_sign_address_line1",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 145
          },
          {
            "label": "attribs__auth_sign_address_line2",
            "value": "attribs__auth_sign_address_line2",
            "itenantid": 14,
            "attribvalue": "Vijay Khand"
          },
          {
            "label": "attribs__auth_sign_state",
            "value": "attribs__auth_sign_state",
            "itenantid": 14,
            "attribvalue": "UP"
          },
          {
            "label": "attribs__auth_sign_country",
            "value": "attribs__auth_sign_country",
            "itenantid": 14,
            "attribvalue": "India"
          },
          {
            "label": "attribs__auth_sign_postal_code",
            "value": "attribs__auth_sign_postal_code",
            "itenantid": 14,
            "type": "integer",
            "attribvalue": 226010
          },
          {
            "label": "attribs__auth_sign_city",
            "value": "attribs__auth_sign_city",
            "itenantid": 14,
            "attribvalue": "Lko"
          },
          {
            "label": "attribs__mid_BlockedDate",
            "value": "attribs__mid_BlockedDate",
            "itenantid": 14,
            "attribvalue": "2024"
          },
          {
            "label": "attribs__mid_BlockedBy",
            "value": "attribs__mid_BlockedBy",
            "itenantid": 14,
            "attribvalue": "Shreejit"
          },
          {
            "label": "attribs__ip",
            "value": "attribs__ip",
            "itenantid": -1,
            "attribvalue": "101.188.67.134"
          },
          {
            "label": "attribs__kyc_status",
            "value": "attribs__kyc_status",
            "itenantid": -1,
            "attribvalue": "ACTIVE"
          },
          {
            "label": "attribs__postal_code",
            "value": "attribs__postal_code",
            "itenantid": -1,
            "attribvalue": "400080"
          },
          {
            "label": "attribs__business_type",
            "value": "attribs__business_type",
            "itenantid": -1,
            "attribvalue": "XYZ"
          },
          {
            "label": "attribs__merchant_type",
            "value": "attribs__merchant_type",
            "itenantid": -1,
            "attribvalue": "PROPRIETARY"
          },
          {
            "type": "integer",
            "label": "attribs__daily_txn_count",
            "value": "attribs__daily_txn_count",
            "itenantid": -1,
            "attribvalue": 100
          },
          {
            "label": "attribs__mcc_description",
            "value": "attribs__mcc_description",
            "itenantid": -1,
            "attribvalue": "Description of MCC"
          },
          {
            "label": "attribs__pob_expiry_date",
            "value": "attribs__pob_expiry_date",
            "itenantid": -1,
            "attribvalue": "EXPIRY_DATE"
          },
          {
            "type": "integer",
            "label": "attribs__daily_txn_amount",
            "value": "attribs__daily_txn_amount",
            "itenantid": -1,
            "attribvalue": 5000
          },
          {
            "label": "attribs__business_division",
            "value": "attribs__business_division",
            "itenantid": -1,
            "attribvalue": "ABC"
          },
          {
            "type": "integer",
            "label": "attribs__open_refund_limit",
            "value": "attribs__open_refund_limit",
            "itenantid": -1,
            "attribvalue": 50
          },
          {
            "type": "integer",
            "label": "attribs__closed_refund_limit",
            "value": "attribs__closed_refund_limit",
            "itenantid": -1,
            "attribvalue": 100
          },
          {
            "label": "attribs__proof_business_type",
            "value": "attribs__proof_business_type",
            "itenantid": -1,
            "attribvalue": "286918236"
          },
          {
            "type": "integer",
            "label": "attribs__open_daily_txn_count",
            "value": "attribs__open_daily_txn_count",
            "itenantid": -1,
            "attribvalue": 20
          },
          {
            "type": "integer",
            "label": "attribs__open_daily_txn_amount",
            "value": "attribs__open_daily_txn_amount",
            "itenantid": -1,
            "attribvalue": 2000
          },
          {
            "type": "integer",
            "label": "attribs__closed_daily_txn_count",
            "value": "attribs__closed_daily_txn_count",
            "itenantid": -1,
            "attribvalue": 70
          },
          {
            "type": "integer",
            "label": "attribs__closed_daily_txn_amount",
            "value": "attribs__closed_daily_txn_amount",
            "itenantid": -1,
            "attribvalue": 3000
          },
          {
            "label": "attribs__internationalFlagUpdate",
            "value": "attribs__internationalFlagUpdate",
            "itenantid": -1,

            "attribvalue": "Y"
          },
          {
            "type": "integer",
            "label": "attribs__open_daily_txn_refund_count",
            "value": "attribs__open_daily_txn_refund_count",
            "itenantid": -1,
            "attribvalue": 30
          },
          {
            "type": "integer",
            "label": "attribs__closed_daily_txn_refund_count",
            "value": "attribs__closed_daily_txn_refund_count",
            "itenantid": -1,
            "attribvalue": 20
          }
        ],
        "content": [
          {
            "ifsc*": "HDFC0001",
            "email*": "jogn.doe@gmail.con",
            "merchant": "FALSE",
            "externalId*": "dhkh338983082",
            "accountType*": 1,
            "customerType": "PERSON",
            "default_mcc*": 0,
            "postal_code*": 400671,
            "verifiedName": "",
            "customerName*": "JOHN DOE",
            "accountNumber*": "6700023456",
            "cust_categories": "",
            "onboarding_date*": "2019-09-07T15:50-04:00",
            "payment_address*": "john_doe",
            "iso_country_code*": "IN",
            "registered_mobile*": 9123412345,
            "address_geolocation": ""
          },
          {
            "ifsc*": "SBI112304",
            "email*": "seller@ybl.com",
            "merchant": "TRUE",
            "externalId*": "YB12345",
            "accountType*": 2,
            "customerType": "ENTITY",
            "default_mcc*": 5000,
            "postal_code*": 400671,
            "verifiedName": "",
            "customerName*": "SELLER",
            "accountNumber*": "6700023456",
            "cust_categories": "",
            "onboarding_date*": "2019-09-07T15:50-04:00",
            "payment_address*": "YBB1234",
            "iso_country_code*": "IN",
            "registered_mobile*": 9123412345,
            "address_geolocation": "12.913046, 77.596858"
          }
        ]
      }
    ],
    "fileName": "Simple_Customer_template"
  }
}
'::jsonb WHERE
configname = 'Bulk Upload Config'
