DELETE FROM ui.panelaccessmap
WHERE panelaccessmap IN (329, 330, 331, 332, 333, 334, 335, 336, 337)
  AND workflowid = 27
  AND itenantid = 19;

DELETE FROM ui.groupdesc
WHERE igroupid IN (2059, 2060, 2061)
  AND itenantid = 19
  AND vcgrouptype = 'WORKFLOW';

DELETE FROM ui.tasklhsmap
WHERE iworkflowid = 27
  AND itenantid = 19;

DELETE FROM ui.workflowmasters
WHERE workflowid = 27
  AND workflowkey = 'YBFRMAMLCases'
  AND itenantid = 19;