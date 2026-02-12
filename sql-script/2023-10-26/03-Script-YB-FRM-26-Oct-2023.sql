UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Blocked Settlements'::character varying WHERE
workflowid = 6;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Risk Alert'::character varying WHERE
workflowid = 12;
