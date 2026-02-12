-- Rollback for: CREATE INDEX CONCURRENTLY IF NOT EXISTS act_idx_variable_task_name_type_text_new
DROP INDEX IF EXISTS camunda.act_idx_variable_task_name_type_text_new;

-- Rollback for: DROP INDEX IF EXISTS camunda.act_idx_variable_task_name_type_text
-- Recreate the original index
CREATE INDEX CONCURRENTLY IF NOT EXISTS act_idx_variable_task_name_type_text
    ON camunda.act_ru_variable USING btree
    (task_id_ COLLATE pg_catalog."default" ASC NULLS LAST,
     name_ COLLATE pg_catalog."default" ASC NULLS LAST,
     text_ COLLATE pg_catalog."default" ASC NULLS LAST,
     type_ COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Rollback for: CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_var_procinst_filtered
DROP INDEX IF EXISTS camunda.idx_var_procinst_filtered;
