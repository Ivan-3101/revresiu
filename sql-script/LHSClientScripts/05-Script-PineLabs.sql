CREATE SEQUENCE IF NOT EXISTS ui.taskdropdownoptions_ioptionid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.taskdropdownoptions
(
    ioptionid integer NOT NULL DEFAULT nextval('ui.taskdropdownoptions_ioptionid_seq'::regclass),
    vclabel character varying(255) COLLATE pg_catalog."default",
    vcvalue jsonb,
    CONSTRAINT taskdropdownoptions_pkey PRIMARY KEY (ioptionid)
);

CREATE TABLE IF NOT EXISTS ui.tasklhsmap
(
    iorder integer NOT NULL,
    irow integer NOT NULL,
    idropdownoptionid integer NOT NULL,
    iworkflowid integer NOT NULL,
    icolumn integer,
    valueconfig jsonb,
    CONSTRAINT tasklhsmap_pkey PRIMARY KEY (iorder, irow, idropdownoptionid, iworkflowid),
    CONSTRAINT fkburmyi4lho5b7nau7500w2389 FOREIGN KEY (idropdownoptionid)
        REFERENCES ui.taskdropdownoptions (ioptionid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkmp6x0tkra2b7ax7nq9a03h339 FOREIGN KEY (iworkflowid)
        REFERENCES ui.workflowmasters (workflowid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS ui.taskvariables
(
    id integer NOT NULL,
    variables text COLLATE pg_catalog."default",
    CONSTRAINT taskvariables_pkey PRIMARY KEY (id)
);


INSERT INTO ui.taskdropdownoptions (ioptionid, vclabel, vcvalue) VALUES (1, 'Open', NULL);
INSERT INTO ui.taskdropdownoptions (ioptionid, vclabel, vcvalue) VALUES (2, 'My', NULL);
INSERT INTO ui.taskdropdownoptions (ioptionid, vclabel, vcvalue) VALUES (3, 'My Closed', NULL);
INSERT INTO ui.taskdropdownoptions (ioptionid, vclabel, vcvalue) VALUES (4, 'Closed', NULL);

INSERT INTO ui.taskvariables (id, variables) VALUES (1, '["WorkflowName","TicketID","failedRules","TransactionAmount","fieldDropDowns","RiskScore","AvgRiskScore","triggeredtype","payeeAccount","failedRuleIDs", "payeeName"]');