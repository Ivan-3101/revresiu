

CREATE TABLE IF NOT EXISTS ui.clientuser
(
    clientid character varying(255) COLLATE pg_catalog."default" NOT NULL,
    bactive boolean,
    bdelete boolean,
    vcclientname character varying(255) COLLATE pg_catalog."default",
    vcclientsecret character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT clientuser_pkey PRIMARY KEY (clientid)
);


GRANT ALL ON TABLE ui.clientuser TO appuserdevdblocal;

alter table if exists ui.activelogintokens
       add column clientuser varchar(255);

alter table if exists ui.activelogintokens
       add constraint FK54mjhppywj5cwdwdlrieoguct
       foreign key (clientuser)
       references ui.clientuser;

INSERT INTO ui.clientuser (
clientid, bactive, bdelete, vcclientname, vcclientsecret) VALUES (
'4f9581fd-407e-4a78-b2d5-8782e45d71ba'::character varying, true::boolean, true::boolean, 'frmuser'::character varying, '$2a$10$mVKVoXQzTmEeGHib2A.kT.mcP5xy.68wluSKlhc5xIClDwIqOlHq2'::character varying)
 returning clientid;