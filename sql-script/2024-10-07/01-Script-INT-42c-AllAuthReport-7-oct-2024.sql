
INSERT INTO ui.dashboardresultset(
	idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid)
	VALUES (221,null ,null ,'{
    "sizes": [
        1
    ],
    "detail": {
        "main": {
            "type": "tab-area",
            "widgets": [
                "PERSPECTIVE_GENERATED_ID_1"
            ],
            "currentIndex": 0
        }
    },
    "mode": "globalFilters",
    "viewers": {
        "PERSPECTIVE_GENERATED_ID_1": {
            "plugin": "Datagrid",
            "plugin_config": {
                "columns": {},
                "editable": false,
                "scroll_lock": true
            },
            "settings": false,
            "theme": "Pro Dark",
            "title": "All Auth Report",
            "group_by": [],
            "split_by": [],
            "columns": [],
            "filter": [],
            "sort": [],
            "expressions": [],
            "aggregates": {},
            "master": false,
            "table": "allauthreport",
            "linked": false
        }
    }
}' ,'allauthreport' ,123 ,61 ,'{
                                                                       	"Class (CUB or USFB)": "string",
                                                                       	"Account ID":"integer",
                                                                       	"Document Number":"string",
                                                                       	"Last 4 digits of card":"integer",
                                                                       	"Customer Name":"string",
                                                                       	"Transaction Amount": "float",
                                                                       	"Authorization Date":"date",
                                                                       	"Authorization Timestamp":"datetime",
                                                                       	"FRM Score":"integer",
                                                                       	"Netwrok Score":"integer",
                                                                       	"Authorization Response Code": "integer",
                                                                       	"Approved/Declined":"string",
                                                                       	"POS Entry Mode":"string",
                                                                       	"Merchant Category Code (MCC)":"integer",
                                                                       	"Merchant Name":"string",
                                                                       	"Merchant Location":"string",
                                                                       	"Card Acceptor Country Code":"string",
                                                                       	"Acquirer Country Code"	:"integer",
                                                                       	"MOTO/ECI/Recurring":"string",
                                                                       	"Issuer Currency Code":"string",
                                                                           "Retrieval Reference Number":"string",
                                                                           "Transaction ID":"string",
                                                                           "Terminal Capability":"integer",
                                                                           "Transaction Type":"integer",
                                                                           "Cardholder ID Method":"integer",
                                                                           "PIN Entry Capability Code":"integer",
                                                                           "Terminal Capability Profile":"string",
                                                                           "Terminal Type":"integer",
                                                                           "Terminal Verification Results":"string",
                                                                           "Statused By User ID (42 CS Agent)":"string",
                                                                           "Agent Name (42 CS Agent)":"string",
                                                                           "Alert closed date and time (42 CS Agent)":"datetime",
                                                                           "Rule type":"string",
                                                                           "Rule Name":"string"
                                                                       }' ,null ,1 ,null ,null ,510 ,20 ,null );

