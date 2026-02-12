ALTER table ui.workflowmasters ADD COLUMN manual_display_name character varying(255);
ALTER table ui.workflowmasters ADD COLUMN is_manual_creation boolean;
ALTER table ui.workflowmasters ADD COLUMN is_filter_display boolean;
ALTER TABLE IF EXISTS ui.workflowmasters ADD COLUMN manual_attribs jsonb;

ALTER TABLE IF EXISTS ui.workflowmasters ADD COLUMN idecisionid integer;
ALTER TABLE IF EXISTS ui.workflowmasters add constraint FKd04j36juybw9x1rwwn7xkvb1t foreign key (idecisionid) references ui.decisions;

INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'578'::integer, false::boolean, '2'::integer, 'CreateManualTicket'::character varying, 'CreateManualTicket'::character varying, '/user'::character varying, 'Create Manual Ticket'::character varying, 'CT'::character varying, '/case-management/manual-ticket-creation'::character varying, '479'::integer, '1'::integer)
 returning imenuid;

UPDATE ui.menustructuredesc SET
isortorder = '7'::integer WHERE
imenuid = 572;

UPDATE ui.menustructuredesc SET
isortorder = '6'::integer WHERE
imenuid = 536;

UPDATE ui.menustructuredesc SET
isortorder = '5'::integer WHERE
imenuid = 506;

UPDATE ui.menustructuredesc SET
isortorder = '4'::integer WHERE
imenuid = 505;

UPDATE ui.menustructuredesc SET
isortorder = '3'::integer WHERE
imenuid = 503;