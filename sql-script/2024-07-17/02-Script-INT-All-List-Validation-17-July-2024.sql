UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\+\\d{1,12}$/",
    "regexpmessage": "Mobile number has to be a valid number starting with +Country code followed by number",
    "maxLength": 13
}':: character varying WHERE
vcfielddisplayname like '%Mobile%';


UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\d{4,12}$/",
    "minLength": 4,
    "maxLength": 12,
    "regexpmessage":"Pincode has to be between 4-12 digits"
 }':: character varying WHERE
vcfielddisplayname like '%Pincode%';



UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\d{6,8}$/",
    "regexpmessage": "BIN has to be a valid number with 6-8 digits",
    "maxLength": 8
}':: character varying WHERE
vcfielddisplayname like '%BIN%';


CREATE INDEX IF NOT EXISTS idx_batch_job_data_jobid_status_itenantid
    ON batch.batch_job_data USING btree
    (jobid ASC NULLS LAST, status COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;