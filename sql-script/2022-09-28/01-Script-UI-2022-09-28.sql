CREATE SEQUENCE IF NOT EXISTS ui.observationsui_oid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS ui.observationsuiaudit_oauditid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS ui.observationwindowsui_wid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS ui.observationwindowsuiaudit_wauitid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.observationwindowsui
(
    wid integer NOT NULL DEFAULT nextval('ui.observationwindowsui_wid_seq'::regclass),
    dtapproverstamp timestamp without time zone,
    dtentrystamp timestamp without time zone,
    dtentrydatetime timestamp without time zone,
    groupbyexpr jsonb,
    irecordstatus integer,
    laststatus character varying(255) COLLATE pg_catalog."default",
    latestremark character varying(255) COLLATE pg_catalog."default",
    selectexpr jsonb,
    wcount integer,
    wduration character varying(255) COLLATE pg_catalog."default",
    wname character varying(255) COLLATE pg_catalog."default",
    whereexpr jsonb,
    iapproveruserid integer,
    ientryuserid integer,
    istatus integer,
    CONSTRAINT observationwindowsui_pkey PRIMARY KEY (wid),
    CONSTRAINT fk6awbc9f7i4popolcowfb1o5g3 FOREIGN KEY (ientryuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkdi8tuuy5hp48ogjqoofqeykgb FOREIGN KEY (istatus)
        REFERENCES ui.statuscode (istatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkdm0kttq2fkb9fxgjkrs8w5upq FOREIGN KEY (iapproveruserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS ui.observationwindowsuiaudit
(
    wauitid integer NOT NULL DEFAULT nextval('ui.observationwindowsuiaudit_wauitid_seq'::regclass),
    bclosed boolean NOT NULL,
    dtapproverstamp timestamp without time zone,
    dtentrystamp timestamp without time zone,
    vcaction character varying(3) COLLATE pg_catalog."default" NOT NULL,
    vcremark character varying(255) COLLATE pg_catalog."default",
    dtentrydatetime timestamp without time zone,
    groupbyexpr jsonb,
    irecordstatus integer,
    selectexpr jsonb,
    wcount integer,
    wduration character varying(255) COLLATE pg_catalog."default",
    wname character varying(255) COLLATE pg_catalog."default",
    whereexpr jsonb,
    iapproveruserid integer,
    ientryuserid integer,
    istatus integer,
    wid integer,
    CONSTRAINT observationwindowsuiaudit_pkey PRIMARY KEY (wauitid),
    CONSTRAINT fkayjdn104jkfvmr1unakg5t81 FOREIGN KEY (wid)
        REFERENCES ui.observationwindowsui (wid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkedv70i1biq936g6p0uclq0di8 FOREIGN KEY (istatus)
        REFERENCES ui.statuscode (istatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkg904fibfoel2vyd4mceqgbhlc FOREIGN KEY (ientryuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fktfqvknxws0j3odve80upj78xi FOREIGN KEY (iapproveruserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE IF NOT EXISTS ui.observationsui
(
    oid integer NOT NULL DEFAULT nextval('ui.observationsui_oid_seq'::regclass),
    dtapproverstamp timestamp without time zone,
    dtentrystamp timestamp without time zone,
    aggregationtype character varying(255) COLLATE pg_catalog."default",
    dtentrydatetime timestamp without time zone,
    irecordstatus integer,
    laststatus character varying(255) COLLATE pg_catalog."default",
    latestremark character varying(255) COLLATE pg_catalog."default",
    ocount integer,
    oduration character varying(255) COLLATE pg_catalog."default",
    oname character varying(255) COLLATE pg_catalog."default",
    wexpr jsonb,
    whereexpr jsonb,
    iapproveruserid integer,
    ientryuserid integer,
    istatus integer,
    wid integer,
    CONSTRAINT observationsui_pkey PRIMARY KEY (oid),
    CONSTRAINT fk4vghsx5gurs4eo2a1lckjpthn FOREIGN KEY (iapproveruserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkchq3o7ehlbxfg0j4y3i6kko2f FOREIGN KEY (wid)
        REFERENCES ui.observationwindowsui (wid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkdkk8nun2cy8q72w01scu80wo5 FOREIGN KEY (ientryuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fksnyjiqo8eldviuaktphwlbc24 FOREIGN KEY (istatus)
        REFERENCES ui.statuscode (istatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS ui.observationsuiaudit
(
    oauditid integer NOT NULL DEFAULT nextval('ui.observationsuiaudit_oauditid_seq'::regclass),
    bclosed boolean NOT NULL,
    dtapproverstamp timestamp without time zone,
    dtentrystamp timestamp without time zone,
    vcaction character varying(3) COLLATE pg_catalog."default" NOT NULL,
    vcremark character varying(255) COLLATE pg_catalog."default",
    aggregationtype character varying(255) COLLATE pg_catalog."default",
    dtentrydatetime timestamp without time zone,
    irecordstatus integer,
    ocount integer,
    oduration character varying(255) COLLATE pg_catalog."default",
    oname character varying(255) COLLATE pg_catalog."default",
    wexpr jsonb,
    whereexpr jsonb,
    iapproveruserid integer,
    ientryuserid integer,
    istatus integer,
    oid integer,
    wid integer,
    CONSTRAINT observationsuiaudit_pkey PRIMARY KEY (oauditid),
    CONSTRAINT fk7laijid78wvvfng8aiiy5flbh FOREIGN KEY (iapproveruserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkaajo6weivem6kbtuwg14t53uk FOREIGN KEY (istatus)
        REFERENCES ui.statuscode (istatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkhc426rtor17b3ytsmm9tmbl1x FOREIGN KEY (ientryuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fklwh2wc5pk1kxd9gp8oni00ny4 FOREIGN KEY (wid)
        REFERENCES ui.observationwindowsui (wid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkqoifj7hc6xs214fftegx0tjat FOREIGN KEY (oid)
        REFERENCES ui.observationsui (oid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);



INSERT INTO ui.observationwindowsui(
	wid, dtapproverstamp, dtentrystamp, dtentrydatetime, groupbyexpr, irecordstatus, selectexpr, wcount, wduration, wname, whereexpr)
	SELECT wid,dtentrydatetime,dtentrydatetime,dtentrydatetime, groupbyexpr,irecordstatus,selectexpr,wcount,wduration, wname,whereexpr  
	FROM masters.observationwindows;

INSERT INTO ui.observationsui(
	oid, dtapproverstamp, dtentrystamp, aggregationtype, dtentrydatetime, irecordstatus,  ocount, oduration, oname, wexpr, whereexpr, wid)
	SELECT oid,dtentrydatetime,dtentrydatetime,aggregationtype,dtentrydatetime,irecordstatus,ocount,  oduration, oname, wexpr, whereexpr,wid FROM masters.observations;

UPDATE ui.observationsui SET  laststatus='Approved', latestremark='Approved',  istatus=1;

UPDATE ui.observationwindowsui SET  laststatus='Approved', latestremark='Approved',  istatus=1;


INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (547, false, NULL, NULL, 5, 'Window Management', 'WindowManagement', NULL, NULL, '/user', 'Window Management', 'WM', '/masters/window-management/list', NULL, NULL, NULL, NULL, NULL, 481, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (548, false, NULL, NULL, 1, 'Add Window', 'Add Window', NULL, NULL, '/user', 'Add Window', 'AW', '/masters/window-management/add-window', NULL, NULL, NULL, NULL, NULL, 547, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (549, false, NULL, NULL, 2, 'Edit Window', 'EditWindow', NULL, NULL, '/user', 'Edit Window', 'EW', '/masters/window-management/edit-window', NULL, NULL, NULL, NULL, NULL, 547, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (550, false, NULL, NULL, 3, 'Delete Window', 'DeleteWindow', NULL, NULL, '/user', 'Delete Window', 'DW', '/masters/window-management/delete-window', NULL, NULL, NULL, NULL, NULL, 547, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (551, false, NULL, NULL, 4, 'Approve Add Window', 'ApproveAddWindow', NULL, NULL, '/user', 'Approve Add Window', 'AAW', '/masters/window-management/approve-add-window', NULL, NULL, NULL, NULL, NULL, 547, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (552, false, NULL, NULL, 5, 'Approve Delete Window', 'Approve Delete Window', NULL, NULL, '/user', 'Approve Delete Window', 'ADW', '/masters/window-management/approve-delete-window', NULL, NULL, NULL, NULL, NULL, 547, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (553, false, NULL, NULL, 6, 'View Window', 'View Window', NULL, NULL, '/user', 'View Window', 'VW', '/masters/window-management/view-window', NULL, NULL, NULL, NULL, NULL, 547, 1);

INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (554, false, NULL, NULL, 5, 'Observation Management', 'WindowObservation', NULL, NULL, '/user', 'Observation Management', 'WO', '/masters/observation-management/list', NULL, NULL, NULL, NULL, NULL, 481, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (555, false, NULL, NULL, 1, 'Add Observation', 'Add Observation', NULL, NULL, '/user', 'Add Observation', 'AO', '/masters/observation-management/add-observation', NULL, NULL, NULL, NULL, NULL, 554, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (556, false, NULL, NULL, 2, 'Edit Observation', 'EditObservation', NULL, NULL, '/user', 'Edit Observation', 'EO', '/masters/observation-management/edit-observation', NULL, NULL, NULL, NULL, NULL, 554, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (557, false, NULL, NULL, 3, 'Delete Observation', 'DeleteObservation', NULL, NULL, '/user', 'Delete Observation', 'DO', '/masters/observation-management/delete-observation', NULL, NULL, NULL, NULL, NULL, 554, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (558, false, NULL, NULL, 4, 'Approve Add Observation', 'ApproveAddObservation', NULL, NULL, '/user', 'Approve Add Observation', 'AAO', '/masters/observation-management/approve-add-observation', NULL, NULL, NULL, NULL, NULL, 554, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (559, false, NULL, NULL, 5, 'Approve Delete Observation', 'Approve Delete Observation', NULL, NULL, '/user', 'Approve Delete Observation', 'ADO', '/masters/observation-management/approve-delete-observation', NULL, NULL, NULL, NULL, NULL, 554, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (560, false, NULL, NULL, 6, 'View Observation', 'View Observation', NULL, NULL, '/user', 'View Observation', 'VO', '/masters/observation-management/view-observation', NULL, NULL, NULL, NULL, NULL, 554, 1);

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (660, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 547, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (661, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 548, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (662, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 549, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (663, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 550, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (664, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 551, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (665, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 552, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (666, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 553, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (667, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 554, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (668, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 555, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (669, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 556, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (670, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 557, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (671, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 558, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (672, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 559, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (673, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 560, 1);

UPDATE ui.menustructuredesc	SET  isortorder=0 WHERE vcmenuname='Class Management';
UPDATE ui.menustructuredesc	SET  isortorder=1 WHERE vcmenuname='Decision Level Management';
UPDATE ui.menustructuredesc	SET  isortorder=2 WHERE vcmenuname='Rule Management';	
UPDATE ui.menustructuredesc	SET  isortorder=3 WHERE vcmenuname='Observation Management';
UPDATE ui.menustructuredesc	SET  isortorder=4 WHERE vcmenuname='Window Management';


SELECT setval('ui."observationsui_oid_seq"', (SELECT MAX(oid) FROM masters.observations));

SELECT setval('ui."observationwindowsui_wid_seq"', (SELECT MAX(wid) FROM masters.observationwindows));

