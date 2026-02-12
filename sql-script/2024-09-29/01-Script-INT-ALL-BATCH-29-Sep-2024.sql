ALTER TABLE IF EXISTS batch.batch_job
    ADD COLUMN ientryuserid integer;

ALTER TABLE IF EXISTS batch.batch_job
    ADD COLUMN iorgid integer;

ALTER TABLE IF EXISTS batch.batch_job
    ADD COLUMN vcremark character varying(255);