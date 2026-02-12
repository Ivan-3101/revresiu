CREATE INDEX idx_batch_job_data_jobid
ON batch.batch_job_data USING btree (jobid);

ALTER TABLE batch.batch_job
    ALTER COLUMN vcremark TYPE text COLLATE pg_catalog."default";

