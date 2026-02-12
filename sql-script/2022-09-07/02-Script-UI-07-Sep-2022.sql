INSERT INTO ui.perspectivequery(
	iperspectivequeryid, vcquery, vctablename)
	VALUES (33, 'SELECT  * from ui.getlivetrans_last_testdb_2(
	:party,
	:userType,
	:timeZone,
	:txnClass,
	:useraddress,
	100
)', 'TestDB2');

INSERT INTO ui.perspectivequeryparameters(
	iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
	VALUES (72, 0, 'party', 'String', 33);

INSERT INTO ui.perspectivequeryparameters(
	iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
	VALUES (73, 1, 'userType', 'Integer', 33);

INSERT INTO ui.perspectivequeryparameters(
	iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
	VALUES (74, 1, 'txnClass', 'Integer', 33);

INSERT INTO ui.perspectivequeryparameters(
	iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
	VALUES (75, 1, 'useraddress', 'Integer', 33);

INSERT INTO ui.menustructuredesc(
	imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus)
	VALUES (543, false, null, null, 5, 'TestDB2', 'TestDB2', null, null, '/user',
			'Test DB 2', 'TD2', '/analytics/test-db-2', null, null, null, null, null, 478, 1);

INSERT INTO ui.rolemenuaccessmap(
	irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid)
	VALUES (655, true, true, true, true, true, true, null, null, true, null, null, 543, 1);


UPDATE ui.menustructuredesc
	SET   vcaction='TestDB1', vccontroller='TestDB1', vcmenuname='Test DB 1', vcmini='TD1', vcpath='/analytics/test-db-1'
	WHERE imenuid=542;
