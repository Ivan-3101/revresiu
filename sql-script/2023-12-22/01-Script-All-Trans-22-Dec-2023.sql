--for user unlock
ALTER TABLE IF EXISTS ui.webuseraudit ADD COLUMN loginattempts integer;

--rule clean wrt using ui tables
ALTER TABLE ui.rulesaudit DROP CONSTRAINT fk33xl5td407ox1rxr41qu5i2tu;

ALTER TABLE IF EXISTS ui.rulesavailable
    ADD COLUMN itenantid integer;

ALTER TABLE IF EXISTS ui.rulesavailableaudit
    ADD COLUMN itenantid integer;

ALTER TABLE IF EXISTS ui.rulesavailable
    ADD CONSTRAINT fkqqf3r7a9dxvh6mdl5xqhdxftl FOREIGN KEY (itenantid)
    REFERENCES ui.tenants (itenantid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS ui.rulesavailableaudit
    ADD CONSTRAINT fkf1k1xc79qp1yw9mrjrfmunpm3 FOREIGN KEY (itenantid)
    REFERENCES ui.tenants (itenantid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE ui.transactionclasses DROP CONSTRAINT transactionclasses_pkey CASCADE;
ALTER TABLE ui.transactionclasses ADD CONSTRAINT transactionclasses_pkey PRIMARY KEY (iclassid, itenantid);

ALTER TABLE IF EXISTS ui.rules ADD COLUMN itenantid integer;
ALTER TABLE IF EXISTS ui.rulesaudit ADD COLUMN itenantid integer;

ALTER TABLE ui.rulesaudit DROP CONSTRAINT fk1a2ktsfjkd0qhpvu0hd7qn3at CASCADE;

UPDATE ui.rules rt set itenantid = (select itenantid from ui.decisions where idecisionid=rt.idecisionid);
ALTER TABLE ui.rules DROP CONSTRAINT rules_pkey CASCADE;
ALTER TABLE ui.rules ADD CONSTRAINT rules_pkey PRIMARY KEY (iruleid, idecisionid, itenantid);

UPDATE ui.rulesaudit rt set itenantid = (select itenantid from ui.decisions where idecisionid=rt.idecisionid);

ALTER TABLE ui.observationsuiaudit ADD COLUMN itenantid integer;
ALTER TABLE ui.observationsui ADD COLUMN itenantid integer;

UPDATE ui.observationsui ot set itenantid=(select itenantid from ui.observationwindowsui where ot.wid = wid);

ALTER TABLE ui.observationsui DROP CONSTRAINT observationsui_pkey CASCADE;

ALTER TABLE ui.observationsui ADD CONSTRAINT observationsui_pkey PRIMARY KEY (itenantid, oid, wid);

UPDATE ui.observationsuiaudit ot set itenantid=(select itenantid from ui.observationwindowsui where ot.wid = wid);

ALTER TABLE ui.masterextractattribs DROP CONSTRAINT masterextractattribs_pkey CASCADE;
DELETE from ui.masterextractattribs;
ALTER TABLE ui.masterextractattribs ADD CONSTRAINT masterextractattribs_pkey PRIMARY KEY(itenantid, attribpath, level);






