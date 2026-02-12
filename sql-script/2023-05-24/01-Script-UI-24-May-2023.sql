CREATE SEQUENCE IF NOT EXISTS masters.rulesdraft_iruledraftid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS masters.rulesdraft
(
    iruledraftid integer NOT NULL DEFAULT nextval('masters.rulesdraft_iruledraftid_seq'::regclass),
    bcustom boolean,
    bpayee boolean,
    bpayer boolean,
    btransaction boolean,
    bactive boolean,
    bdelete boolean,
    vclabel text COLLATE pg_catalog."default",
    vcruledescription character varying(1000) COLLATE pg_catalog."default",
    vcruledetail text COLLATE pg_catalog."default",
    ruledimension character varying(255) COLLATE pg_catalog."default",
    vcrulename character varying(255) COLLATE pg_catalog."default",
    vcruleparams text COLLATE pg_catalog."default",
    rulestate character varying(255) COLLATE pg_catalog."default",
    vcruletype character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT rulesdraft_pkey PRIMARY KEY (iruledraftid)
);

CREATE SEQUENCE IF NOT EXISTS ui.rulesavailable_iruleavailableid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
CREATE SEQUENCE IF NOT EXISTS ui.rulesavailableaudit_iruleavailableauditid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
CREATE SEQUENCE IF NOT EXISTS ui.rulesdraft_iruledraftid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
CREATE SEQUENCE IF NOT EXISTS ui.rulesdraftaudit_iruledraftauditid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.rulesavailable
(
    iruleavailableid integer NOT NULL DEFAULT nextval('ui.rulesavailable_iruleavailableid_seq'::regclass),
    bcustom boolean,
    bpayee boolean,
    bpayer boolean,
    btransaction boolean,
    bactive boolean,
    bdelete boolean,
    vclabel text COLLATE pg_catalog."default",
    vcruledescription character varying(1000) COLLATE pg_catalog."default",
    vcruledetail text COLLATE pg_catalog."default",
    ruledimension character varying(255) COLLATE pg_catalog."default",
    vcrulename character varying(255) COLLATE pg_catalog."default",
    vcruleparams text COLLATE pg_catalog."default",
    rulestate character varying(255) COLLATE pg_catalog."default",
    vcruletype character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT rulesavailable_pkey PRIMARY KEY (iruleavailableid)
);

