DO $$ 
DECLARE
    -- Your variable containing the value for iorgid
    -- Replace 3 with the actual variable or value
    old_itenantid_value INT = 1;
    itenantid_value INT := 1001;
    vctenantname_value VARCHAR := 'SIT-Test';
    iorg_value INT := 1;
    madmin_email VARCHAR := 'madmin@sit.com';
    cadmin_email VARCHAR := 'cadmin@sit.com';
    api_key text ;
    drona_key text :='1234';
    -- tenant_value : =

BEGIN

    INSERT INTO ui.tenants VALUES (itenantid_value, NULL, NULL, '{}', 0, vctenantname_value, NULL, NULL, NULL, iorg_value, '{}');
    
    perform setval(pg_get_serial_sequence('ui.tenants', 'itenantid'), 
        (SELECT MAX(itenantid) FROM ui.tenants)
    );

    INSERT INTO masters.tenants VALUES (itenantid_value, iorg_value, vctenantname_value, '{}', '{}', 0, CURRENT_TIMESTAMP);
    
    perform setval(pg_get_serial_sequence('masters.tenants', 'itenantid'), 
        (SELECT MAX(itenantid) FROM masters.tenants)
    );

    CALL masters.partition_for_tenants(iorg_value);

    CALL masters.partition_for_orgs(iorg_value);

SELECT gen_random_uuid()::text into api_key;

-- copy this id and paste it in the api_key_uuid
-- For internal environments, copy this id and maintain it in an xlsx
-- paste the drona.key's value from UIServer properties in encryption_code
-- and make the value in itenantid_value for the tenants
-- And make change in expiry date
UPDATE ui.tenants
SET config = jsonb_set(
    config,
    '{api-keys}',
    jsonb_build_array(
        jsonb_build_object(
            'expiry', '2025-05-31',
            'api-key',pgp_sym_encrypt(api_key, drona_key)::text
        )
    ),
    true
) WHERE itenantid = itenantid_value;

-- copy this id and paste it in the api_key_uuid
-- And make change in expiry date
UPDATE masters.tenants
SET config = jsonb_set(
    config,
    '{api-keys}',
    jsonb_build_array(
        jsonb_build_object(
            'expiry', '2025-05-31',
            'api-key', encode(digest(api_key, 'sha256'), 'hex')::text
			
        )
    ),
    true
) WHERE itenantid = itenantid_value;


