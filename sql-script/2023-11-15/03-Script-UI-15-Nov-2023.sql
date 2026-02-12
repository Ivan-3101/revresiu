SELECT iuserauditid, igroupid, count(1)
	FROM ui.usergroupmapaudit group by iuserauditid, igroupid having count(1) > 1;
	
SELECT web_user_audit_iuserauditid, user_permissions_iroleid, count(1)
	FROM ui.userrolemapaudit group by web_user_audit_iuserauditid, user_permissions_iroleid having count(1) > 1;

SELECT iuserid, igroupid, count(1)
	FROM ui.usergroupmap group by iuserid, igroupid having count(1) > 1;

SELECT iuserid, iroleid, count(1)
	FROM ui.userrolemap group by iuserid, iroleid having count(1) > 1;