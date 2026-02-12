

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (49, true, '{"Party" : null, "Address" : null}', '{
    "Account":"SELECT \"Rule Name\" as \"name\", count(\"Count\") as \"count\" from ui.get_account_wise_rules_triggered(current_date) where \"Acc. External ID\" = :Address group by \"Rule Name\";",
    "VPA": "SELECT \"Rule Name\" as \"name\", count(\"Count\") as \"count\" from ui.get_account_wise_rules_triggered(current_date) where \"Acc. External ID\" = (select vcexternalaccountid from masters.accounts a left join masters.vpa v on v.iaccountid= a.iaccountid where vcexternaladdressid = :Address) group by \"Rule Name\";"
}', false, false, false);


INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (50, false, NULL, 'SELECT X.* FROM   (VALUES (''Average Risk Score'', 70)) AS X ("name", "value");', false, false, false);

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (51, false, '{"Party": null, "Address": null}', '{
    "Account":"SELECT X.* FROM   (VALUES (''Total Value As Payer'',(SELECT pv.engagement->>''TotalValue'' FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where v.vcexternalaccountid = :Address and bside = false order by tdate desc limit 1))) AS X (\"name\", \"value\");",
    "VPA": "SELECT X.* FROM   (VALUES (''Total Value As Payer'',(SELECT pv.engagement->>''TotalValue'' FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where v.vcexternaladdressid = :Address and bside = false order by tdate desc limit 1))) AS X (\"name\", \"value\");"
}', false, false, false);


INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (52, false, '{"Party": null, "Address": null}', '{
    "Account":"SELECT X.* FROM   (VALUES (''Average Value As Payer'',(SELECT pv.engagement->>''AverageValue'' FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where v.vcexternalaccountid = :Address and bside = false order by tdate desc limit 1))) AS X (\"name\", \"value\");",
    "VPA": "SELECT X.* FROM   (VALUES (''Average Value As Payer'',(SELECT pv.engagement->>''AverageValue'' FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where v.vcexternaladdressid = :Address and bside = false order by tdate desc limit 1))) AS X (\"name\", \"value\");"
}', false, false, false);


INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (53, false, '{"Party": null, "Address": null}', '{
    "Account":"SELECT X.* FROM   (VALUES (''Total Value As Payee'', (SELECT pv.engagement->>''TotalValue'' FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where v.vcexternalaccountid = :Address and bside = true order by tdate desc limit 1))) AS X (\"name\", \"value\");",
    "VPA": "SELECT X.* FROM   (VALUES (''Total Value As Payee'', (SELECT pv.engagement->>''TotalValue'' FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where v.vcexternaladdressid = :Address and bside = true order by tdate desc limit 1 ))) AS X (\"name\", \"value\");"
}', false, false, false);


INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (54, false, '{"Party": null, "Address": null}', '{
    "Account":"SELECT X.* FROM   (VALUES (''Average Value As Payee'',(SELECT pv.engagement->>''AverageValue'' FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where v.vcexternalaccountid = :Address and bside = true order by tdate desc limit 1)) ) AS X (\"name\", \"value\");",
    "VPA": "SELECT X.* FROM   (VALUES (''Average Value As Payee'', (SELECT pv.engagement->>''AverageValue'' FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where v.vcexternaladdressid = :Address and bside = true order by tdate desc limit 1 )) ) AS X (\"name\", \"value\");"
}', false, false, false);


INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (46, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null, "Class" : null}', '{
    "All":
    {
        "VPA" : {
            "Payer" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeraddr = :useraddress and (CAST(dttrxntime AS date) between :StartDate and  :EndDate) order by dttrxntime desc;",
            "Payee" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeeaddr = :useraddress and (CAST(dttrxntime AS date) between :StartDate and  :EndDate) order by dttrxntime desc;",
            "Both" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where (vcpayeraddr = :useraddress or vcpayeeaddr = :useraddress  ) and (CAST(dttrxntime AS date) between :StartDate and :EndDate) order by dttrxntime desc;"
        },
        "Account": {
            "Payer" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeraccountexternalid = :useraddress and (CAST(dttrxntime AS date) between :StartDate and :EndDate) order by dttrxntime desc;",
            "Payee" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeeaccountexternalid = :useraddress and (CAST(dttrxntime AS date) between :StartDate and  :EndDate) order by dttrxntime desc;",
            "Both" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where (vcpayeraccountexternalid = :useraddress or vcpayeeaccountexternalid = :useraddress ) and (CAST(dttrxntime AS date) between :StartDate and :EndDate) order by dttrxntime desc;"
       }
    },
    "Other":
    {
        "VPA" : {
            "Payer" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeraddr = :useraddress and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between :StartDate and  :EndDate) order by dttrxntime desc;",
            "Payee" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeeaddr = :useraddress and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between :StartDate and  :EndDate) order by dttrxntime desc;",
            "Both" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where (vcpayeraddr = :useraddress or vcpayeeaddr = :useraddress ) and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between :StartDate and  :EndDate) order by dttrxntime desc;"
        },
        "Account": {
            "Payer" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeraccountexternalid = :useraddress and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between :StartDate and  :EndDate) order by dttrxntime desc;",
            "Payee" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeeaccountexternalid = :useraddress and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between :StartDate and  :EndDate) order by dttrxntime desc;",
            "Both" : "select ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where (vcpayeraccountexternalid = :useraddress or vcpayeeaccountexternalid = :useraddress )  and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between :StartDate and :EndDate) order by dttrxntime desc;"
       }
    }
}', false, true, false);


  UPDATE ui.dashboardquery
  	SET   vcdashboardquery =  '{
      "Account":"with recursive profile as ( SELECT * FROM masters.accounts limit 1000), flat ( iaccountid, key, value) as ( select iaccountid,'''', cast(format(''{\"iaccountid\":\"%s\",\"icustomerid\":\"%s\",\"vcexternalaccountid\":\"%s\",\"iaccounttypeid\":\"%s\" ,\"vcaccount\":\"%s\" ,\"vcifsc\":\"%s\",\"vcaccountproviderid\":\"%s\",\"vcaccountname\":\"%s\",\"dtonboardingdate\":\"%s\",\"dtexpirydate\":\"%s\" ,\"imcc\":\"%s\",\"bverified\":\"%s\"}'',cast(iaccountid as text),cast(icustomerid as text),vcexternalaccountid, cast(iaccounttypeid as text),vcaccount, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, cast(imcc as text), cast(bverified as text)) as jsonb) as value from profile \n union select  iaccountid,concat( ''attrib.'', key), value from profile, jsonb_each(vcattribs) \n union select  iaccountid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select iaccountid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by iaccountid) a;",
      "VPA": "with recursive profile as ( SELECT * FROM masters.vpa limit 1000), flat ( ivpaid, key, value) as ( select ivpaid,'''', cast(format(''{\"ivpaid\":\"%s\",\"iaccountid\":\"%s\",\"vcexternaladdressid\":\"%s\",\"vcaddress\":\"%s\" ,\"iproductid\":\"%s\" ,\"vcvpaname\":\"%s\",\"bverified\":\"%s\",\"imcc\":\"%s\",\"dtonboardingdate\":\"%s\",\"dtexpirydate\":\"%s\" ,\"bmerchant\":\"%s\",\"ivpaproviderid\":\"%s\",\"bprofiled\":\"%s\",\"dtfirsttransaction\":\"%s\" ,\"dtlasttransaction\":\"%s\"}'', cast(ivpaid as text),cast(iaccountid as text), vcexternaladdressid,vcaddress, cast(iproductid as text), vcvpaname,bverified, cast(imcc as text),dtonboardingdate, dtexpirydate,  bmerchant, ivpaproviderid, bprofiled,  dtfirsttransaction,dtlasttransaction) as jsonb) as value from profile \n union select  ivpaid,concat( ''attrib.'', key), value from profile, jsonb_each(vcattribs) \n union select  ivpaid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select ivpaid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by ivpaid) a;"
  }' where idashboardqueryid=48;

 INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid) VALUES (22, NULL, NULL, '{"sizes":[1,0],"detail":{"main":null},"mode":"globalFilters","master":{"widgets":["PERSPECTIVE_GENERATED_ID_3"],"sizes":[1]},"viewers":{"PERSPECTIVE_GENERATED_ID_3":{"plugin":"Custom Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Material Dark","group_by":[],"split_by":[],"columns":["ILiveMessageID","UniqueID","Class","Type","Time","Amount","Score","FRMPass","PayerVPA","PayeeVPA","PayerName","PayeeName","Payer Account","Payee Account"],"filter":[],"sort":[["Time","desc"]],"expressions":["//Type\n    if (is_not_null(\"Payer Account\") and   is_not_null(\"Payee Account\")) {\n        ''A2A''\n    } else if (is_not_null(\"Payer Account\")) {\n        ''A2P''\n    } else if (is_not_null(\"Payee Account\")) {\n        ''P2A''\n    }else\n    {\n        ''-''\n    }"],"aggregates":{},"master":true,"name":"Transactions","table":"vpatransaction","linked":false,"selectable":"true"}}}', 'partydashboard', 46, NULL, '{
       "ILiveMessageID":"string",
       "UniqueID":"string",
       "Class":"string",
       "Time":"datetime",
       "PayerVPA":"string",
       "PayerName":"string",
       "PayeeVPA":"string",
       "PayeeName":"string",
       "Amount":"float",
       "FRMPass":"string",
       "Score":"integer",
       "FailedRule":"string",
       "Payer Account":"string",
       "Payee Account":"string",
       "Rule Score":"integer",
       "Order":"integer",
       "Remarks":"string",
       "RuleName":"string",
       "Date":"date"
    }', NULL, NULL, NULL, NULL);


INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (65, 'txnClass', 'JsonPath', 46, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (66, 'party', 'JsonPath', 46, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (67, 'userType', 'JsonPath', 46, 2);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (68, 'useraddress', 'String', 46, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (85, 'DateRange', 'DateRange', 46, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (76, 'Party', 'JsonPath', 51, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (77, 'Address', 'String', 51, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (78, 'Party', 'JsonPath', 52, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (79, 'Address', 'String', 52, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (80, 'Party', 'JsonPath', 53, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (81, 'Address', 'String', 53, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (82, 'Party', 'JsonPath', 54, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (83, 'Address', 'String', 54, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (75, 'Address', 'String', 49, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (84, 'Party', 'JsonPath', 49, 0);

CREATE TABLE ui.sectionparameters (
    isectionid integer NOT NULL,
    bactive boolean,
    bdelete boolean,
    vcparamname character varying(255),
    vcsectionname character varying(255),
    idashboardqueryid integer
);


ALTER TABLE ui.sectionparameters ALTER COLUMN isectionid ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME ui.sectionparameters_isectionid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


INSERT INTO ui.sectionparameters (isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid) VALUES (1, true, false, NULL, 'rule', 49);
INSERT INTO ui.sectionparameters (isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid) VALUES (2, true, false, 'Days In System', 'summary', 50);
INSERT INTO ui.sectionparameters (isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid) VALUES (3, true, false, 'Transaction Count As Payer', 'summary', 51);
INSERT INTO ui.sectionparameters (isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid) VALUES (4, true, false, 'Transaction Count As Payee', 'summary', 52);
INSERT INTO ui.sectionparameters (isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid) VALUES (5, true, false, 'Average Value As Payer', 'summary', 53);
INSERT INTO ui.sectionparameters (isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid) VALUES (6, true, false, 'Average Value As Payee', 'summary', 54);

ALTER TABLE ONLY ui.sectionparameters
    ADD CONSTRAINT sectionparameters_pkey PRIMARY KEY (isectionid);

ALTER TABLE ONLY ui.sectionparameters
    ADD CONSTRAINT fk68s6ui5ipd13egmjklwfqm9fy FOREIGN KEY (idashboardqueryid) REFERENCES ui.dashboardquery(idashboardqueryid);



CREATE TABLE IF NOT EXISTS ui.taskpanelmasters
(
    taskpanelid integer NOT NULL,
    panelname character varying(255) COLLATE pg_catalog."default",
    sequence integer,
    CONSTRAINT taskpanelmasters_pkey PRIMARY KEY (taskpanelid)
);

CREATE TABLE IF NOT EXISTS ui.sectionmasters
(
    sectionid integer NOT NULL,
    sectionname character varying(255) COLLATE pg_catalog."default",
    taskpanelid integer,
    CONSTRAINT sectionmasters_pkey PRIMARY KEY (sectionid),
    CONSTRAINT fkmta24rx26nh48ybyxyabupghn FOREIGN KEY (taskpanelid)
        REFERENCES ui.taskpanelmasters (taskpanelid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS ui.workflowmasters
(
    workflowid integer NOT NULL,
    workflowname character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT workflowmasters_pkey PRIMARY KEY (workflowid)
);

CREATE TABLE IF NOT EXISTS ui.panelaccessmap
(
    panelaccessmap integer NOT NULL,
    panelid integer,
    groupid integer,
    workflowid integer,
    CONSTRAINT panelaccessmap_pkey PRIMARY KEY (panelaccessmap),
    CONSTRAINT fkcc4n72fa2hkfpd35psi0uy6mt FOREIGN KEY (workflowid)
        REFERENCES ui.workflowmasters (workflowid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkfum718h0gcl0csht2i4gkxok5 FOREIGN KEY (panelid)
        REFERENCES ui.taskpanelmasters (taskpanelid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkoxon1s3rjiaf7qvtajcu75qsg FOREIGN KEY (groupid)
        REFERENCES ui.groupdesc (igroupid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO ui.taskpanelmasters (taskpanelid, panelname, sequence) VALUES (1, 'Summary', 1);
INSERT INTO ui.taskpanelmasters (taskpanelid, panelname, sequence) VALUES (2, 'Transaction', 2);
INSERT INTO ui.taskpanelmasters (taskpanelid, panelname, sequence) VALUES (3, 'History', 3);
INSERT INTO ui.taskpanelmasters (taskpanelid, panelname, sequence) VALUES (4, 'Related Tickets', 4);
INSERT INTO ui.taskpanelmasters (taskpanelid, panelname, sequence) VALUES (5, 'Contacts', 5);

INSERT INTO ui.sectionmasters (sectionid, sectionname, taskpanelid) VALUES (1, 'Risk Score', 1);
INSERT INTO ui.sectionmasters (sectionid, sectionname, taskpanelid) VALUES (2, 'Transaction Summary', 1);
INSERT INTO ui.sectionmasters (sectionid, sectionname, taskpanelid) VALUES (3, 'Failed Rules', 1);
INSERT INTO ui.sectionmasters (sectionid, sectionname, taskpanelid) VALUES (4, 'Dashboards', 1);

INSERT INTO ui.workflowmasters (workflowid, workflowname) VALUES (1, 'Risk Alert');
INSERT INTO ui.workflowmasters (workflowid, workflowname) VALUES (2, 'Decline');
INSERT INTO ui.workflowmasters (workflowid, workflowname) VALUES (3, 'Risk Notification');
INSERT INTO ui.workflowmasters (workflowid, workflowname) VALUES (4, 'AML Cases');

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (1, 1, 1020, 3);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (2, 2, 1020, 3);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (3, 1, 1022, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (4, 2, 1022, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (5, 3, 1022, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (6, 4, 1022, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (7, 5, 1022, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (8, 1, 1023, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (9, 2, 1023, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (10, 3, 1023, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (11, 4, 1023, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (12, 5, 1023, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (13, 1, 1024, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (14, 2, 1024, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (15, 3, 1024, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (16, 4, 1024, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (17, 5, 1024, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (18, 1, 1025, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (19, 2, 1025, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (20, 3, 1025, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (21, 4, 1025, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (22, 5, 1025, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (23, 1, 1026, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (24, 2, 1026, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (25, 1, 1027, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (26, 2, 1027, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (27, 3, 1020, 3);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (28, 4, 1020, 3);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (29, 5, 1020, 3);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (30, 4, 1020, 3);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (31, 1, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (32, 2, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (33, 3, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (34, 4, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (35, 5, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (36, 1, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (37, 2, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (38, 3, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (39, 4, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (40, 5, 1020, 1);




 UPDATE ui.dashboardquery
  	SET vcfilterparametersjson ='{"Party": null, "Address": null}', vcdashboardquery = '{
    "Account":"SELECT X.* FROM   (VALUES (''Days In System'',(with payer as ( SELECT cast(pv.longevity->>''DaysInSystem'' as int)  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where v.vcexternalaccountid = :Address and bside = false order by tdate desc limit 1), payee as (SELECT cast(pv.longevity->>''DaysInSystem'' as int)  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where v.vcexternalaccountid = :Address and bside = true order by tdate desc limit 1), b as (SELECT X.* FROM   (VALUES ((select * from payer), (select * from payee)))AS X (\"payer value\", \"payee value\")) select CASE WHEN  \"payer value\" IS NOT NULL and \"payee value\" IS NOT NULL THEN CASE WHEN \"payer value\" > \"payee value\"  THEN \"payer value\" else \"payee value\" END WHEN \"payer value\" IS NOT NULL THEN \"payer value\" else \"payee value\" END from b))) AS X (\"name\", \"value\");",
    "VPA":"SELECT X.* FROM   (VALUES (''Total Value As Payer'',(with payer as ( SELECT cast(pv.longevity->>''DaysInSystem'' as int)  FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where v.vcexternaladdressid = :Address and bside = false order by tdate desc limit 1), payee as (SELECT cast(pv.longevity->>''DaysInSystem'' as int)  FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where v.vcexternaladdressid = :Address and bside = true order by tdate desc limit 1), b as (SELECT X.* FROM   (VALUES ((select * from payer), (select * from payee)))AS X (\"payer value\", \"payee value\")) select CASE WHEN  \"payer value\" IS NOT NULL and \"payee value\" IS NOT NULL THEN CASE WHEN \"payer value\" > \"payee value\"  THEN \"payer value\" else \"payee value\" END WHEN \"payer value\" IS NOT NULL THEN \"payer value\" else \"payee value\" END from b))) AS X (\"name\", \"value\");"
}' where idashboardqueryid=50;

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (86, 'Party', 'JsonPath', 50, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (87, 'Address', 'String', 50, NULL);