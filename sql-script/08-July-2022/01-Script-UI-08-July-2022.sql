INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (25, false, NULL, 'SELECT X.* FROM   (VALUES (''Payer'', ''Payer''),(''Payee'', ''Payee''), (''Both'', ''Both'')) AS X ("label", "value");');

UPDATE ui.dashboardquery SET vcfilterparametersjson='{"DateRange" : null, "VpaAddress":null, "Type":null}', vcdashboardquery='Select * from masters.getlivedata(:Type, :StartDate, :EndDate, :VpaAddress);' WHERE idashboardqueryid=7;
UPDATE ui.dashboardquery SET vcfilterparametersjson='{"Date" : null , "VpaAddress" : null}', vcdashboardquery='select * from profiles.sp_getdatavpa_c(true,:Date,:VpaAddress);' WHERE idashboardqueryid=8;
UPDATE ui.dashboardquery SET vcfilterparametersjson='{"Date" : null , "VpaAddress" : null}', vcdashboardquery='select * from profiles.sp_getdatavpa_c(false,:Date,:VpaAddress);' WHERE idashboardqueryid=9;


ALTER TABLE ui.dashboardfilters ADD vcdashboardfilterdisplayname varchar(255);

UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date Range' WHERE idashboardfilterid=1;
UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date' WHERE idashboardfilterid=3;
UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date' WHERE idashboardfilterid=4;
UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date' WHERE idashboardfilterid=5;
UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date' WHERE idashboardfilterid=6;
UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date' WHERE idashboardfilterid=7;
UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date Range' WHERE idashboardfilterid=8;
UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date Range' WHERE idashboardfilterid=10;
UPDATE ui.dashboardfilters SET  vcdashboardfilterdisplayname='Date Range' WHERE idashboardfilterid=12;
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (13, 'VpaAddress', 1, 2, 'Input', NULL, NULL, 'Address/Account No.');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (14, 'Type', 1, 1, 'Select', NULL, 25, 'Type');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (15, 'VpaAddress', 2, 1, 'Input', NULL, NULL, 'Address/Account No.');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (16, 'VpaAddress', 3, 1, 'Input', NULL, NULL, 'Address/Account No.');



INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (18, 'VpaAddress', 'String', 7);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (19, 'Type', 'String', 7);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (20, 'VpaAddress', 'String', 8);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (21, 'VpaAddress', 'String', 9);