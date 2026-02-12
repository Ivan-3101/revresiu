UPDATE ui.perspectivequery
	SET  vcquery='SELECT * from ui.gettxnprofileselectedtxn_new(
:party,
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress
)'
	WHERE iperspectivequeryid=25;

UPDATE ui.perspectivequery
	SET  vcquery='SELECT * from ui.gettxnprofileselectedtxnbyclass_new(
:party,
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnClass
)'
	WHERE iperspectivequeryid=26;


DELETE FROM ui.perspectivequeryparameters
	WHERE iperspectiveparameterid=37;

DELETE FROM ui.perspectivequeryparameters
	WHERE iperspectiveparameterid=42;