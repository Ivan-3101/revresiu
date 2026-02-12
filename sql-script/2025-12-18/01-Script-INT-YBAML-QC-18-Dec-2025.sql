UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", ACT_TYPE_ AS "activityType", ACT_NAME_ AS "activityName", ASSIGNEE_ AS "assignee", TASK_ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN ACT_INST_STATE_ = 2 THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_ACTINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ACT_TYPE_ IN ( ''userTask'', ''noneEndEvent'', ''startEvent'', ''sendTask'', ''receiveTask'' ) ORDER BY END_TIME_ DESC'::text WHERE
itenantid = 8 AND idashboardqueryid = 178;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PD.ID_ AS "id", FROM_UTF8(BA.BYTES_) AS "bpmn20Xml" FROM postgresql.camunda.ACT_RE_PROCDEF PD JOIN postgresql.camunda.ACT_GE_BYTEARRAY BA ON PD.DEPLOYMENT_ID_ = BA.DEPLOYMENT_ID_ AND PD.RESOURCE_NAME_ = BA.NAME_ WHERE PD.ID_ = :processdefid'::text WHERE
itenantid = 8 AND idashboardqueryid = 179;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT RES.ID_ AS "id", RES.ROOT_PROC_INST_ID_ AS "processInstanceId", RES.TYPE_ AS "type", RES.ACT_INST_ID_ AS "activityInstanceId", RES.TASK_ID_ AS "taskId", RES.NAME_ AS "name", RES.TEXT_ AS "value", RES.TIME_ AS "time", RES.TENANT_ID_ AS "tenantId" FROM t8refined.camunda.ACT_HI_DETAIL RES JOIN t8refined.camunda.ACT_GE_BYTEARRAY BA ON RES.ROOT_PROC_INST_ID_ = BA.ROOT_PROC_INST_ID_ WHERE RES.ROOT_PROC_INST_ID_ = :processinstanceid AND ( ( RES.TYPE_ = ''VariableUpdate'' AND RES.NAME_ IN ( ''userActivity'', ''checker_action_whitelist_obj'', ''strHistoryUpdate'', ''AlertIDs'', ''parentProcess'' ) ) OR ( RES.TYPE_ = ''FormProperty'' AND ( RES.NAME_ IN ( ''Remarks'', ''DocumentReviewRemarks'', ''Action1'', ''Action2'', ''Action'', ''Block'' ) OR RES.NAME_ LIKE ''Action%'' ) ) )'::text WHERE
itenantid = 8 AND idashboardqueryid = 180;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t8refined.camunda.ACT_HI_COMMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids) AND TYPE_ =''comment'''::text WHERE
itenantid = 8 AND idashboardqueryid = 181;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", NAME_ AS "name", TASK_ID_ AS "taskId", CREATE_TIME_ AS "createTime", DESCRIPTION_ AS "description" FROM t8refined.camunda.ACT_HI_ATTACHMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids)'::text WHERE
itenantid = 8 AND idashboardqueryid = 182;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ACT_INST_ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", NAME_ AS "activityName", ASSIGNEE_ AS "assignee", ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TASK_DEF_KEY_ AS "activityId", TENANT_ID_ AS "tenantId", CASE WHEN DELETE_REASON_ IS NOT NULL AND LOWER(DELETE_REASON_) LIKE''%cancel%'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_TASKINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ID_ IN (:taskids)'::text WHERE
itenantid = 8 AND idashboardqueryid = 183;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PROC_DEF_ID_ AS "processDefinitionId", root_proc_inst_id_  AS "processInstanceId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN STATE_ =''CANCELED'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_PROCINST WHERE root_proc_inst_id_ = :processinstanceid'::text WHERE
itenantid = 8 AND idashboardqueryid = 184;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", ACT_TYPE_ AS "activityType", ACT_NAME_ AS "activityName", ASSIGNEE_ AS "assignee", TASK_ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN ACT_INST_STATE_ = 2 THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_ACTINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ACT_TYPE_ IN ( ''userTask'', ''noneEndEvent'', ''startEvent'', ''sendTask'', ''receiveTask'' ) ORDER BY END_TIME_ DESC'::text WHERE
itenantid = 17 AND idashboardqueryid = 178;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PD.ID_ AS "id", FROM_UTF8(BA.BYTES_) AS "bpmn20Xml" FROM postgresql.camunda.ACT_RE_PROCDEF PD JOIN postgresql.camunda.ACT_GE_BYTEARRAY BA ON PD.DEPLOYMENT_ID_ = BA.DEPLOYMENT_ID_ AND PD.RESOURCE_NAME_ = BA.NAME_ WHERE PD.ID_ = :processdefid'::text WHERE
itenantid = 17 AND idashboardqueryid = 179;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT RES.ID_ AS "id", RES.ROOT_PROC_INST_ID_ AS "processInstanceId", RES.TYPE_ AS "type", RES.ACT_INST_ID_ AS "activityInstanceId", RES.TASK_ID_ AS "taskId", RES.NAME_ AS "name", RES.TEXT_ AS "value", RES.TIME_ AS "time", RES.TENANT_ID_ AS "tenantId" FROM t8refined.camunda.ACT_HI_DETAIL RES JOIN t8refined.camunda.ACT_GE_BYTEARRAY BA ON RES.ROOT_PROC_INST_ID_ = BA.ROOT_PROC_INST_ID_ WHERE RES.ROOT_PROC_INST_ID_ = :processinstanceid AND ( ( RES.TYPE_ = ''VariableUpdate'' AND RES.NAME_ IN ( ''userActivity'', ''checker_action_whitelist_obj'', ''strHistoryUpdate'', ''AlertIDs'', ''parentProcess'' ) ) OR ( RES.TYPE_ = ''FormProperty'' AND ( RES.NAME_ IN ( ''Remarks'', ''DocumentReviewRemarks'', ''Action1'', ''Action2'', ''Action'', ''Block'' ) OR RES.NAME_ LIKE ''Action%'' ) ) )'::text WHERE
itenantid = 17 AND idashboardqueryid = 180;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t8refined.camunda.ACT_HI_COMMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids) AND TYPE_ =''comment'''::text WHERE
itenantid = 17 AND idashboardqueryid = 181;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", NAME_ AS "name", TASK_ID_ AS "taskId", CREATE_TIME_ AS "createTime", DESCRIPTION_ AS "description" FROM t8refined.camunda.ACT_HI_ATTACHMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids)'::text WHERE
itenantid = 17 AND idashboardqueryid = 182;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ACT_INST_ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", NAME_ AS "activityName", ASSIGNEE_ AS "assignee", ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TASK_DEF_KEY_ AS "activityId", TENANT_ID_ AS "tenantId", CASE WHEN DELETE_REASON_ IS NOT NULL AND LOWER(DELETE_REASON_) LIKE''%cancel%'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_TASKINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ID_ IN (:taskids)'::text WHERE
itenantid = 17 AND idashboardqueryid = 183;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PROC_DEF_ID_ AS "processDefinitionId", root_proc_inst_id_  AS "processInstanceId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN STATE_ =''CANCELED'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_PROCINST WHERE root_proc_inst_id_ = :processinstanceid'::text WHERE
itenantid = 17 AND idashboardqueryid = 184;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", ACT_TYPE_ AS "activityType", ACT_NAME_ AS "activityName", ASSIGNEE_ AS "assignee", TASK_ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN ACT_INST_STATE_ = 2 THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_ACTINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ACT_TYPE_ IN ( ''userTask'', ''noneEndEvent'', ''startEvent'', ''sendTask'', ''receiveTask'' ) ORDER BY END_TIME_ DESC'::text WHERE
itenantid = 21 AND idashboardqueryid = 178;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PD.ID_ AS "id", FROM_UTF8(BA.BYTES_) AS "bpmn20Xml" FROM postgresql.camunda.ACT_RE_PROCDEF PD JOIN postgresql.camunda.ACT_GE_BYTEARRAY BA ON PD.DEPLOYMENT_ID_ = BA.DEPLOYMENT_ID_ AND PD.RESOURCE_NAME_ = BA.NAME_ WHERE PD.ID_ = :processdefid'::text WHERE
itenantid = 21 AND idashboardqueryid = 179;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT RES.ID_ AS "id", RES.ROOT_PROC_INST_ID_ AS "processInstanceId", RES.TYPE_ AS "type", RES.ACT_INST_ID_ AS "activityInstanceId", RES.TASK_ID_ AS "taskId", RES.NAME_ AS "name", RES.TEXT_ AS "value", RES.TIME_ AS "time", RES.TENANT_ID_ AS "tenantId" FROM t8refined.camunda.ACT_HI_DETAIL RES JOIN t8refined.camunda.ACT_GE_BYTEARRAY BA ON RES.ROOT_PROC_INST_ID_ = BA.ROOT_PROC_INST_ID_ WHERE RES.ROOT_PROC_INST_ID_ = :processinstanceid AND ( ( RES.TYPE_ = ''VariableUpdate'' AND RES.NAME_ IN ( ''userActivity'', ''checker_action_whitelist_obj'', ''strHistoryUpdate'', ''AlertIDs'', ''parentProcess'' ) ) OR ( RES.TYPE_ = ''FormProperty'' AND ( RES.NAME_ IN ( ''Remarks'', ''DocumentReviewRemarks'', ''Action1'', ''Action2'', ''Action'', ''Block'' ) OR RES.NAME_ LIKE ''Action%'' ) ) )'::text WHERE
itenantid = 21 AND idashboardqueryid = 180;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t8refined.camunda.ACT_HI_COMMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids) AND TYPE_ =''comment'''::text WHERE
itenantid = 21 AND idashboardqueryid = 181;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", NAME_ AS "name", TASK_ID_ AS "taskId", CREATE_TIME_ AS "createTime", DESCRIPTION_ AS "description" FROM t8refined.camunda.ACT_HI_ATTACHMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids)'::text WHERE
itenantid = 21 AND idashboardqueryid = 182;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ACT_INST_ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", NAME_ AS "activityName", ASSIGNEE_ AS "assignee", ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TASK_DEF_KEY_ AS "activityId", TENANT_ID_ AS "tenantId", CASE WHEN DELETE_REASON_ IS NOT NULL AND LOWER(DELETE_REASON_) LIKE''%cancel%'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_TASKINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ID_ IN (:taskids)'::text WHERE
itenantid = 21 AND idashboardqueryid = 183;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PROC_DEF_ID_ AS "processDefinitionId", root_proc_inst_id_  AS "processInstanceId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN STATE_ =''CANCELED'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_PROCINST WHERE root_proc_inst_id_ = :processinstanceid'::text WHERE
itenantid = 21 AND idashboardqueryid = 184;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", ACT_TYPE_ AS "activityType", ACT_NAME_ AS "activityName", ASSIGNEE_ AS "assignee", TASK_ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN ACT_INST_STATE_ = 2 THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_ACTINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ACT_TYPE_ IN ( ''userTask'', ''noneEndEvent'', ''startEvent'', ''sendTask'', ''receiveTask'' ) ORDER BY END_TIME_ DESC'::text WHERE
itenantid = 22 AND idashboardqueryid = 178;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PD.ID_ AS "id", FROM_UTF8(BA.BYTES_) AS "bpmn20Xml" FROM postgresql.camunda.ACT_RE_PROCDEF PD JOIN postgresql.camunda.ACT_GE_BYTEARRAY BA ON PD.DEPLOYMENT_ID_ = BA.DEPLOYMENT_ID_ AND PD.RESOURCE_NAME_ = BA.NAME_ WHERE PD.ID_ = :processdefid'::text WHERE
itenantid = 22 AND idashboardqueryid = 179;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT RES.ID_ AS "id", RES.ROOT_PROC_INST_ID_ AS "processInstanceId", RES.TYPE_ AS "type", RES.ACT_INST_ID_ AS "activityInstanceId", RES.TASK_ID_ AS "taskId", RES.NAME_ AS "name", RES.TEXT_ AS "value", RES.TIME_ AS "time", RES.TENANT_ID_ AS "tenantId" FROM t8refined.camunda.ACT_HI_DETAIL RES JOIN t8refined.camunda.ACT_GE_BYTEARRAY BA ON RES.ROOT_PROC_INST_ID_ = BA.ROOT_PROC_INST_ID_ WHERE RES.ROOT_PROC_INST_ID_ = :processinstanceid AND ( ( RES.TYPE_ = ''VariableUpdate'' AND RES.NAME_ IN ( ''userActivity'', ''checker_action_whitelist_obj'', ''strHistoryUpdate'', ''AlertIDs'', ''parentProcess'' ) ) OR ( RES.TYPE_ = ''FormProperty'' AND ( RES.NAME_ IN ( ''Remarks'', ''DocumentReviewRemarks'', ''Action1'', ''Action2'', ''Action'', ''Block'' ) OR RES.NAME_ LIKE ''Action%'' ) ) )'::text WHERE
itenantid = 22 AND idashboardqueryid = 180;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t8refined.camunda.ACT_HI_COMMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids) AND TYPE_ =''comment'''::text WHERE
itenantid = 22 AND idashboardqueryid = 181;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", NAME_ AS "name", TASK_ID_ AS "taskId", CREATE_TIME_ AS "createTime", DESCRIPTION_ AS "description" FROM t8refined.camunda.ACT_HI_ATTACHMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids)'::text WHERE
itenantid = 22 AND idashboardqueryid = 182;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ACT_INST_ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", NAME_ AS "activityName", ASSIGNEE_ AS "assignee", ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TASK_DEF_KEY_ AS "activityId", TENANT_ID_ AS "tenantId", CASE WHEN DELETE_REASON_ IS NOT NULL AND LOWER(DELETE_REASON_) LIKE''%cancel%'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_TASKINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ID_ IN (:taskids)'::text WHERE
itenantid = 22 AND idashboardqueryid = 183;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PROC_DEF_ID_ AS "processDefinitionId", root_proc_inst_id_  AS "processInstanceId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN STATE_ =''CANCELED'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_PROCINST WHERE root_proc_inst_id_ = :processinstanceid'::text WHERE
itenantid = 22 AND idashboardqueryid = 184;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", ACT_TYPE_ AS "activityType", ACT_NAME_ AS "activityName", ASSIGNEE_ AS "assignee", TASK_ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN ACT_INST_STATE_ = 2 THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_ACTINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ACT_TYPE_ IN ( ''userTask'', ''noneEndEvent'', ''startEvent'', ''sendTask'', ''receiveTask'' ) ORDER BY END_TIME_ DESC'::text WHERE
itenantid = 23 AND idashboardqueryid = 178;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PD.ID_ AS "id", FROM_UTF8(BA.BYTES_) AS "bpmn20Xml" FROM postgresql.camunda.ACT_RE_PROCDEF PD JOIN postgresql.camunda.ACT_GE_BYTEARRAY BA ON PD.DEPLOYMENT_ID_ = BA.DEPLOYMENT_ID_ AND PD.RESOURCE_NAME_ = BA.NAME_ WHERE PD.ID_ = :processdefid'::text WHERE
itenantid = 23 AND idashboardqueryid = 179;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT RES.ID_ AS "id", RES.ROOT_PROC_INST_ID_ AS "processInstanceId", RES.TYPE_ AS "type", RES.ACT_INST_ID_ AS "activityInstanceId", RES.TASK_ID_ AS "taskId", RES.NAME_ AS "name", RES.TEXT_ AS "value", RES.TIME_ AS "time", RES.TENANT_ID_ AS "tenantId" FROM t8refined.camunda.ACT_HI_DETAIL RES JOIN t8refined.camunda.ACT_GE_BYTEARRAY BA ON RES.ROOT_PROC_INST_ID_ = BA.ROOT_PROC_INST_ID_ WHERE RES.ROOT_PROC_INST_ID_ = :processinstanceid AND ( ( RES.TYPE_ = ''VariableUpdate'' AND RES.NAME_ IN ( ''userActivity'', ''checker_action_whitelist_obj'', ''strHistoryUpdate'', ''AlertIDs'', ''parentProcess'' ) ) OR ( RES.TYPE_ = ''FormProperty'' AND ( RES.NAME_ IN ( ''Remarks'', ''DocumentReviewRemarks'', ''Action1'', ''Action2'', ''Action'', ''Block'' ) OR RES.NAME_ LIKE ''Action%'' ) ) )'::text WHERE
itenantid = 23 AND idashboardqueryid = 180;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", TASK_ID_ AS "taskId", TIME_ AS "time", from_utf8(FULL_MSG_) AS "message" FROM t8refined.camunda.ACT_HI_COMMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids) AND TYPE_ =''comment'''::text WHERE
itenantid = 23 AND idashboardqueryid = 181;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ID_ AS "id", root_proc_inst_id_  AS "processInstanceId", NAME_ AS "name", TASK_ID_ AS "taskId", CREATE_TIME_ AS "createTime", DESCRIPTION_ AS "description" FROM t8refined.camunda.ACT_HI_ATTACHMENT WHERE root_proc_inst_id_ = :processinstanceid AND TASK_ID_ IN (:taskids)'::text WHERE
itenantid = 23 AND idashboardqueryid = 182;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT ACT_INST_ID_ AS "id", ROOT_PROC_INST_ID_ AS "processInstanceId", NAME_ AS "activityName", ASSIGNEE_ AS "assignee", ID_ AS "taskId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TASK_DEF_KEY_ AS "activityId", TENANT_ID_ AS "tenantId", CASE WHEN DELETE_REASON_ IS NOT NULL AND LOWER(DELETE_REASON_) LIKE''%cancel%'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_TASKINST WHERE ROOT_PROC_INST_ID_ = :processinstanceid AND ID_ IN (:taskids)'::text WHERE
itenantid = 23 AND idashboardqueryid = 183;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT PROC_DEF_ID_ AS "processDefinitionId", root_proc_inst_id_  AS "processInstanceId", START_TIME_ AS "startTime", END_TIME_ AS "endTime", TENANT_ID_ AS "tenantId", CASE WHEN STATE_ =''CANCELED'' THEN TRUE ELSE FALSE END AS "canceled" FROM t8refined.camunda.ACT_HI_PROCINST WHERE root_proc_inst_id_ = :processinstanceid'::text WHERE
itenantid = 23 AND idashboardqueryid = 184;

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 181, NULL, 8, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 182, NULL, 8, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 183, NULL, 8, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 181, NULL, 17, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 182, NULL, 17, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 183, NULL, 17, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 181, NULL, 21, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 182, NULL, 21, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 183, NULL, 21, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 181, NULL, 22, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 182, NULL, 22, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 183, NULL, 22, NULL);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 181, NULL, 23, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 182, NULL, 23, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid, validation) VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'processinstanceid', 'String', 183, NULL, 23, NULL);