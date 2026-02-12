
UPDATE ui.perspectivequery SET  vcquery='SELECT * from  ui.getpartydtxnsummarybyclass(
	:party,
	:userType,
	:timeZone,
	:txnClass,
	:useraddress
)'
WHERE iperspectivequeryid=30;