CREATE TABLE IF NOT EXISTS ui.rulesavailableaudit
(
    iruleavailableauditid integer NOT NULL DEFAULT nextval('ui.rulesavailableaudit_iruleavailableauditid_seq'::regclass),
    bcustom boolean,
    bpayee boolean,
    bpayer boolean,
    btransaction boolean,
    bactive boolean,
    bdelete boolean,
    vclabel text COLLATE pg_catalog."default",
    vcruledescription character varying(1000) COLLATE pg_catalog."default",
    vcruledetail text COLLATE pg_catalog."default",
    ruledimension character varying(255) COLLATE pg_catalog."default",
    vcrulename character varying(255) COLLATE pg_catalog."default",
    vcruleparams text COLLATE pg_catalog."default",
    rulestate character varying(255) COLLATE pg_catalog."default",
    vcruletype character varying(255) COLLATE pg_catalog."default",
    iruleavailableid integer,
    CONSTRAINT rulesavailableaudit_pkey PRIMARY KEY (iruleavailableauditid),
    CONSTRAINT fkcw2kgvi1b7uy9amqxmpqh3stk FOREIGN KEY (iruleavailableid)
        REFERENCES ui.rulesavailable (iruleavailableid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS ui.rulesdraft
(
    iruledraftid integer NOT NULL DEFAULT nextval('ui.rulesdraft_iruledraftid_seq'::regclass),
    bcustom boolean,
    bpayee boolean,
    bpayer boolean,
    btransaction boolean,
    bactive boolean,
    bdelete boolean,
    vclabel text COLLATE pg_catalog."default",
    vcruledescription character varying(1000) COLLATE pg_catalog."default",
    vcruledetail text COLLATE pg_catalog."default",
    ruledimension character varying(255) COLLATE pg_catalog."default",
    vcrulename character varying(255) COLLATE pg_catalog."default",
    vcruleparams text COLLATE pg_catalog."default",
    rulestate character varying(255) COLLATE pg_catalog."default",
    vcruletype character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT rulesdraft_pkey PRIMARY KEY (iruledraftid)
);

CREATE TABLE IF NOT EXISTS ui.rulesdraftaudit
(
    iruledraftauditid integer NOT NULL DEFAULT nextval('ui.rulesdraftaudit_iruledraftauditid_seq'::regclass),
    bcustom boolean,
    bpayee boolean,
    bpayer boolean,
    btransaction boolean,
    bactive boolean,
    bdelete boolean,
    vclabel text COLLATE pg_catalog."default",
    vcruledescription character varying(1000) COLLATE pg_catalog."default",
    vcruledetail text COLLATE pg_catalog."default",
    ruledimension character varying(255) COLLATE pg_catalog."default",
    vcrulename character varying(255) COLLATE pg_catalog."default",
    vcruleparams text COLLATE pg_catalog."default",
    rulestate character varying(255) COLLATE pg_catalog."default",
    vcruletype character varying(255) COLLATE pg_catalog."default",
    iruledraftid integer,
    CONSTRAINT rulesdraftaudit_pkey PRIMARY KEY (iruledraftauditid),
    CONSTRAINT fkh12dha7bj3nx1nlvm7yuk4bwg FOREIGN KEY (iruledraftid)
        REFERENCES ui.rulesdraft (iruledraftid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

insert into ui.rulesavailable (iruleavailableid, bcustom, bpayee, bpayer, btransaction, bactive, bdelete, vclabel, vcruledescription, vcruledetail, ruledimension, vcrulename, vcruleparams, rulestate, vcruletype)
select iruleavailableid, bcustom, bpayee, bpayer, btransaction, bactive, bdelete, vclabel, vcruledescription, vcruledetail, ruledimension, vcrulename, vcruleparams, rulestate, vcruletype
from masters.rulesavailable

SELECT pg_catalog.setval('ui.rulesavailable_iruleavailableid_seq', (SELECT MAX(iruleavailableid) FROM ui.rulesavailable)+1, true);

SELECT pg_catalog.setval('masters.rulesavailable_iruleavailableid_seq', (SELECT MAX(iruleavailableid) FROM masters.rulesavailable)+1, true);

INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'575'::integer, false::boolean, '5'::integer, 'RuleBuilder'::character varying, 'RuleBuilder'::character varying, '/user'::character varying, 'Rule Builder'::character varying, 'RB'::character varying, '/try-out/rule-creation'::character varying, '480'::integer, '1'::integer)
 returning imenuid;

SELECT pg_catalog.setval('ui.rolemenuaccessmap_irolemenumapid_seq', (SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap)+1, true);

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '575'::integer, '1'::integer)
returning irolemenumapid;

UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
"Date":"date",
"Decision":"string",
"Class":"string",
"Rule ID":"integer",
"Rule Name":"string",
"Score":"integer",
"Rule Triggered Count":"integer",
"Total Txn Count":"integer",
"Rule Efficiency (%)":"float",
"Avg Value (Rules Triggered)":"float",
"Avg Value (Total Txns)":"float",
"False Alert %":"float",
"Unique Accounts Triggered":"integer"
}'::text WHERE
idashboardresultsetid = 12;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'select rp.tdate as "Date", d.vcdecisionname as "Decision", rp.vcclassname as "Class", rp.iruleid as "Rule ID", r.vcrulename as "Rule Name",
rp.score as "Score", rp.scoretxncount as "Rule Triggered Count", rp.totaltxncount as "Total Txn Count",
round( cast((cast(rp.scoretxncount as float)* 100)/rp.totaltxncount as numeric	),2	) as "Rule Efficiency (%)",
round( cast((cast(rp.override_txncount as float)* 100)/rp.scoretxncount as numeric	),2	) as "False Alert %",
rp.scoretxnvalue / rp.scoretxncount as "Avg Value (Rules Triggered)",
rp.totaltxnvalue / rp.totaltxncount as "Avg Value (Total Txns)", 
rp.accounts_affected as "Unique Accounts Triggered"
from transactions.rule_performance rp
left join masters.rules r on r.iruleid = rp.iruleid
left join masters.decisions d on d.idecisionid = rp.idecisionid where tdate  between cast(:StartDate as date) and cast(:EndDate as date)-1 and score > 0 ;
'::text WHERE
idashboardqueryid = 31;
