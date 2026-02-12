INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus) VALUES (
'1'::integer, 'adduser'::character varying, 'Add User'::character varying, 'INTERNAL'::character varying, '1'::integer)
 returning igroupid;

UPDATE ui.rolemenuaccessmap SET  bapprove=false WHERE iroleid = 5 and bview = false and imenuid = 482;