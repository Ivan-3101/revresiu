INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid, iorgid, itenantid)
VALUES (19, 'Tenant', 
        (SELECT iuserid FROM ui.webuser WHERE vcemailid = 'madmin@ybfrm.com'), 
        6, 19);

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid, iorgid, itenantid)
VALUES (19, 'Tenant', 
        (SELECT iuserid FROM ui.webuser WHERE vcemailid = 'cadmin@ybfrm.com'), 
        6, 19);