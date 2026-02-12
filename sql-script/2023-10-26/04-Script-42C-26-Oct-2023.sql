UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'CUB-Risk Notification'::character varying WHERE
workflowid = 13;
UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'USFB-Risk Notification'::character varying WHERE
workflowid = 14;