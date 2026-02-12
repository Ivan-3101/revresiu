UPDATE ui.perspectivequery
SET vcquery = 'SELECT * from transactions.getdecisiondetails(:vcMsgID)'
WHERE iperspectivequeryid = 36;