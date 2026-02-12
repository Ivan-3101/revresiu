ALTER TABLE ui.decisions ALTER COLUMN vcdecisionname type character varying(20);
ALTER TABLE ui.decisions DROP CONSTRAINT decisions_pkey CASCADE;
ALTER TABLE ui.decisions ADD CONSTRAINT decisions_pkey PRIMARY KEY (itenantid, idecisionid);
ALTER TABLE ui.list DROP CONSTRAINT list_pkey CASCADE;
ALTER TABLE ui.list ADD CONSTRAINT list_pkey PRIMARY KEY (itenantid, ilistitemid);
ALTER TABLE ui.observationwindowsui DROP CONSTRAINT observationwindowsui_pkey CASCADE;
ALTER TABLE ui.observationwindowsui ADD CONSTRAINT observationwindowsui_pkey PRIMARY KEY (itenantid, wid);
ALTER TABLE ui.transactionclasses DROP CONSTRAINT transactionclasses_pkey CASCADE;
ALTER TABLE ui.transactionclasses DROP CONSTRAINT uk_j0ucsq6n9pq90o1bulkdyuvr6 CASCADE;
ALTER TABLE ui.transactionclasses ADD CONSTRAINT transactionclasses_pkey PRIMARY KEY (itenantid, vcclassname);
ALTER TABLE IF EXISTS ui.workflowmasters
    ADD COLUMN manualworkflowid integer;
ALTER TABLE IF EXISTS ui.workflowmasters
    ADD CONSTRAINT fk6si7psiy7qnls9rbl5e6a3k9r FOREIGN KEY (manualworkflowid)
    REFERENCES ui.workflowmasters (workflowid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
