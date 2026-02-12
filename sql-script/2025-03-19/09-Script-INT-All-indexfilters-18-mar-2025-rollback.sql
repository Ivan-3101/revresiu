-- Drop the first index on text_ column
DROP INDEX IF EXISTS camunda.act_idx_variable_var_name_double_text;

-- Drop the second index on long_ column
DROP INDEX IF EXISTS camunda.act_idx_variable_var_name_double_long;