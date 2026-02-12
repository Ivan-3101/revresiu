-- Remove the columns from ui.workflowmasters
ALTER TABLE ui.workflowmasters DROP COLUMN IF EXISTS isAutoClose;
ALTER TABLE ui.workflowmasters DROP COLUMN IF EXISTS autoCloseConfig;