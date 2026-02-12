alter table if exists ui.taskfiltermaster
       add column vccondition varchar(255);


UPDATE ui.taskfiltermaster SET
vccondition = 'filters?.selectWorkflowName?.findIndex(e=>e.label.replace(` `,``).toLowerCase()===`amlcases`)>-1'::character varying WHERE
itaskfilterid = 10;