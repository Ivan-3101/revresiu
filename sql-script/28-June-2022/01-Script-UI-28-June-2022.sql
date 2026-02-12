CREATE SEQUENCE IF NOT EXISTS ui.activelogintokens_activelogintokenid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.activelogintokens
(
    activelogintokenid integer NOT NULL DEFAULT nextval('ui.activelogintokens_activelogintokenid_seq'::regclass),
    active_login_token text COLLATE pg_catalog."default",
    dtentrydatetime timestamp without time zone,
    iuserid integer,
    CONSTRAINT activelogintokens_pkey PRIMARY KEY (activelogintokenid),
    CONSTRAINT fkjip591s0a6a5huckv35dao2xh FOREIGN KEY (iuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

Alter table ui.webuser Add Column loginattempts integer;

UPDATE ui.webuser SET  loginattempts=0;
