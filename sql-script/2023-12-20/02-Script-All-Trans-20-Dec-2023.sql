DROP INDEX IF EXISTS camunda.act_idx_variable_task_name_type;

CREATE INDEX IF NOT EXISTS act_idx_variable_task_name_type_text
    ON camunda.act_ru_variable USING btree
    (task_id_ COLLATE pg_catalog."default" ASC NULLS LAST, name_ COLLATE pg_catalog."default" ASC NULLS LAST, text_ COLLATE pg_catalog."default" ASC NULLS LAST, type_ COLLATE pg_catalog."default" ASC NULLS LAST);
