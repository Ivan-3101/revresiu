
DROP TABLE IF EXISTS batch.batch_job_data CASCADE;

CREATE TABLE IF NOT EXISTS batch.batch_job_data
(
    jobdataid integer NOT NULL,
    jobdata jsonb,
    processresponse jsonb,
    status character varying(255) COLLATE pg_catalog."default",
    jobid integer,
    CONSTRAINT batch_job_data_pkey PRIMARY KEY (jobdataid)
);

CREATE SEQUENCE IF NOT EXISTS batch.batch_job_data_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

ALTER TABLE ONLY batch.batch_job_data ALTER COLUMN jobdataid SET DEFAULT nextval('batch.batch_job_data_seq'::regclass);