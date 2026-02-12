
INSERT INTO ui.perspectivequery(
	iperspectivequeryid, vcquery, vctablename)
	VALUES (31, 'SELECT  * from ui.getlivetrans_last_testdb(
:className,
	:score,
	:timeZone,
	100
)', 'TestDB');

INSERT INTO ui.perspectivequeryparameters(
	iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
	VALUES (67, 0, 'className', 'String', 31);
INSERT INTO ui.perspectivequeryparameters(
	iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)
	VALUES (68, 1, 'score', 'Integer', 31);

INSERT INTO ui.menustructuredesc(
	imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus)
	VALUES (542, false, null, null, 4, 'TestDB', 'TestDB', null, null, '/user',
			'Test DB', 'TD', '/analytics/test-db', null, null, null, null, null, 478, 1);

INSERT INTO ui.rolemenuaccessmap(
	irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid)
	VALUES (654, true, true, true, true, true, true, null, null, true, null, null, 542, 1);