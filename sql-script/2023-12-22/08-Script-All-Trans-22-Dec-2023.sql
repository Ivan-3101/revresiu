DROP INDEX IF EXISTS camunda.act_idx_variable_task_name_type;

CREATE INDEX IF NOT EXISTS act_idx_variable_task_name_type_text
    ON camunda.act_ru_variable USING btree
    (task_id_ COLLATE pg_catalog."default" ASC NULLS LAST, name_ COLLATE pg_catalog."default" ASC NULLS LAST, text_ COLLATE pg_catalog."default" ASC NULLS LAST, type_ COLLATE pg_catalog."default" ASC NULLS LAST);



delete from ui.rulesavailable;

insert into ui.rulesavailable (iruleavailableid, bcustom, bpayee, bpayer, btransaction, bactive, bdelete, vclabel, vcruledescription, vcruledetail, ruledimension, vcrulename, vcruleparams, rulestate, vcruletype, itenantid)
select iruleavailableid, bcustom, bpayee, bpayer, btransaction, bactive, bdelete, vclabel, vcruledescription, vcruledetail, ruledimension, vcrulename, vcruleparams, rulestate, vcruletype, itenantid
from masters.rulesavailable;
ALTER TABLE ui.rulesavailable DROP CONSTRAINT rulesavailable_pkey CASCADE;
ALTER TABLE ui.rulesavailable ADD CONSTRAINT rulesavailable_pkey PRIMARY KEY (iruleavailableid, itenantid);

SELECT setval(pg_get_serial_sequence('ui.rulesavailable', 'iruleavailableid'), coalesce(MAX(iruleavailableid), 1))
from ui.rulesavailable;


