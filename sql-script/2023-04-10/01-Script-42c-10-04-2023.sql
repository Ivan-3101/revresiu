INSERT INTO ui.workflowmasters (
workflowid, workflowname, workflowkey) VALUES (
'13'::integer, 'CUB-Risk Notification'::character varying, 'CUB_RiskNotification'::character varying)
 returning workflowid;

INSERT INTO ui.workflowmasters (
workflowid, workflowkey, workflowname) VALUES (
'14'::integer, 'USFB_RiskNotification'::character varying, 'USFB-Risk Notification'::character varying)
 returning workflowid;

INSERT INTO ui.panelaccessmap (
panelid, groupid, workflowid, panelaccessmap) VALUES (
'5'::integer, '1020'::integer, '14'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap)
) returning panelaccessmap;




 INSERT INTO ui.panelaccessmap (
 panelid, groupid, workflowid, panelaccessmap) VALUES (
 '4'::integer, '1020'::integer, '14'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
  returning panelaccessmap;

  INSERT INTO ui.panelaccessmap (
  panelid, groupid, workflowid, panelaccessmap) VALUES (
  '3'::integer, '1020'::integer, '14'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
   returning panelaccessmap;

   INSERT INTO ui.panelaccessmap (
   panelid, groupid, workflowid, panelaccessmap) VALUES (
   '2'::integer, '1020'::integer, '14'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
    returning panelaccessmap;

    INSERT INTO ui.panelaccessmap (
    panelid, groupid, workflowid, panelaccessmap) VALUES (
    '1'::integer, '1020'::integer, '14'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
     returning panelaccessmap;

     INSERT INTO ui.panelaccessmap (
     panelid, groupid, workflowid, panelaccessmap) VALUES (
     '5'::integer, '1020'::integer, '13'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
      returning panelaccessmap;


      INSERT INTO ui.panelaccessmap (
      panelid, groupid, workflowid, panelaccessmap) VALUES (
      '4'::integer, '1020'::integer, '13'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
       returning panelaccessmap;


       INSERT INTO ui.panelaccessmap (
       panelid, groupid, workflowid, panelaccessmap) VALUES (
       '3'::integer, '1020'::integer, '13'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
        returning panelaccessmap;

        INSERT INTO ui.panelaccessmap (
        panelid, groupid, workflowid, panelaccessmap) VALUES (
        '2'::integer, '1020'::integer, '13'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
         returning panelaccessmap;


         INSERT INTO ui.panelaccessmap (
         panelid, groupid, workflowid, panelaccessmap) VALUES (
         '1'::integer, '1020'::integer, '13'::integer, (SELECT max(panelaccessmap+1) FROM ui.panelaccessmap))
          returning panelaccessmap;


DELETE FROM ui.panelaccessmap
	WHERE workflowid=3;


DELETE FROM camunda.allocationusers
	WHERE workflowid=3;

DELETE FROM ui.workflowmasters
    WHERE workflowid IN
        (3);