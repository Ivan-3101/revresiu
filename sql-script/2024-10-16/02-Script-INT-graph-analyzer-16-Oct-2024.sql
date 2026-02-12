INSERT INTO ui.rolemenuaccessmap ( irolemenumapid, badd, bapprove, bdelete,bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus,iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid ) VALUES ( ( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true, true, true, true, true ,true, NULL, NULL, true, null, null, 579, 1, 6 ,4 );

INSERT INTO ui.dashboard(
idashboardid, bactive, bdelete, vcdashboardname,
iorder, irowcount, imenustructuredesc, itenantid, bdynamic)
VALUES (59, true , false ,'Master Data', 43, 1, 579, 6, true);

INSERT INTO ui.dashboardquery(
	idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid)
	VALUES (120,true ,'{
    "VpaAddress":null,
    "Party":null,
    "Fields":null
}' ,'SELECT * FROM masters.get_nodewithvcattribs(:Party, ARRAY[:FieldsValue], :VpaAddress)
AS (node VARCHAR(100), :FieldsReturnType)' ,false ,false ,false ,579 ,6 );
INSERT INTO ui.dashboardquery(
	idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid)
	VALUES (119,false ,null ,'SELECT X.* FROM  
(VALUES (''Mobile Number'', ''vcregisteredmobile'', ''vcregisteredmobile VARCHAR(255)'' ), 
 (''Email ID'', ''vcemail'', ''vcemail VARCHAR(255)'')) AS X ("label", "value", "returntype")' ,false ,false ,false ,579 ,6 );
INSERT INTO ui.dashboardquery(
	idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid)
	VALUES (122,false ,null ,'SELECT X.* FROM   (VALUES (''Customer'', ''masters.customers'')) AS X ("label", "value")' ,false ,false ,false ,579 ,6 );

INSERT INTO ui.dashboardresultset(
idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid)
VALUES (219,null,null,'{}','graphanalyzer',120,59,'{}',null, 1, null,null,579,6,4);

INSERT INTO ui.dashboardqueryparameters(
	idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid)
	VALUES (257,'Party' ,'String' ,120 ,1 ,6 );
INSERT INTO ui.dashboardqueryparameters(
	idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid)
	VALUES (258,'VpaAddress' ,'String' ,120 ,2 ,6 );
INSERT INTO ui.dashboardqueryparameters(
	idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid)
	VALUES (256,'Fields' ,'List' ,120 ,0 ,6 );

INSERT INTO ui.dashboardfilters(
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname)
VALUES (163, 1, 'VpaAddress', 59, 'Input', null,null, 6,'Address');
INSERT INTO ui.dashboardfilters(
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname)
VALUES (162, 0 , 'Party', 59, 'Select', null,122, 6,'Level');
INSERT INTO ui.dashboardfilters(
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname)
VALUES (164,3, 'Fields', 59, 'MultiSelect', null,119, 6,'Fields');
