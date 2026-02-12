ALTER TABLE IF EXISTS ui.dashboardquery
    ADD COLUMN dbtype integer;

UPDATE ui.dashboardquery
SET dbtype = 1;