/* --------------------  ui.validationfieldslist ---------------------------------*/
    perform setval(pg_get_serial_sequence('ui.validationfieldslist', 'ifieldid'), 
        (SELECT coalesce(max(ifieldid) , 1) FROM ui.validationfieldslist)
    );

    INSERT INTO ui.validationfieldslist (
        bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
    select bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid_value
        from ui.validationfieldslist where itenantid = old_itenantid_value;

/* ------------------------------- Inserting into groupdesc - groups for camunda -------------------------------*/

    INSERT INTO ui.groupdesc(
	    igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid, iorgid)
    SELECT igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid_value ,iorgid
        FROM ui.groupdesc WHERE itenantid = old_itenantid_value ;

/* ------------------------------- Inserting into roledesc - roles ------------------------------- */

    INSERT INTO ui.roledesc(
        iroleid,dtentrystamp, vcrolename, istatus, itenantid, iorgid)
    SELECT iroleid,dtentrystamp, vcrolename, istatus, itenantid_value, iorgid
	    FROM ui.roledesc WHERE itenantid = old_itenantid_value;


/* ------------------------------- Inserting into rolemenuaccessmap - ------------------------------- */

    INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
        SELECT irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,  itenantid_value, iorgid 
    FROM ui.rolemenuaccessmap where itenantid = old_itenantid_value ;
    
    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT -1, 'Workflow', wb.iuserid,wb.iorgid,itenantid_value
            FROM  ui.webuser wb
        WHERE  wb.iorgid = iorg_value 
        and wb.vcusername in (madmin_email, cadmin_email);


    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT -1, 'TransactionClass', wb.iuserid, wb.iorgid, itenantid_value
        FROM  ui.webuser wb
        WHERE  wb.iorgid = iorg_value 
        and wb.vcusername in (madmin_email, cadmin_email);


    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT itenantid_value, 'Tenant', wb.iuserid, wb.iorgid, itenantid_value
        FROM  ui.webuser wb
        WHERE  wb.iorgid = iorg_value 
        and wb.vcusername in (madmin_email, cadmin_email);
        
    /* ------------------------------- Inserting into dashboard - different dashboards -------------------------------*/
    
    INSERT INTO ui.dashboard(idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) 
        SELECT idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid_value, bdynamic 
        from ui.dashboard WHERE itenantid = old_itenantid_value ;
    
    /* ------------------------------- Inserting into dashboardqueries - different queries -------------------------------*/
    
    INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) 
	SELECT idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid_value
        FROM ui.dashboardquery WHERE itenantid = old_itenantid_value ;
        

    INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) 
        SELECT idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid_value 
        FROM ui.dashboardqueryparameters WHERE itenantid = old_itenantid_value;

    INSERT INTO ui.dashboardresultset(idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid) 
        SELECT idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid_value, iorgid
        FROM ui.dashboardresultset WHERE itenantid = old_itenantid_value;


        INSERT INTO ui.sectionparameters(isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid, itenantid) 
        SELECT isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid, itenantid_value
        FROM ui.sectionparameters WHERE itenantid = old_itenantid_value;

        INSERT INTO ui.dashboardfilters(idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) 
        SELECT idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid_value, vcdashboardfilterdisplayname
        FROM ui.dashboardfilters WHERE itenantid = old_itenantid_value ;

        INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) 
        select attribpath, level, datatype, displayname, itenantid_value
        FROM ui.masterextractattribs where itenantid = old_itenantid_value ;


        INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey, manual_display_name, is_manual_creation, is_filter_display, itenantid, filterparams, displayconfig) 
        select workflowid, workflowname, workflowkey, manual_display_name, is_manual_creation, is_filter_display, itenantid_value, filterparams, displayconfig
        from ui.workflowmasters where itenantid = old_itenantid_value;


        INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid)
        select iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid_value
        from ui.tasklhsmap where itenantid = old_itenantid_value;


        INSERT INTO ui.emailtemplate(id, body, subject, associateid, response, camunda_message_name, itenantid)
        select id, body, subject, associateid, response, camunda_message_name, itenantid_value 
        from ui.emailtemplate where itenantid =  old_itenantid_value;


        INSERT INTO ui.listmaster(ilistmasterid,ifordays, vcname, itenantid)
        select ilistmasterid,ifordays, vcname, itenantid_value
        from ui.listmaster where itenantid = old_itenantid_value;

        perform setval(pg_get_serial_sequence('ui.grouptotaskfiltermap', 'igrouptotaskfilterid'), 
        (SELECT coalesce(max(igrouptotaskfilterid) , 1) FROM ui.grouptotaskfiltermap)
        );

        INSERT INTO ui.grouptotaskfiltermap ( iposition, igroupid, itaskfilterid, itenantid) 
        select iposition, igroupid, itaskfilterid, itenantid_value
        from ui.grouptotaskfiltermap where itenantid = old_itenantid_value;

        INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid) 
        select panelaccessmap, panelid, groupid, workflowid, itenantid_value
        from ui.panelaccessmap where itenantid = old_itenantid_value; 
        
        INSERT INTO camunda.act_id_tenant (id_, rev_, name_) 
        SELECT cast(itenantid as VARCHAR), 1, vctenantid from ui.tenants WHERE iorgid = iorg_value and itenantid = itenantid_value ;

        INSERT INTO camunda.act_id_tenant_member(id_, tenant_id_, user_id_)
        SELECT ENCODE(gen_random_bytes(32), 'hex'), wbm.itenantid::varchar, wbm.webuserid::varchar
	    FROM ui.webusermapping wbm 
	    join camunda.act_id_user aiu on aiu.id_ = wbm.webuserid::varchar
	    where mappingtype='Tenant' and aiu.email_ in (cadmin_email, madmin_email) and  wbm.itenantid = itenantid_value ;

        INSERT INTO ui.webusermapping(mappingid,mappingtype, webuserid, iorgid, itenantid)
        SELECT DISTINCT wb.igroupid,'Group',wb1.iuserid,iorg_value,itenantid_value
        FROM  ui.groupdesc wb, ui.webuser wb1
        WHERE wb.itenantid =itenantid_value AND wb1.iorgid = iorg_value and wb1.vcusername in (cadmin_email, madmin_email);

        
        CALL masters.add_monthly_partitions_to_trans(
            (CONCAT(TO_CHAR(DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month'), 'YYYY'), LPAD(TO_CHAR(DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month'), 'MM'), 2, '0'))),
            ((DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month'))::date),
            ((DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 day')::date)
        );

        CALL masters.add_monthly_partitions_to_trans(
            (CONCAT(TO_CHAR(CURRENT_DATE, 'YYYY'), LPAD(TO_CHAR(CURRENT_DATE, 'MM'), 2, '0'))),
            (DATE_TRUNC('month', CURRENT_DATE)::date),
            ((DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month')::date)
        );


        CALL masters.add_monthly_partitions_to_trans(
            (CONCAT(TO_CHAR(DATE_TRUNC('month', CURRENT_DATE + INTERVAL '1 month'), 'YYYY'), LPAD(TO_CHAR(DATE_TRUNC('month', CURRENT_DATE + INTERVAL '1 month'), 'MM'), 2, '0'))),
            ((DATE_TRUNC('month', CURRENT_DATE)+ INTERVAL '1 month')::date),
            ((DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '2 month')::date)
        );


END $$;


INSERT INTO ui.workflowmasters (
workflowid, workflowname, workflowkey, is_manual_creation, is_filter_display, itenantid, filterparams, displayconfig, isautoclose) VALUES (
'26'::integer, 'AML Workflow'::character varying, 'AML_Workflow'::character varying, false::boolean, true::boolean, '1001'::integer, '[
  {
    "name": "TransactionClass",
    "data_type": "string",
    "value_config": {
      "value": "/txn/class",
      "extract_from": "trans_json"
    }
  }
]'::jsonb, '[
  {
    "type": "sortingOptions",
    "render": false,
    "options": [
      {
        "key": "parameters.sorting[]",
        "value": "Created Date",
        "bodyValue": {
          "my": {
            "key": "sortBy",
            "value": "starttime"
          },
          "open": {
            "key": "sortBy",
            "value": "starttime"
          },
          "closed": {
            "key": "sortBy",
            "value": "starttime"
          },
          "myclosed": {
            "key": "sortBy",
            "value": "starttime"
          }
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "created",
              "setKeyIf": {
                "or": [
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Open"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortBy",
              "value": "startTime",
              "setKeyIf": {
                "or": [
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              }
            }
          ]
        }
      },
      {
        "key": "parameters.sorting[]",
        "value": "Risk Score",
        "bodyValue": {
          "key": "sortBy",
          "value": "riskscore"
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable",
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "parameters",
              "value": {
                "type": "long",
                "variable": "RiskScore"
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            }
          ]
        }
      },
      {
        "key": "parameters.sorting[]",
        "value": "Transaction Amount",
        "bodyValue": {
          "key": "sortBy",
          "value": "amount"
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable",
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "parameters",
              "value": {
                "type": "double",
                "variable": "TransactionAmount"
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            }
          ]
        }
      }
    ],
    "compareValue": true
  },
  {
    "key": "parameters.tenantIdIn",
    "name": "TenantId",
    "type": "multiSelect",
    "label": "Tenant",
    "value": {
      "jsonLogic": {
        "var": "data.formData.TenantId"
      }
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.tenantOptions"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "key": "data.formData.TenantId",
          "TRUE": {
            "key": "data.formData.TenantId",
            "type": "array"
          },
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.tenantOptions",
            "map": "itenantId",
            "type": "array"
          },
          "action": "checkLength"
        }
      ]
    },
    "keyToExtract": "itenantId",
    "maxSelectable": 1,
    "onChangeAction": [
      {
        "key": "callApi",
        "body": [
          {
            "PARSEINT": true,
            "lodashKey": "data.formData.TenantId",
            "bodyKeyName": "tenants"
          }
        ],
        "route": "/api/v1/admin/app-users/get-all-workflows/${menuName}",
        "RequestType": "POST",
        "paramValues": [
          {
            "value": "Tasks"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "workFlowNamesDrop"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormDataAll"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filter.inputJson"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "apiOptions"
          }
        ]
      }
    ]
  },
  {
    "key": {
      "value": "parameters.processDefinitionKeyIn",
      "closed": {
        "key": "parameters.orQueries",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "key": "value",
                  "keyToExtract": "label"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          }
        }
      },
      "myclosed": {
        "key": "parameters.orQueries[].processVariables",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "key": "value",
                  "keyToExtract": "label"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          }
        }
      }
    },
    "name": "CaseType",
    "type": "multiSelect",
    "label": "Case Type",
    "value": {
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.workFlowNamesDrop"
      }
    },
    "bodyValue": {
      "key": "defKey",
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "key": "data.formData.CaseType",
          "TRUE": {
            "key": "data.formData.CaseType",
            "type": "array"
          },
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.workFlowNamesDrop",
            "map": "workflowKey",
            "type": "array"
          },
          "action": "checkLength"
        }
      ]
    },
    "keyToExtract": "workflowKey",
    "maxSelectable": 1,
    "onChangeAction": [
      {
        "key": "callApi",
        "route": "/api/v1/task/filter/config/${paramOne}/${paramTwo}",
        "RequestType": "GET",
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]",
            "paramValueHardCode": "workflowid"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputJson"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormDataWorkflow"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filter.inputJson"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "apiOptions"
          }
        ]
      }
    ]
  },
  {
    "key": {
      "my": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "open": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "closed": {
        "key": "parameters.startedAfter,parameters.finsihedBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "myclosed": {
        "key": "parameters.startedAfter,parameters.finsihedBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      }
    },
    "name": "startDate,endDate,startedAfter,finsihedBefore",
    "type": "dateRange",
    "label": "Date Range",
    "valueKey": "dataRangeValueKey",
    "bodyValue": {
      "key": "startDate,endDate,startedAfter,finsihedBefore",
      "lodashKey": "data.formData.startDate,data.formData.endDate,data.formData.startDate,data.formData.endDate"
    },
    "multipleKeyName": "[0],[1],[0],[1]"
  },
  {
    "key": {
      "value": "parameters.taskDefinitionKeyIn",
      "lodashKey": "data.formData.Status"
    },
    "name": "Status",
    "type": "multiSelect",
    "label": "Status",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.statusOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/case-management/tasks/get-status/tenant-id/${tenantid}/workflow-key/${workflowKey}",
      "body": {
        "keys": [
          {
            "key": "maxResult",
            "valueKey": "indexLogic.maximumResult.value"
          },
          {
            "key": "parameters",
            "valueKey": "indexLogic?.taskSelect?.value"
          }
        ]
      },
      "RequestType": "POST",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        },
        {
          "key": "data.formData.CaseType[0]"
        }
      ],
      "responseKey": "statusOptions"
    },
    "isClearable": true,
    "keyToExtract": "value"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      }
    },
    "min": 0,
    "name": "TransactionAmount",
    "type": "number",
    "label": "Transaction Amount",
    "compareOperator": {
      "name": "TransactionAmountCompareOperator",
      "type": "select",
      "options": [
        {
          "label": "=",
          "value": "eq"
        },
        {
          "label": "<",
          "value": "lt"
        },
        {
          "label": ">",
          "value": "gt"
        }
      ]
    }
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "setKeyIf": {
            "and": [
              {
                "if": [
                  {
                    "!=": [
                      {
                        "var": "data.formData.Address"
                      },
                      null
                    ]
                  },
                  {
                    "!=": [
                      {
                        "var": "data.formData.Address"
                      },
                      ""
                    ]
                  },
                  true,
                  false
                ]
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      }
    },
    "name": "LevelType",
    "type": "object",
    "fields": [
      {
        "name": "levelSelectMain",
        "type": "select",
        "label": "Level",
        "options": [
          {
            "label": "Account",
            "value": "Account"
          },
          {
            "label": "VPA",
            "value": "VPA"
          }
        ],
        "onChangeAction": [
          {
            "key": "setOtherKey",
            "keyToSet": "LevelType",
            "keyValue": {
              "jsonLogic": {
                "if": [
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payerAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payeeAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payer",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payee",
                  "address"
                ]
              }
            }
          }
        ]
      },
      {
        "name": "typeSelectMain",
        "type": "select",
        "label": "Type",
        "options": [
          {
            "label": "Payer",
            "value": "Payer"
          },
          {
            "label": "Payee",
            "value": "Payee"
          },
          {
            "label": "Profile",
            "value": "address"
          }
        ],
        "onChangeAction": [
          {
            "key": "setOtherKey",
            "keyToSet": "LevelType",
            "keyValue": {
              "jsonLogic": {
                "if": [
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payerAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payeeAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payer",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payee",
                  "address"
                ]
              }
            }
          }
        ]
      }
    ]
  },
  {
    "name": "Address",
    "type": "text",
    "label": "Address"
  },
  {
    "name": "NoOfCases",
    "type": "select",
    "label": "No Of Cases",
    "options": [
      {
        "label": "20",
        "value": 20
      },
      {
        "label": "30",
        "value": 30
      },
      {
        "label": "50",
        "value": 50
      }
    ],
    "bodyValue": {
      "key": "maxResult",
      "lodashKey": "data.formData.NoOfCases"
    }
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "gteq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "max": 100,
    "min": 0,
    "name": "RiskScore",
    "type": "number",
    "label": "Risk Score ( >= )"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "arrayKey": true
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      }
    },
    "name": "Rule",
    "type": "multiSelect",
    "label": "Rule",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.ruleOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/case-management/tasks/get-rules-dropdown/Tasks/tenant-id/${tenantId}",
      "body": {
        "keys": [
          {
            "key": "maxResult",
            "valueKey": "indexLogic.maximumResult.value"
          },
          {
            "key": "parameters",
            "valueKey": "indexLogic?.taskSelect?.value"
          }
        ]
      },
      "RequestType": "GET",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        }
      ],
      "responseKey": "ruleOptions"
    },
    "keyToExtract": "value"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "TransactionClass",
    "type": "select",
    "label": "Transaction Class",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.classDropDownOption.dropDownOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/generic-dashboard/get-transaction-classes/Tasks/tenant-id/${tenant}",
      "RequestType": "GET",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        }
      ],
      "responseKey": "classDropDownOption"
    },
    "isClearable": true
  }
]'::jsonb, false::boolean)
 returning workflowid,itenantid;

 INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 2, 2, 26, 8, '{"tag": "span", "path": "this.name", "type": "default"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 2, 1, 26, 8, '{"tag": "span", "path": "this.name", "type": "default"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 2, 26, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 1, 26, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 3, 26, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 1, 26, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 2, 26, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 2, 2, 26, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 2, 1, 26, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 1, 26, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 1, 26, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 2, 26, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 3, 26, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 2, 3, 26, 8, '{"tag": "span", "path": "this.name", "type": "default"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 2, 26, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 3, 26, 12, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 2, 3, 26, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 3, 26, 6, '{"tag": "span", "path": "this.startTime", "type": "timestamp"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 0, 4, 26, 4, '{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 0, 4, 26, 6, '{"tag": "span", "path": "this.created", "type": "timestamp"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (0, 1, 4, 26, 8, '{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (2, 0, 4, 26, 2, '{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}', 1001);
INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid) VALUES (1, 1, 4, 26, 4, '{"tag": "span", "path": "this.variables.WorkflowName", "type": "default", "className": "d-block text-right normal-span-text"}', 1001);





INSERT INTO ui.groupdesc (igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid, iorgid)
VALUES
-- Tenant 1
--(1, 'usermgmt', 'usermgmt', 'INTERNAL', 1, 1, 1),
(2042, 'riskanalyst', 'Risk Analyst', 'WORKFLOW', 1, 1, 1),
(2058, 'risksupervisor', 'Risk Supervisor', 'WORKFLOW', 1, 1, 1),
(2059, 'level1', 'L1', 'WORKFLOW', 1,  1, 1),
(2060, 'level2', 'L2', 'WORKFLOW', 1, 1, 1),
(2061, 'level3', 'L3', 'WORKFLOW', 1,  1, 1),

-- Tenant 2
--(1, 'usermgmt', 'usermgmt', 'INTERNAL', 1, 2, 1),
(2042, 'riskanalyst', 'Risk Analyst', 'WORKFLOW', 1,  2, 1),
(2058, 'risksupervisor', 'Risk Supervisor', 'WORKFLOW', 1, 2, 1),
(2059, 'level1', 'L1', 'WORKFLOW', 1, 2, 1),
(2060, 'level2', 'L2', 'WORKFLOW', 1, 2, 1),
(2061, 'level3', 'L3', 'WORKFLOW', 1, 2, 1),

-- Tenant 3
--(1, 'usermgmt', 'usermgmt', 'INTERNAL', 1, 3, 1),
(2042, 'riskanalyst', 'Risk Analyst', 'WORKFLOW', 1, 3, 1),
(2058, 'risksupervisor', 'Risk Supervisor', 'WORKFLOW', 1,  3, 1),
(2059, 'level1', 'L1', 'WORKFLOW', 1, 3, 1),
(2060, 'level2', 'L2', 'WORKFLOW', 1, 3, 1),
(2061, 'level3', 'L3', 'WORKFLOW', 1, 3, 1),

-- Tenant 1001
--(1, 'usermgmt', 'usermgmt', 'INTERNAL', 1, 1001, 1),
(2042, 'riskanalyst', 'Risk Analyst', 'WORKFLOW', 1,  1001, 1),
(2058, 'risksupervisor', 'Risk Supervisor', 'WORKFLOW', 1, 1001, 1),
(2059, 'level1', 'L1', 'WORKFLOW', 1, 1001, 1),
(2060, 'level2', 'L2', 'WORKFLOW', 1,  1001, 1),
(2061, 'level3', 'L3', 'WORKFLOW', 1,  1001, 1);
