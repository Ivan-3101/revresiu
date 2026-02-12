alter table if exists ui.sectionmasters
       add column value_config jsonb;

INSERT INTO ui.sectionmasters (
sectionid, sectionname, taskpanelid, value_config) VALUES (
'5'::integer, 'Batch Trans Details'::character varying, '1'::integer, null::jsonb)
 returning sectionid;

UPDATE ui.sectionmasters SET
value_config = '{
  "QC": {
    "8": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "17": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcexternalcustid"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcexternalcustid"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vccustomername"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vccustomername"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcverifiedname"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcverifiedname"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcattribs.partnerName"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcattribs.partnerName"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "21": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "22": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "23": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    }
  },
  "QC POBO": {
    "16": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    }
  },
  "JPSL AML": {
    "14": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "15": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    }
  },
  "AML Cases": {
    "8": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "17": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcexternalcustid"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcexternalcustid"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vccustomername"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vccustomername"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcverifiedname"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcverifiedname"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcattribs.partnerName"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "finalpath",
                    "isVar": false,
                    "value": "observations.customer.vcattribs.partnerName"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "21": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "22": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    },
    "23": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    }
  },
  "Decentro AML": {
    "25": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    }
  },
  "AML Cases POBO": {
    "16": {
      "Batch Trans Details": {
        "value": [
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer VPA",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "id"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant ID",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "externalId"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Customer Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) === \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "merchantname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "task",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Merchant Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "businessName"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Verified Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "verifiedname"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.task"
                  }
                ]
              },
              "functionName": "getVal",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value === \"Batch\""
            }
          },
          {
            "label": "Partner Name",
            "customFunction": {
              "call": true,
              "isObjParam": false,
              "parameters": {
                "paths": [
                  {
                    "key": "path",
                    "isVar": false,
                    "value": "partnername"
                  },
                  {
                    "key": "formVariable",
                    "isVar": true,
                    "value": "data.formVariable"
                  }
                ]
              },
              "functionName": "getVal2",
              "renderCondition": "getEntity({ formVariable }) !== \"vpa\" && formVariable?.TransactionType?.value !== \"Batch\""
            }
          }
        ],
        "render": true
      }
    }
  }
}'::jsonb WHERE
sectionid = 5;

UPDATE ui.sectionmasters SET
value_config = '{
  "QC": {
    "8": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "17": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "21": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "22": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "23": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    }
  },
  "QC POBO": {
    "16": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    }
  },
  "default": {
    "value": {
      "FRM Failed Rules": {
        "render": true
      }
    }
  },
  "JPSL AML": {
    "14": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "15": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    }
  },
  "AML Cases": {
    "8": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "17": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "21": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "22": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    },
    "23": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    }
  },
  "Decentro AML": {
    "25": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    }
  },
  "AML Cases POBO": {
    "16": {
      "value": {
        "Batch Failed Rules": {
          "render": true
        }
      }
    }
  }
}'::jsonb WHERE
sectionid = 3;

UPDATE ui.sectionmasters SET
value_config = '{
  "default": {
    "frm": {
      "vpa": [
        {
          "from": "trans_json",
          "path": [
            "observations/payer/payer_vpa"
          ],
          "label": "Payer",
          "condition": null
        },
        {
          "from": "trans_json",
          "path": [
            "txn/amount"
          ],
          "label": "Amount",
          "condition": null
        },
        {
          "from": "trans_json",
          "path": [
            "observations/payee/payee_vpa"
          ],
          "label": "Payee",
          "condition": null
        }
      ],
      "account": [
        {
          "from": "trans_json",
          "path": [
            "observations/payer/account_id"
          ],
          "label": "Payer",
          "condition": null
        },
        {
          "from": "trans_json",
          "path": [
            "txn/amount"
          ],
          "label": "Amount",
          "condition": null
        },
        {
          "from": "trans_json",
          "path": [
            "observations/payee/account_id"
          ],
          "label": "Payee",
          "condition": null
        }
      ]
    },
    "batch": {
      "vpa": [
        {
          "from": "trans_json",
          "path": [
            "observations/customer/vccustomername"
          ],
          "label": "Merchant Name",
          "condition": null
        },
        {
          "from": "trans_json",
          "path": [
            "observations/customer/.vcexternalcustid"
          ],
          "label": "Merchant Id",
          "condition": null
        }
      ],
      "account": [
        {
          "from": "trans_json",
          "path": [
            "observations/customer/vccustomername"
          ],
          "label": "Customer Name",
          "condition": null
        },
        {
          "from": "trans_json",
          "path": [
            "observations/customer/.vcexternalcustid"
          ],
          "label": "Customer VPA",
          "condition": null
        }
      ]
    }
  }
}'::jsonb WHERE
sectionid = 2;

UPDATE ui.sectionmasters SET
value_config = '{
  "default": {
    "value": [
      {
        "label": "Risk Score",
        "customFunction": {
          "call": true,
          "isObjParam": false,
          "parameters": {
            "paths": [
              {
                "key": "score",
                "isVar": true,
                "value": "data.task.AvgRiskScore,data.task.riskScore"
              }
            ]
          },
          "functionName": "determineRiskData"
        }
      }
    ],
    "render": true
  }
}'::jsonb WHERE
sectionid = 1;
