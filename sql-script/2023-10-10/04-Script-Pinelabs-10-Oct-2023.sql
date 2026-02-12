
INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '6'::integer, '1022'::integer, '16'::integer)
 returning panelaccessmap;
 
INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '6'::integer, '1023'::integer, '16'::integer)
 returning panelaccessmap;

INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '6'::integer, '1024'::integer, '16'::integer)
 returning panelaccessmap;


INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'First Trans Date_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'First Trans Date_Payer','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Last Trans Date_Payer','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Last Trans Date_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Total Count_P30_Payer','vpa');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Total Count_P30_Payee','vpa');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Total Value_P30_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Total Value_P30_Payer','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Total Value_PAll_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Total Value_PAll_Payer','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Total Count_Payer','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Total Count_Payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Max Value_P90_Payer','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'Highest_Day_Volume','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'TotalCount_p30d_chargeback_payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'TotalValue_p30d_chargeback_payee','account');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'TotalCount_p30d_chargeback_payer','vpa');
INSERT INTO ui.profileparamsconfig(workflowid, parametername,type) VALUES (16, 'TotalValue_p30d_chargeback_payer','vpa');
