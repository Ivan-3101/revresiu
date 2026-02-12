CREATE INDEX CONCURRENTLY IF NOT EXISTS act_idx_variable_task_name_type_text_new
    ON camunda.act_ru_variable USING btree
    (proc_inst_id_ COLLATE pg_catalog."default" ASC NULLS LAST, task_id_ COLLATE pg_catalog."default" ASC NULLS LAST, name_ COLLATE pg_catalog."default" ASC NULLS LAST, text_ COLLATE pg_catalog."default" ASC NULLS LAST, type_ COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

DROP INDEX IF EXISTS camunda.act_idx_variable_task_name_type_text;


CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_var_procinst_filtered
        ON camunda.act_ru_variable (proc_inst_id_, name_)
    WHERE name_ IN ('payer','payee','TransactionAmount','TicketID','Alert','basedon','address','userActivity');