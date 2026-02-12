update ui.dashboardquery set vcfilterparametersjson='{"Party": null, "AttribsForm":null}' where idashboardqueryid=48;


ALTER TABLE ui.activitylog
    ALTER COLUMN vcactivity TYPE text COLLATE pg_catalog."default";