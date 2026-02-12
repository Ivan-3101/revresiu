UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t8refined.camunda.ACT_HI_COMMENT WHERE TASK_ID_ in (:taskids) AND TYPE_ = ''comment'''::text WHERE
idashboardqueryid = 181 AND itenantid = 8;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t17refined.camunda.ACT_HI_COMMENT WHERE TASK_ID_ in (:taskids) AND TYPE_ = ''comment'''::text WHERE
idashboardqueryid = 181 AND itenantid = 17;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t21refined.camunda.ACT_HI_COMMENT WHERE TASK_ID_ in (:taskids) AND TYPE_ = ''comment'''::text WHERE
idashboardqueryid = 181 AND itenantid = 21;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t22refined.camunda.ACT_HI_COMMENT WHERE TASK_ID_ in (:taskids) AND TYPE_ = ''comment'''::text WHERE
idashboardqueryid = 181 AND itenantid = 22;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t23refined.camunda.ACT_HI_COMMENT WHERE TASK_ID_ in (:taskids) AND TYPE_ = ''comment'''::text WHERE
idashboardqueryid = 181 AND itenantid = 23;