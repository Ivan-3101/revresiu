
-----------------------------------------------------------------ui.dashboard ------------------------------------------------------------------------------------------------
INSERT INTO ui.dashboard(idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) 
SELECT 63, true, false, 'List', 15, 1, 499, t.itenantid, TRUE FROM ui.tenants t WHERE itenantid !=0;

---------------------------------
INSERT INTO ui.dashboardquery(idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) 
SELECT 128,FALSE,NULL,'SELECT ilistmasterid as "value",  vcname as "label"
	FROM ui.listmaster
	where itenantid = :tenantid',NULL,NULL,NULL,NULL, t.itenantid FROM ui.tenants t WHERE itenantid != 0 ;

------------------------
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) SELECT 
129, true, '{"listtype":null,"DateRange":null}', 'SELECT 
vcexternallistitemid, vcfield, vcvalue,ilisttype,dteffectivefrom, dtexpiresat, dtentrydatetime,vcsource,cast (attribs as text) 
FROM ui.list
WHERE itenantid = :tenantid and istatus =1  and 
 ilisttype = :listtype and ( dteffectivefrom between :StartDate and  :EndDate  or dtexpiresat between :StartDate and  :EndDate or dtentrydatetime between :StartDate and  :EndDate)', 
 false, false, false, 499,  t.itenantid FROM ui.tenants t WHERE itenantid != 0 ;
 
 


---dashboardqueryparameter 
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid) 
SELECT 264, 'DateRange', 'DateRange', 129,  t.itenantid FROM ui.tenants t WHERE itenantid != 0 ;

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid) 
SELECT 265, 'listtype', 'Integer', 129,  t.itenantid FROM ui.tenants t WHERE itenantid != 0 ;



-------------------dasboard filter 
INSERT INTO ui.dashboardfilters(idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname)
 SELECT 169,1,'DateRange',63,'DateRangePicker',23,NULL,t.itenantid, 'Date Range' FROM ui.tenants t WHERE itenantid !=0 ;

INSERT INTO ui.dashboardfilters(idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname)
 SELECT 170,0,'listtype',63,'Select',NULL,128,t.itenantid, 'List Type' FROM ui.tenants t WHERE itenantid !=0 ;

----------------dashboardresultset

INSERT INTO ui.dashboardresultset(idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid) 
SELECT 223,NULL,NULL,'{
  "sizes": [1],
  "detail": { "main": { "type": "tab-area", "widgets": ["PERSPECTIVE_GENERATED_ID_1"], "currentIndex": 0 } },
  "mode": "globalFilters",
  "viewers": {
    "PERSPECTIVE_GENERATED_ID_1": {
      "plugin": "Datagrid",
      "plugin_config": { "columns": {}, "editable": false, "scroll_lock": false },
      "settings": false,
      "theme": "Pro Dark",
      "title": "List",
      "group_by": [],
      "split_by": [],
      "columns": [
        "vcexternallistitemid",
        "vcfield",
        "vcvalue",
        "ilisttype",
        "dteffectivefrom",
        "dtexpiresat",
        "dtentrydatetime",
        "vcsource",
        "attribs"
      ],
      "filter": [],
      "sort": [],
      "expressions": [],
      "aggregates": {},
      "master": false,
      "table": "list",
      "linked": false
    }
  }
}','list',129,63,'{
    "vcexternallistitemid":"string" 
    , 
    "vcfield":"string"
    ,
    "vcvalue":"string"
    ,
    "ilisttype":"integer"
    ,
    "dteffectivefrom":"datetime"
    ,
    "dtexpiresat":"datetime"
    ,
    "dtentrydatetime":"datetime"
    ,
    "vcsource":"string"
    ,
    "attribs":"string"


}',NULL,1,NULL,NULL,499,t.itenantid,iorgid FROM ui.tenants t WHERE itenantid !=0 ;









