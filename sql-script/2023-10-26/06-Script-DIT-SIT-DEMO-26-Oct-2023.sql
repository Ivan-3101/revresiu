UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Sanctions'::character varying WHERE
workflowid = 15;