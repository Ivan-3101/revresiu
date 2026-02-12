DO $$ 
DECLARE
    -- Your variable containing the value for iorgid
    -- Replace t with the actual variable or value of irorgid and madmin and cadmin email as well
     iorgid_value INT := :iorgid_value;
    cgod_email VARCHAR := ':cgod_email';
    mgod_email VARCHAR := ':mgod_email';
    mgod_firstname VARCHAR := ':mgod_firstname';
    mgod_lastname VARCHAR := ':mgod_lastname';
    cgod_firstname VARCHAR := ':cgod_firstname';
    cgod_lastname VARCHAR := ':cgod_lastname';
    check_value_exists BOOLEAN;

BEGIN

INSERT INTO ui.webuser(
	  dtapproverstamp, dtentrystamp, dtlastlogindate, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcusername,
      iapproveruserid, ientryuserid, istatus, timezones, dtlastpasswordupdate,loginattempts, iorgid)
SELECT  CURRENT_TIMESTAMP AS dtapproverstamp,
    CURRENT_TIMESTAMP AS dtentrystamp,
    CURRENT_TIMESTAMP AS dtlastlogindate, cgod_email, cgod_firstname, cgod_lastname, NULL, '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.',
    cgod_email,1,1,1,'Asia/Calcutta', CURRENT_TIMESTAMP AS dtlastpasswordupdate,0,o.iorgid
	FROM ui.orgs o WHERE iorgid !=0 AND iorgid = iorgid_value
    UNION ALL
SELECT CURRENT_TIMESTAMP AS dtapproverstamp,
    CURRENT_TIMESTAMP AS dtentrystamp,
    CURRENT_TIMESTAMP AS dtlastlogindate,  mgod_email, mgod_firstname, mgod_lastname, NULL, '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.',
     mgod_email,1,1,1,'Asia/Calcutta', CURRENT_TIMESTAMP AS dtlastpasswordupdate,0,o.iorgid
	FROM ui.orgs o WHERE iorgid !=0 AND iorgid = iorgid_value;

INSERT INTO ui.roledesc(
	  iroleid,dtentrystamp, vcrolename, istatus, itenantid, iorgid)
SELECT 0,CURRENT_TIMESTAMP AS dtapproverstamp, 'Drona God', 1, t.itenantid, t.iorgid
	FROM ui.tenants t WHERE itenantid != 0 AND iorgid = iorgid_value;

INSERT INTO ui.webusermapping (
    mappingid, mappingtype, webuserid, iorgid, itenantid)
SELECT 
   1, 'Group'::character varying, wu.iuserid, t.iorgid, t.itenantid
FROM ui.tenants t
JOIN ui.webuser wu 
    ON wu.vcemailid IN ( mgod_email, cgod_email) 
    and wu.iorgid=iorgid_value
WHERE t.itenantid != 0 AND t.iorgid = iorgid_value;

INSERT INTO ui.webusermapping (
    mappingid, mappingtype, webuserid, iorgid, itenantid)
SELECT 
    t.itenantid, 'Tenant'::character varying, wu.iuserid, t.iorgid, t.itenantid
FROM ui.tenants t
JOIN ui.webuser wu 
    ON wu.vcemailid IN ( mgod_email, cgod_email)
        and wu.iorgid=iorgid_value
WHERE t.itenantid != 0 AND t.iorgid = iorgid_value;

INSERT INTO ui.webusermapping (
    mappingid, mappingtype, webuserid, iorgid, itenantid)
SELECT 
    0, 'Role'::character varying, wu.iuserid, t.iorgid, t.itenantid
FROM ui.tenants t
JOIN ui.webuser wu 
    ON wu.vcemailid IN ( mgod_email, cgod_email)
        and wu.iorgid=iorgid_value
WHERE t.itenantid != 0 AND t.iorgid = iorgid_value 
 AND t.itenantid in (SELECT itenantid from ui.tenants where iorgid = iorgid_value  order by itenantid limit 1)
;


--Camunda


--insert cgod user entries
INSERT INTO camunda.act_id_user (id_, rev_, first_, last_, email_, pwd_, salt_) VALUES(
(SELECT wb.iuserid::varchar from ui.webuser wb where vcemailid = cgod_email and iorgid = iorgid_value),  1, cgod_firstname, cgod_lastname, cgod_email, '{SHA-512}Hv0v7GCpl0i43FmTGn+IJ6V8nFUvh3RNQXQ4LDomrlCeFuVPxcxbstRUgmamaWSTQFtQ6V0rS+2K0CaauNmTCA==', 
'YxsoNMYlWRfYnoxWi0zG3Q==');

--for user auth
INSERT INTO camunda.act_ru_authorization(id_, rev_, type_, user_id_, resource_type_, resource_id_, perms_)
  VALUES (ENCODE(gen_random_bytes(32), 'hex'), 1, 1, (SELECT wb.iuserid::varchar from ui.webuser wb where vcemailid = cgod_email and iorgid = iorgid_value), 1, '*',  2147483647);

--map to usermgmt group
INSERT INTO camunda.act_id_membership(user_id_, group_id_) VALUES ((SELECT wb.iuserid::varchar from ui.webuser wb where vcemailid = cgod_email and iorgid = iorgid_value), 'usermgmt');

--map to all tenants in the organization
   INSERT INTO camunda.act_id_tenant_member(id_, tenant_id_, user_id_) 
   SELECT ENCODE(gen_random_bytes(32), 'hex'), cast(itenantid as VARCHAR), (SELECT wb.iuserid::varchar from ui.webuser wb where vcemailid = cgod_email and iorgid = iorgid_value) FROM ui.tenants WHERE iorgid = iorgid_value;

--insert mgod user entries
INSERT INTO camunda.act_id_user (id_, rev_, first_, last_, email_, pwd_, salt_) VALUES(
(SELECT wb.iuserid::varchar from ui.webuser wb where vcemailid =  mgod_email and iorgid = iorgid_value),  1, mgod_firstname, mgod_lastname,  mgod_email, '{SHA-512}Hv0v7GCpl0i43FmTGn+IJ6V8nFUvh3RNQXQ4LDomrlCeFuVPxcxbstRUgmamaWSTQFtQ6V0rS+2K0CaauNmTCA==', 
'YxsoNMYlWRfYnoxWi0zG3Q==');

--for user auth
INSERT INTO camunda.act_ru_authorization(id_, rev_, type_, user_id_, resource_type_, resource_id_, perms_)
  VALUES (ENCODE(gen_random_bytes(32), 'hex'), 1, 1, (SELECT wb.iuserid::varchar from ui.webuser wb where vcemailid =  mgod_email and iorgid = iorgid_value), 1, '*',  2147483647);

--map to usermgmt group
INSERT INTO camunda.act_id_membership(user_id_, group_id_) VALUES ((SELECT wb.iuserid::varchar from ui.webuser wb where vcemailid =  mgod_email and iorgid = iorgid_value), 'usermgmt');

--map to all tenants in the organization
   INSERT INTO camunda.act_id_tenant_member(id_, tenant_id_, user_id_) 
   SELECT ENCODE(gen_random_bytes(32), 'hex'), cast(itenantid as VARCHAR), (SELECT wb.iuserid::varchar from ui.webuser wb where vcemailid =  mgod_email and iorgid = iorgid_value) FROM ui.tenants WHERE iorgid = iorgid_value;
   
END $$;