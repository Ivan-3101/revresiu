
update ui.workflowmasters set idecisionid = 
(select idecisionid from ui.decisions where vcdecisionname='YB_MANUAL_DECISION')
where workflowid = 4 and itenantid = 8;