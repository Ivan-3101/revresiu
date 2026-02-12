UPDATE ui.workflowmasters SET
is_manual_creation = false::boolean, is_filter_display = true::boolean, manual_display_name = 'Risky Merchant Settlements'::character varying WHERE
workflowid = 16;