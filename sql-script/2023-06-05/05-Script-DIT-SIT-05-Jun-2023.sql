update ui.tasklhsmap set valueconfig='{
  "tag": "span",
  "path": "this.startTime",
  "type": "timestamp"
}' where iorder=1 and irow=0 and idropdownoptionid=3;

update ui.tasklhsmap set valueconfig='{
  "tag": "span",
  "path": "this.variables.TransactionAmount",
  "type": "amount"
}' where iorder=1 and irow=1 and idropdownoptionid=4 and iworkflowid=6;