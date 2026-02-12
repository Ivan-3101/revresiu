delete from ui.tasklhsmap where idropdownoptionid = 1 and iworkflowid=16;

insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0, 1,16,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 1, 16, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 1, 16, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 1, 16, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 1, 16, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 1, 16, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');


delete from ui.tasklhsmap where idropdownoptionid = 2 and iworkflowid=16;

insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0, 2,16,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 2, 16, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 2, 16, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 2, 16, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 2, 16, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 2, 16, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');

delete from ui.tasklhsmap where idropdownoptionid = 3 and iworkflowid = 16;

insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0,3,16,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 3, 16, 6, '{"tag":"span", "path":"this.startTime","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 3, 16, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 3, 16, 12, '{"tag":"span","path":"this.name", "type":"default"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 2, 3, 16, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 2, 3, 16, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');

delete from ui.tasklhsmap where idropdownoptionid = 4 and iworkflowid = 16;

insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES 
(0,0,4,16,4,'{"tag":"span", "path":"this.variables.TicketID", "type":"ticketid"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 0, 4, 16, 6, '{"tag":"span", "path":"this.created","type":"timestamp"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(2, 0, 4, 16, 2, '{"tag":"span","path":"this.variables.RiskScore","type":"score"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(0, 1, 4, 16, 4, '{"tag":"span","path":"this.variables.TransactionAmount", "type":"amount", "className":"d-inline pull-left"}');
insert into ui.tasklhsmap(iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig) VALUES
(1, 1, 4, 16, 8, '{"tag":"span","path":"this.variables.WorkflowName", "type":"default", "className":"d-inline pull-right"}');
