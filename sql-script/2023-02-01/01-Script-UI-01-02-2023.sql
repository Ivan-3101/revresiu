alter table if exists ui.validationfieldslist
       add column vcvalidation varchar(255);

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\d{1,13}$/",
    "maxLength": 13,
    "minLength": 1
 }'::character varying WHERE
ifieldid = 8;

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$/",
    "maxLength": 50,
    "type": "string"
 }'::character varying WHERE
ifieldid = 9;

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "type": "string",
    "maxLength": 20,
    "regexp": "/^\\+[0-9]+$/"
 }'::character varying WHERE
ifieldid = 10;

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\d{1,}$/",
    "minLength": 1
 }'::character varying WHERE
ifieldid = 11;

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "maxLength": 255
 }'::character varying WHERE
ifieldid = 1;

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "maxLength": 255
 }'::character varying WHERE
ifieldid = 2;

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^-?([1-8]?[1-9]|[1-9]0)\\.{1}\\d{1,15},-?(([-+]?)([\\d]{1,3})((\\.)(\\d+))?)$/",
    "maxLength": 50
 }'::character varying WHERE
ifieldid = 5;

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^[a-zA-Z]{2}$/",
    "maxLength": 2,
    "minLength": 2
 }'::character varying WHERE
ifieldid = 6;

CREATE TABLE IF NOT EXISTS camunda.allocationusers
(
    role1groupid integer NOT NULL,
    role1userid integer NOT NULL,
    role2groupid integer NOT NULL,
    role2userid integer NOT NULL,
    workflowid integer NOT NULL,
    CONSTRAINT allocationusers_pkey PRIMARY KEY (role1groupid, role1userid, role2groupid, role2userid, workflowid),
    CONSTRAINT fk3f3x01pvetdykte2i8toca7ir FOREIGN KEY (workflowid)
        REFERENCES ui.workflowmasters (workflowid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkelsuqqdl80y9ophxg6dogb5j5 FOREIGN KEY (role1groupid)
        REFERENCES ui.groupdesc (igroupid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkf71vtgqcxh9o1onm1488kadn6 FOREIGN KEY (role2groupid)
        REFERENCES ui.groupdesc (igroupid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkh77cwi8jpbs956ljcr0tbr25v FOREIGN KEY (role2userid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkq2bi02cj1qcs0t5vmv473491w FOREIGN KEY (role1userid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)


INSERT INTO ui.menustructuredesc(
	imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus)
	VALUES (572, false, null, null, 6, 'AutoAllocationUserMapping', 'AutoAllocationUserMapping', null, null, '/user', 'Auto Allocation User Mapping', 'AUM', '/case-management/add-workflow-mapping', null, null, null, null, null, 479, 1);

SELECT pg_catalog.setval('ui.rolemenuaccessmap_irolemenumapid_seq', (SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap)+1, true);

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '572'::integer, '1'::integer)
returning irolemenumapid;

