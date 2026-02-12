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

INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,1,6,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,1,6,6,'{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,1,6,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,2,1,6,4,'{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,2,6,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,2,2,6,4,'{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,3,6,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,2,3,6,4,'{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,2,1,6,8,'{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,2,2,6,8,'{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,2,3,6,8,'{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,1,12,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,2,1,12,8,'{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,2,1,12,4,'{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,2,12,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,2,2,12,8,'{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,2,2,12,4,'{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,3,12,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,2,3,12,8,'{"tag": "span", "path": "this.name", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,2,3,12,4,'{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,4,12,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,1,4,12,4,'{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,2,6,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,1,12,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,2,6,6,'{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,1,12,12,'{"tag": "h4", "path": "this.variables.payeeAccount", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,2,12,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,1,12,6,'{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,2,12,6,'{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,4,12,6,'{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,1,6,12,'{"tag": "h4", "path": "this.variables.payeeAccount", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,2,6,12,'{"tag": "h4", "path": "this.variables.payeeAccount", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,3,6,12,'{"tag": "h4", "path": "this.variables.payeeAccount", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,3,6,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,2,12,12,'{"tag": "h4", "path": "this.variables.payeeAccount", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,3,12,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,3,12,12,'{"tag": "h4", "path": "this.variables.payeeAccount", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,4,12,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,4,12,8,'{"tag": "h4", "path": "this.variables.payeeAccount", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (2,0,4,6,2,'{"tag": "span", "path": "this.variables.triggeredtype", "type": "default", "className": "d-block text-right"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,1,4,6,8,'{"tag": "h4", "path": "this.variables.payeeName", "type": "default"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (0,0,4,6,4,'{"tag": "span", "path": "this.variables.TicketID", "type": "ticketid"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,4,6,6,'{"tag": "span", "path": "this.created", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,3,6,6,'{"tag": "span", "path": "this.startTime", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,0,3,12,6,'{"tag": "span", "path": "this.startTime", "type": "timestamp"}');
INSERT INTO ui.tasklhsmap(iorder,irow,idropdownoptionid,iworkflowid,icolumn,valueconfig) VALUES (1,1,4,6,4,'{"tag": "span", "path": "this.variables.TransactionAmount", "type": "amount"}');