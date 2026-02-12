INSERT INTO ui.profileparamsconfig (
id, workflowid, parametername, type, itenantid) VALUES (
'45'::integer, '16'::integer, 'Total Value_P3_Payee'::character varying, 'account'::character varying, '10'::integer)
 returning id,itenantid;


 INSERT INTO ui.profileparamsconfig (
id, workflowid, parametername, type, itenantid) VALUES (
'46'::integer, '16'::integer, 'Total Value_P7_Payee'::character varying, 'account'::character varying, '10'::integer)
 returning id,itenantid;


 INSERT INTO ui.profileparamsconfig (
id, workflowid, parametername, type, itenantid) VALUES (
'47'::integer, '16'::integer, 'Total Value_P30_Payee'::character varying, 'account'::character varying, '10'::integer)
 returning id,itenantid;
