Alter Table ui.transactionclasses Add Column dtapproverstamp timestamp without time zone;
Alter Table ui.transactionclasses Add Column dtentrystamp timestamp without time zone;
Alter Table ui.transactionclasses Add Column iapproveruserid integer,Add Constraint fkc1qahv5nl41ewrnnj5mey7efx Foreign Key (iapproveruserid) REFERENCES ui.webuser (iuserid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
Alter Table ui.transactionclasses Add Column ientryuserid integer,Add Constraint fkt8s16le35wsd2w11kno2ovt0j Foreign Key (ientryuserid) REFERENCES ui.webuser (iuserid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
Alter Table ui.transactionclasses Add Column istatus integer,Add Constraint fk9c1uqffstrhgvks6qnugth5gn Foreign Key (istatus) REFERENCES ui.statuscode (istatusid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
Alter Table ui.transactionclasses Add Column laststatus character varying(255);
Alter Table ui.transactionclasses Add Column latestremark character varying(255);
Alter Table ui.transactionclasses Drop Column idecisionid;
Alter Table ui.transactionclasses Add Column idecisionid Integer,Add Constraint fkrtkc135cykqygpw5c0jvijpej Foreign key(idecisionid) REFERENCES ui.decisions (idecisionid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;


DELETE FROM ui.rulestempaudit;
DELETE FROM ui.transactionclasses;
DELETE FROM ui.decisionsaudit;
DELETE FROM ui.decisions;

INSERT INTO ui.decisions(
	idecisionid, dtentrydatetime, irecordstatus, vcdecisiondetail, vcdecisionmapinfo, vcdecisionname, vcresultparams, iproductid, iuserid,bactive)
	Select idecisionid, dtentrydatetime, irecordstatus, vcdecisiondetail, vcdecisionmapinfo, vcdecisionname, vcresultparams, iproductid, iuserid,bactive from masters.decisions order by idecisionid asc;
	
INSERT INTO ui.transactionclasses(
	iclassid, vcclassname, iproductid, ichannelid, idecisionid, bpayermandatory, bpayeemandatory, bactive, irecordstatus, dtentrydatetime, vcdecisionparams)
	Select iclassid, vcclassname, iproductid, ichannelid, idecisionid, bpayermandatory, bpayeemandatory, bactive, irecordstatus, dtentrydatetime, vcdecisionparams
 from masters.transactionclasses order by iclassid asc;
 
Alter Sequence ui.transactionclasses_iclassid_seq Restart with 26;
Alter Sequence ui.decisions_seq Restart with 19;

UPDATE ui.decisions SET  dtapproverstamp=current_timestamp,  istatus=1, laststatus='Approved', latestremark='All Correct';

UPDATE ui.transactionclasses SET  dtapproverstamp=current_timestamp,  istatus=1, laststatus='Approved', latestremark='All Correct';


CREATE SEQUENCE IF NOT EXISTS ui.transactionclassesaudit_iclassauditid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.transactionclassesaudit
(
    iclassauditid integer NOT NULL DEFAULT nextval('ui.transactionclassesaudit_iclassauditid_seq'::regclass),
    bclosed boolean NOT NULL,
    dtapproverstamp timestamp without time zone,
    dtentrystamp timestamp without time zone,
    vcaction character varying(3) COLLATE pg_catalog."default" NOT NULL,
    vcremark character varying(255) COLLATE pg_catalog."default",
    bactive boolean,
    bpayeemandatory boolean,
    bpayermandatory boolean,
    dtentrydatetime timestamp without time zone,
    ichannelid integer NOT NULL,
    irecordstatus integer,
    vcclassname character varying(255) COLLATE pg_catalog."default" NOT NULL,
    vcdecisionparams jsonb,
    iapproveruserid integer,
    ientryuserid integer,
    istatus integer,
    iclassid integer,
    idecisionid integer NOT NULL,
    iproductid integer,
    CONSTRAINT transactionclassesaudit_pkey PRIMARY KEY (iclassauditid),
    CONSTRAINT fk3nkvnkwmyq4ppaifiuivskmeh FOREIGN KEY (iclassid)
        REFERENCES ui.transactionclasses (iclassid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkha6gpnsa6mikf9tmyec63uabx FOREIGN KEY (iapproveruserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkj5hm2i7b2cn8w2iitvr2pi4ga FOREIGN KEY (idecisionid)
        REFERENCES ui.decisions (idecisionid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkkdia40jhbsl70an95irpc1ds3 FOREIGN KEY (ientryuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fklgf81ntkmc50wmdaplyut905y FOREIGN KEY (istatus)
        REFERENCES ui.statuscode (istatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkpekr3hpafq4g7bg0wo89hge6l FOREIGN KEY (iproductid)
        REFERENCES masters.products (iproductid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE SEQUENCE IF NOT EXISTS ui.decisionsworkflowaudit_idecisionauditid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.decisionsworkflowaudit
(
    idecisionauditid integer NOT NULL DEFAULT nextval('ui.decisionsworkflowaudit_idecisionauditid_seq'::regclass),
    bclosed boolean NOT NULL,
    dtapproverstamp timestamp without time zone,
    dtentrystamp timestamp without time zone,
    vcaction character varying(3) COLLATE pg_catalog."default" NOT NULL,
    vcremark character varying(255) COLLATE pg_catalog."default",
    bactive boolean,
    dtentrydatetime timestamp without time zone,
    irecordstatus integer,
    vcdecisiondetail character varying(255) COLLATE pg_catalog."default",
    vcdecisionmapinfo character varying(255) COLLATE pg_catalog."default",
    vcdecisionname character varying(255) COLLATE pg_catalog."default",
    vcresultparams jsonb,
    iapproveruserid integer,
    ientryuserid integer,
    istatus integer,
    idecisionid integer,
    iproductid integer,
    iuserid integer,
    CONSTRAINT decisionsworkflowaudit_pkey PRIMARY KEY (idecisionauditid),
    CONSTRAINT fk6pftl8lrdsdffs8cwei7lctdg FOREIGN KEY (iuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk7oe8xxbx8kf6d85egg1qw3cj0 FOREIGN KEY (ientryuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkcg5lvxpp6dxxjeb8xxggokgml FOREIGN KEY (idecisionid)
        REFERENCES ui.decisions (idecisionid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkfbfcyt1vi84mvn3rl1v7nck39 FOREIGN KEY (istatus)
        REFERENCES ui.statuscode (istatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkglbat5dws4lqve9fo1s8omexh FOREIGN KEY (iapproveruserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkol5mra5hhmljp9xgn7lpiod5b FOREIGN KEY (iproductid)
        REFERENCES masters.products (iproductid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

UPDATE ui.decisions SET vcresultparams=null;
UPDATE ui.transactionclasses SET vcdecisionparams=null;

UPDATE ui.menustructuredesc SET vcmenuname='Class Management',vccontroller='ClassManagement',vcaction='ClassManagement',vcpath='/masters/class-management',vcmini='CM' WHERE imenuid=521;
UPDATE ui.menustructuredesc SET vcmenuname='Decision Level Management',vccontroller='DecisionLevelManagement',vcaction='DecisionLevelManagement',vcpath='/masters/decision-level-management',vcmini='DLM' WHERE imenuid=522;

INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (531, false, NULL, NULL, 1, 'Add Transaction Class', 'AddTransactionClass', NULL, NULL, '/user', 'Add Transaction Class', 'ATC', '/masters/class-to-decision-configurator/add-class', NULL, NULL, NULL, NULL, NULL, 521, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (532, false, NULL, NULL, 2, 'Edit Transaction Class', 'EditTransactionClass', NULL, NULL, '/user', 'Edit Transaction Class', 'ETC', '/masters/class-to-decision-configurator/edit-class', NULL, NULL, NULL, NULL, NULL, 521, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (533, false, NULL, NULL, 3, 'Approve Transaction Class', 'ApproveTransactionClass', NULL, NULL, '/user', 'Approve Transaction Class', 'ATC', '/masters/class-to-decision-configurator/approve-class', NULL, NULL, NULL, NULL, NULL, 521, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (534, false, NULL, NULL, 1, 'Edit Decision', 'EditDecision', NULL, NULL, '/user', 'Edit Decision', 'ED', '/masters/decision-levels-and-workflow/edit-decision', NULL, NULL, NULL, NULL, NULL, 522, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (535, false, NULL, NULL, 2, 'Approve Decision', 'ApproveDecision', NULL, NULL, '/user', 'Approve Decision', 'AD', '/masters/decision-levels-and-workflow/approve-decision', NULL, NULL, NULL, NULL, NULL, 522, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (536, false, NULL, NULL, 5, 'Reports', 'Reports', NULL, NULL, '/user', 'Reports', 'R', '/case-management/reports', NULL, NULL, NULL, NULL, NULL, 479, 1);


INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (640, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 531, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (641, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 532, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (642, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 533, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (643, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 534, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (644, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 535, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (645, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, (select imenuid from ui.menustructuredesc where vcmenuname='Reports'), 1);
