create schema t22refined.ui;

CREATE view t22refined.ui.activitylog  AS
SELECT iactivityid, dtactivity, vcactivity, vcparameters, iuserid, iorgid
FROM t17refined.ui.activitylog;

create schema t21refined.ui;

CREATE view t21refined.ui.activitylog  AS
SELECT iactivityid, dtactivity, vcactivity, vcparameters, iuserid, iorgid
FROM t17refined.ui.activitylog;

create schema t8refined.ui;

CREATE view t8refined.ui.activitylog  AS
SELECT iactivityid, dtactivity, vcactivity, vcparameters, iuserid, iorgid
FROM t17refined.ui.activitylog;