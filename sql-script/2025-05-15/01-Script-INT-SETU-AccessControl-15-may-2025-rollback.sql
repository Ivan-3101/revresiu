--GOD users to the following people- Swathi(swathi@dronapay.com), Urvi(urvi@dronapay.com)
UPDATE ui.webusermapping SET
mappingid = '10'::integer WHERE
mappingid = 0 AND mappingtype = 'Role' AND webuserid = (select iuserid from ui.webuser where vcemailid='swathi@dronapay.com' and iorgid=12) AND iorgid = 12 AND itenantid = 27;
---didnt find Urvi(urvi@dronapay.com) in webuser table



--- Risk Analyst access to- Fena(fena@dronapay.com), Shreyasi(shreyasi@dronapay.com)
UPDATE ui.webusermapping SET
mappingid = '0'::integer WHERE
mappingid = 5 AND mappingtype = 'Role' AND webuserid = (select iuserid from ui.webuser where vcemailid='fena@dronapay.com' and iorgid=12) AND iorgid = 12 AND itenantid = 27;

UPDATE ui.webusermapping SET
mappingid = '0'::integer WHERE
mappingid = 5 AND mappingtype = 'Role' AND webuserid = (select iuserid from ui.webuser where vcemailid='shreyasi@dronapay.com' and iorgid=12) AND iorgid = 12 AND itenantid = 27;

-- Risk Admin role to- Sarvesh(sarvesh.c@dronapay.com)
--no such user present