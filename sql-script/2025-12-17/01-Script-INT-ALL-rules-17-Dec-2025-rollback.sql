--Drop not null constraint from rulesaudit table
ALTER TABLE ui.rulesaudit
ALTER COLUMN vcrulename DROP NOT NULL,
ALTER COLUMN vcruledescription DROP NOT NULL;

--Drop not null constraint from rules table
ALTER TABLE ui.rules
ALTER COLUMN vcruledescription DROP NOT NULL;