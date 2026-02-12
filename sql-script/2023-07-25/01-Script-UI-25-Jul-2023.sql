CREATE SEQUENCE IF NOT EXISTS ui.emailaudittrail_auditid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.emailaudittrail
(
    auditid integer NOT NULL DEFAULT nextval('ui.emailaudittrail_auditid_seq'::regclass),
    emailtemplateid integer,
    sentsubject text COLLATE pg_catalog."default",
    sentbody text COLLATE pg_catalog."default",
    correlation_id character varying(255) COLLATE pg_catalog."default",
    senttimestamp timestamp without time zone,
    responsesubject text COLLATE pg_catalog."default",
    responsebody text COLLATE pg_catalog."default",
    responsetimestamp timestamp without time zone,
    processingstatus integer,
    statustimestamp timestamp without time zone,
    responseattachments text[] COLLATE pg_catalog."default",
    CONSTRAINT emailaudittrail_pkey PRIMARY KEY (auditid),
    CONSTRAINT emailtemplate_fkey FOREIGN KEY (emailtemplateid)
        REFERENCES ui.emailtemplate (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS ui.emailtemplate
    ADD COLUMN response text COLLATE pg_catalog."default";

ALTER TABLE IF EXISTS ui.emailtemplate
    ADD COLUMN camunda_message_name character varying(255) COLLATE pg_catalog."default";