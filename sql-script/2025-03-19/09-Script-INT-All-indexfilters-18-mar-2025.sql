
CREATE INDEX act_idx_variable_var_name_double_text ON camunda.act_ru_variable USING btree (name_,task_id_,proc_inst_id_ , type_,text_);

CREATE INDEX act_idx_variable_var_name_double_long ON camunda.act_ru_variable USING btree (name_,task_id_,proc_inst_id_ , type_,long_);
