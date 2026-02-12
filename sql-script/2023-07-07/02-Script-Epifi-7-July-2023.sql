update ui.tasklhsmap set valueconfig='{"tag": "span", "path": "this.variables.WorkflowName", "type": "default"}'::jsonb
where (iworkflowid=1 or iworkflowid=2) and (irow=1 and iorder=0);