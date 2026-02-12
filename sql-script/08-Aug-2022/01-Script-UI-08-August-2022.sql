INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (29, 'SELECT * from ui.getpartytxnsummary(
	:party,
	:userType,
	:timeZone,
	:useraddress
)', 'partyDashboardSummary');

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (30, 'SELECT * from  ui.getpartydtxnsummarybyclass(
	:party,
	:userType,
	:timeZone,
	:txnClass,
	:useraddress
)', 'partyDashboardSummaryByClass');


INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (52, 1, 'party', 'String', 29);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (53, 2, 'userType', 'String', 29);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (54, 4, 'useraddress', 'String', 29);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (55, 1, 'party', 'String', 30);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (56, 2, 'userType', 'String', 30);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (57, 4, 'txnClass', 'String', 30);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (58, 5, 'useraddress', 'String', 30);


UPDATE ui.dashboardfilters SET ifilterorder=0 WHERE idashboardfilterid=1;
UPDATE ui.dashboardfilters SET ifilterorder=1 WHERE idashboardfilterid=18;
UPDATE ui.dashboardfilters SET ifilterorder=2 WHERE idashboardfilterid=14;
UPDATE ui.dashboardfilters SET ifilterorder=3 WHERE idashboardfilterid=13;

