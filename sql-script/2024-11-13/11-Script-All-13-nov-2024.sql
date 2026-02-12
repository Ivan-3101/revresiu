--1. Classes

--masters.transactionclasses

CREATE UNIQUE INDEX unique_vcclassname_itenantid
ON masters.transactionclasses (vcclassname, itenantid)
WHERE irecordstatus = 0;

--ui.transactionclasses

CREATE UNIQUE INDEX unique_vcclassname_itenantid
ON ui.transactionclasses (vcclassname, itenantid)
WHERE irecordstatus = 0;

ALTER TABLE IF EXISTS ui.transactionclasses
    ALTER COLUMN bpayeemandatory SET NOT NULL;

ALTER TABLE IF EXISTS ui.transactionclasses
    ALTER COLUMN bpayermandatory SET NOT NULL;

ALTER TABLE IF EXISTS ui.transactionclasses
    ALTER COLUMN iproductid SET NOT NULL;

--ui.transactionclassesaudit

ALTER TABLE IF EXISTS ui.transactionclassesaudit
    ALTER COLUMN bpayeemandatory SET NOT NULL;

ALTER TABLE IF EXISTS ui.transactionclassesaudit
    ALTER COLUMN bpayermandatory SET NOT NULL;

ALTER TABLE IF EXISTS ui.transactionclassesaudit
    ALTER COLUMN iproductid SET NOT NULL;

--2. Decisions

--ui.decisionsworkflowaudit

ALTER TABLE IF EXISTS ui.decisionsworkflowaudit
    ALTER COLUMN vcdecisionname SET NOT NULL;

ALTER TABLE IF EXISTS ui.decisionsworkflowaudit
    ALTER COLUMN iproductid SET NOT NULL;

--master.decisions

ALTER TABLE IF EXISTS masters.decisions
    ALTER COLUMN iproductid SET NOT NULL;

ALTER TABLE IF EXISTS masters.decisions
    ALTER COLUMN vcdecisionname SET NOT NULL;

--3. Rules

--ui.rules

ALTER TABLE IF EXISTS ui.rules
    ALTER COLUMN vcrulename SET NOT NULL;

--masters.rules

ALTER TABLE IF EXISTS masters.rules
    ALTER COLUMN vcrulename SET NOT NULL;

--4. Lists

--ui.listmaster

ALTER TABLE IF EXISTS ui.listmaster
    ALTER COLUMN vcname SET NOT NULL;

--5. Windows

--masters.observationwindowsui

CREATE UNIQUE INDEX unique_wname_itenantid
ON masters.observationwindows (wname, itenantid)
WHERE irecordstatus = 0;

--ui.observationwindowsui

CREATE UNIQUE INDEX unique_wname_itenantid
ON ui.observationwindowsui (wname, itenantid)
WHERE irecordstatus = 0;

ALTER TABLE IF EXISTS ui.observationwindowsui
    ALTER COLUMN groupbyexpr SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsui
    ALTER COLUMN selectexpr SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsui
    ALTER COLUMN wduration SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsui
    ALTER COLUMN wname SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsui
    ALTER COLUMN whereexpr SET NOT NULL;

--ui.observationwindowsuiaudit

ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ALTER COLUMN groupbyexpr SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ALTER COLUMN selectexpr SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ALTER COLUMN wduration SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ALTER COLUMN wname SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ALTER COLUMN whereexpr SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ALTER COLUMN wid SET NOT NULL;

--6. Observations

--masters.observations

CREATE UNIQUE INDEX unique_oname_itenantid
ON masters.observations (oname, itenantid)
WHERE irecordstatus = 0;

--ui.observationsui

CREATE UNIQUE INDEX unique_oname_itenantid
ON ui.observationsui (oname, itenantid)
WHERE irecordstatus = 0;

ALTER TABLE IF EXISTS ui.observationsui
    ALTER COLUMN aggregationtype SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationsui
    ALTER COLUMN oduration SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationsui
    ALTER COLUMN oname SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationsui
    ALTER COLUMN wexpr SET NOT NULL;

--ui.observationsuiaudit

ALTER TABLE IF EXISTS ui.observationsuiaudit
    ALTER COLUMN aggregationtype SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationsuiaudit
    ALTER COLUMN oduration SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationsuiaudit
    ALTER COLUMN oname SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationsuiaudit
    ALTER COLUMN wexpr SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationsuiaudit
    ALTER COLUMN oid SET NOT NULL;

ALTER TABLE IF EXISTS ui.observationsuiaudit
    ALTER COLUMN wid SET NOT NULL;
