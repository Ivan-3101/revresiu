
UPDATE ui.perspectivequery
	SET  vcquery='SELECT  * from ui.getlivetrans_last_testdb_2(
                 	:party,
                 	:userType,
                 	:timeZone,
                 	:txnClass,
                 	:useraddress,
                 	1000
                 )'
	WHERE iperspectivequeryid=33;


UPDATE ui.perspectivequeryparameters
	SET  vcparametertype='String'
	WHERE iperspectiveparameterid=73;

UPDATE ui.perspectivequeryparameters
	SET  vcparametertype='String'
	WHERE iperspectiveparameterid=74;

UPDATE ui.perspectivequeryparameters
	SET  vcparametertype='String'
	WHERE iperspectiveparameterid=75;
