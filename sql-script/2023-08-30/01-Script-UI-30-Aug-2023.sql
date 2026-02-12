CREATE TABLE IF NOT EXISTS ui.clientuser
(
    clientid character varying(255) COLLATE pg_catalog."default" NOT NULL,
    bactive boolean,
    bdelete boolean,
    vcclientname character varying(255) COLLATE pg_catalog."default",
    vcclientsecret character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT clientuser_pkey PRIMARY KEY (clientid)
);


alter table if exists ui.activelogintokens
       add column clientuser varchar(255);

alter table if exists ui.activelogintokens
       add constraint FK54mjhppywj5cwdwdlrieoguct
       foreign key (clientuser)
       references ui.clientuser;

INSERT INTO ui.menustructuredesc VALUES (576, false, NULL, NULL, 2, 'EmailScheduler', 'EmailScheduler', NULL, NULL, '/user', 'Email Scheduler', 'EL', '/admin/email-scheduler', NULL, NULL, NULL, NULL, NULL, 482, 1);

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '576'::integer, '1'::integer)
 returning irolemenumapid;

delete from ui.rolemenuaccessmap where imenuid=506;
