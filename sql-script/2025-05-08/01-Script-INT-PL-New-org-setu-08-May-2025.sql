DO $$
DECLARE
    -- Your variable containing the value for iorgid
    -- Replace 3 with the actual variable or value
    old_itenantid_value INT = 10;
    itenantid_value INT := 27;
    vctenantname_value VARCHAR := 'Setu';
    vcorgname_value VARCHAR := 'PL_Setu';
    iorg_value INT := 7;
    new_org_id INT := 12;
    madmin_email VARCHAR := 'fena@dronapay.com';
    cadmin_email VARCHAR := 'shreyasi@dronapay.com';
    api_key text ;
    drona_key text :='1234';
    madmin_firstname VARCHAR := 'fena';
    madmin_lastname VARCHAR := 'jain';
    cadmin_firstname VARCHAR := 'shreyasi';
    cadmin_lastname VARCHAR := 'saha';
    madmin_irole_id INT := 0;
    cadmin_irole_id INT := 0;
    api_key_expiry_date VARCHAR := '2025-08-31';
    -- tenant_value : =

BEGIN


    INSERT INTO ui.orgs (iorgid, attribs, dtentrystamp, irecordstatus, vcorgid, config) VALUES
    (new_org_id, '{ "ssoConfig": {"uiserver.sso": false, "drona.ui.scope": "openid", "drona.ui.clientid": "dronauidit", "uiserver.sso.type": "openid", "drona.ui.authorize": "http://localhost:8081/realms/dronaui/protocol/openid-connect/auth", "drona.ui.token.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/token", "drona.ui.logout.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/logout?post_logout_redirect_uri=http://localhost:8085/dronaui/auth/login", "drona.ui.redirect.url": "http://localhost:3001/dronaui/SIT/auth/login", "drona.ui.client.secret": "QDG8Q~~Aryb8W~9VVcsSLqGdH6PQZAGtkBj.VbfV", "spring.security.oauth2.resourceserver.jwt.issuer-uri": "http://localhost:8081/realms/dronaui", "spring.security.oauth2.resourceserver.jwt.jwk-set-uri": "http://localhost:8081/realms/dronaui/protocol/openid-connect/certs", "spring.security.oauth2.resourceserver.jwt.user-name-attribute": "preferred_username"}, "vclogourl": "internal-logo.png", "pismo.processing.enabled": false}', NULL, 0, vcorgname_value, '{}');


    perform setval(pg_get_serial_sequence('ui.tenants', 'itenantid'),
        (SELECT MAX(itenantid) FROM ui.tenants)
    );

    INSERT INTO masters.orgs VALUES (new_org_id, vcorgname_value, '{"ssoConfig": {"uiserver.sso": false, "drona.ui.scope": "openid", "drona.ui.clientid": "dronauidit", "uiserver.sso.type": "openid", "drona.ui.authorize": "http://localhost:8081/realms/dronaui/protocol/openid-connect/auth", "drona.ui.token.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/token", "drona.ui.logout.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/logout?post_logout_redirect_uri=http://localhost:8085/dronaui/auth/login", "drona.ui.redirect.url": "http://localhost:3001/dronaui/SIT/auth/login", "drona.ui.client.secret": "QDG8Q~~Aryb8W~9VVcsSLqGdH6PQZAGtkBj.VbfV", "spring.security.oauth2.resourceserver.jwt.issuer-uri": "http://localhost:8081/realms/dronaui", "spring.security.oauth2.resourceserver.jwt.jwk-set-uri": "http://localhost:8081/realms/dronaui/protocol/openid-connect/certs", "spring.security.oauth2.resourceserver.jwt.user-name-attribute": "preferred_username"}, "vclogourl": "", "pismo.processing.enabled": false}', '{}', 0, CURRENT_TIMESTAMP);



    perform setval(pg_get_serial_sequence('masters.orgs', 'iorgid'),
        (SELECT MAX(iorgid) FROM masters.orgs)
    );

    INSERT INTO ui.tenants VALUES (itenantid_value, NULL, NULL, '{}', 0, vctenantname_value, NULL, NULL, NULL, new_org_id, '{}');

    perform setval(pg_get_serial_sequence('ui.tenants', 'itenantid'),
        (SELECT MAX(itenantid) FROM ui.tenants)
    );

    INSERT INTO masters.tenants VALUES (itenantid_value, new_org_id, vctenantname_value, '{}', '{}', 0, CURRENT_TIMESTAMP);

    perform setval(pg_get_serial_sequence('masters.tenants', 'itenantid'),
        (SELECT MAX(itenantid) FROM masters.tenants)
    );

    CALL masters.partition_for_tenants(new_org_id);

    CALL masters.partition_for_orgs(new_org_id);

SELECT gen_random_uuid()::text into api_key;

-- copy this id and paste it in the api_key_uuid
-- For internal environments, copy this id and maintain it in an xlsx
-- paste the drona.key's value from UIServer properties in encryption_code
-- and make the value in itenantid_value for the tenants
-- And make change in expiry date
UPDATE ui.tenants
SET config = jsonb_set(
    config,
    '{api-keys}',
    jsonb_build_array(
        jsonb_build_object(
            'expiry', api_key_expiry_date,
            'api-key',pgp_sym_encrypt(api_key, drona_key)::text
        )
    ),
    true
) WHERE itenantid = itenantid_value;

-- copy this id and paste it in the api_key_uuid
-- And make change in expiry date
UPDATE masters.tenants
SET config = jsonb_set(
    config,
    '{api-keys}',
    jsonb_build_array(
        jsonb_build_object(
            'expiry', api_key_expiry_date,
            'api-key', encode(digest(api_key, 'sha256'), 'hex')::text

        )
    ),
    true
) WHERE itenantid = itenantid_value;




/* --------------------  ui.validationfieldslist ---------------------------------*/
    perform setval(pg_get_serial_sequence('ui.validationfieldslist', 'ifieldid'),
        (SELECT coalesce(max(ifieldid) , 1) FROM ui.validationfieldslist)
    );

    INSERT INTO ui.validationfieldslist (
        bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
    select bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid_value
        from ui.validationfieldslist where itenantid = old_itenantid_value;




--------webuser addition --------------------------------------------------------

INSERT INTO ui.webuser(
	 dtapproverstamp, dtentrystamp, dtlastlogindate, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcusername,
      iapproveruserid, ientryuserid, istatus, timezones, dtlastpasswordupdate,loginattempts, iorgid)
SELECT CURRENT_TIMESTAMP AS dtapproverstamp,
    CURRENT_TIMESTAMP AS dtentrystamp,
    CURRENT_TIMESTAMP AS dtlastlogindate, madmin_email, madmin_firstname, madmin_lastname, NULL, '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.',
    madmin_email,1,1,1,'Asia/Calcutta', CURRENT_TIMESTAMP AS dtlastpasswordupdate,0,o.iorgid
	FROM ui.orgs o WHERE iorgid !=0 AND iorgid = new_org_id
    UNION ALL
SELECT CURRENT_TIMESTAMP AS dtapproverstamp,
    CURRENT_TIMESTAMP AS dtentrystamp,
    CURRENT_TIMESTAMP AS dtlastlogindate, cadmin_email, cadmin_firstname, cadmin_lastname, NULL, '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.',
    cadmin_email,1,1,1,'Asia/Calcutta', CURRENT_TIMESTAMP AS dtlastpasswordupdate,0,o.iorgid
	FROM ui.orgs o WHERE iorgid !=0 AND iorgid = new_org_id;


/* ------------------------------- Inserting into groupdesc - groups for camunda -------------------------------*/

    INSERT INTO ui.groupdesc(
	    igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid, iorgid)
    SELECT igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid_value ,new_org_id
        FROM ui.groupdesc WHERE itenantid = old_itenantid_value ;

/* ------------------------------- Inserting into roledesc - roles ------------------------------- */

    INSERT INTO ui.roledesc(
        iroleid,dtentrystamp, vcrolename, istatus, itenantid, iorgid)
    SELECT iroleid,dtentrystamp, vcrolename, istatus, itenantid_value, new_org_id
	    FROM ui.roledesc WHERE itenantid = old_itenantid_value;


/* ------------------------------- Inserting into rolemenuaccessmap - ------------------------------- */

    INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
        SELECT irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,  itenantid_value, new_org_id
    FROM ui.rolemenuaccessmap where itenantid = old_itenantid_value ;

    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT -1, 'Workflow', wb.iuserid, new_org_id,itenantid_value
            FROM  ui.webuser wb
        WHERE  wb.iorgid = new_org_id
        and wb.vcusername in (madmin_email, cadmin_email);


    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT -1, 'TransactionClass', wb.iuserid, new_org_id, itenantid_value
        FROM  ui.webuser wb
        WHERE  wb.iorgid = new_org_id
        and wb.vcusername in (madmin_email, cadmin_email);


    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT itenantid_value, 'Tenant', wb.iuserid, new_org_id, itenantid_value
        FROM  ui.webuser wb
        WHERE  wb.iorgid = new_org_id
        and wb.vcusername in (madmin_email, cadmin_email);


    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT madmin_irole_id, 'Role', wb.iuserid, new_org_id, itenantid_value
        FROM  ui.webuser wb
        WHERE  wb.iorgid = new_org_id
        and wb.vcusername in (madmin_email);

  INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT cadmin_irole_id, 'Role', wb.iuserid, new_org_id, itenantid_value
        FROM  ui.webuser wb
        WHERE  wb.iorgid = new_org_id
        and wb.vcusername in (cadmin_email);



    /* ------------------------------- Inserting into dashboard - different dashboards -------------------------------*/

    INSERT INTO ui.dashboard(idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic)
        SELECT idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid_value, bdynamic
        from ui.dashboard WHERE itenantid = old_itenantid_value ;

    /* ------------------------------- Inserting into dashboardqueries - different queries -------------------------------*/

    INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, dbtype, itenantid)
	SELECT idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, dbtype, itenantid_value
        FROM ui.dashboardquery WHERE itenantid = old_itenantid_value ;


    INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, validation, itenantid)
        SELECT idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, validation, itenantid_value
        FROM ui.dashboardqueryparameters WHERE itenantid = old_itenantid_value;

    INSERT INTO ui.dashboardresultset(idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid)
        SELECT idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid_value, new_org_id
        FROM ui.dashboardresultset WHERE itenantid = old_itenantid_value;


        INSERT INTO ui.sectionparameters(isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid, itenantid)
        SELECT isectionid, bactive, bdelete, vcparamname, vcsectionname, idashboardqueryid, itenantid_value
        FROM ui.sectionparameters WHERE itenantid = old_itenantid_value;

        INSERT INTO ui.dashboardfilters(idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname, validation)
        SELECT idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid_value, vcdashboardfilterdisplayname, validation
        FROM ui.dashboardfilters WHERE itenantid = old_itenantid_value ;

        INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid, attribs)
        select attribpath, level, datatype, displayname, itenantid_value, attribs
        FROM ui.masterextractattribs where itenantid = old_itenantid_value ;


        INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey, manual_display_name, is_manual_creation, is_filter_display, manual_attribs, idecisionid, itenantid, manualworkflowid, filterparams, displayconfig, isautoclose, autocloseconfig)
        select workflowid, workflowname, workflowkey, manual_display_name, is_manual_creation, is_filter_display, manual_attribs, idecisionid, itenantid_value, manualworkflowid, filterparams, displayconfig, isautoclose, autocloseconfig
        from ui.workflowmasters where itenantid = old_itenantid_value;


        INSERT INTO ui.tasklhsmap (iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid)
        select iorder, irow, idropdownoptionid, iworkflowid, icolumn, valueconfig, itenantid_value
        from ui.tasklhsmap where itenantid = old_itenantid_value;


        INSERT INTO ui.emailtemplate(id, body, subject, associateid, response, camunda_message_name, itenantid)
        select id, body, subject, associateid, response, camunda_message_name, itenantid_value
        from ui.emailtemplate where itenantid =  old_itenantid_value;


        INSERT INTO ui.listmaster(ilistmasterid,ifordays, vcname, iconfigjson, itenantid)
        select ilistmasterid,ifordays, vcname, iconfigjson, itenantid_value
        from ui.listmaster where itenantid = old_itenantid_value;

        perform setval(pg_get_serial_sequence('ui.grouptotaskfiltermap', 'igrouptotaskfilterid'),
        (SELECT coalesce(max(igrouptotaskfilterid) , 1) FROM ui.grouptotaskfiltermap)
        );

        INSERT INTO ui.grouptotaskfiltermap ( iposition, igroupid, itaskfilterid, itenantid)
        select iposition, igroupid, itaskfilterid, itenantid_value
        from ui.grouptotaskfiltermap where itenantid = old_itenantid_value;

        INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid, itenantid)
        select panelaccessmap, panelid, groupid, workflowid, itenantid_value
        from ui.panelaccessmap where itenantid = old_itenantid_value;

        INSERT INTO camunda.act_id_tenant (id_, rev_, name_)
        SELECT cast(itenantid as VARCHAR), 1, vctenantid from ui.tenants WHERE iorgid = new_org_id and itenantid = itenantid_value ;

        INSERT INTO camunda.act_id_tenant_member(id_, tenant_id_, user_id_)
        SELECT ENCODE(gen_random_bytes(32), 'hex'), wbm.itenantid::varchar, wbm.webuserid::varchar
	    FROM ui.webusermapping wbm
	    join camunda.act_id_user aiu on aiu.id_ = wbm.webuserid::varchar
	    where mappingtype='Tenant' and aiu.email_ in (cadmin_email, madmin_email) and  wbm.itenantid = itenantid_value ;

        INSERT INTO ui.webusermapping(mappingid,mappingtype, webuserid, iorgid, itenantid)
        SELECT DISTINCT wb.igroupid,'Group',wb1.iuserid,new_org_id,itenantid_value
        FROM  ui.groupdesc wb, ui.webuser wb1
        WHERE wb.itenantid =itenantid_value AND wb1.iorgid = new_org_id and wb1.vcusername in (cadmin_email, madmin_email);


        EXECUTE format(
        'CREATE TABLE analytics.trans_%s PARTITION OF analytics.trans
         FOR VALUES IN (%s)
         PARTITION BY RANGE (dttrxntime)',
        itenantid_value, itenantid_value
        );


        CALL masters.add_monthly_partitions_to_trans(
            (CONCAT(TO_CHAR(DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month'), 'YYYY'), LPAD(TO_CHAR(DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month'), 'MM'), 2, '0'))),
            ((DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month'))::date),
            ((DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 day')::date)
        );

        CALL masters.add_monthly_partitions_to_trans(
            (CONCAT(TO_CHAR(CURRENT_DATE, 'YYYY'), LPAD(TO_CHAR(CURRENT_DATE, 'MM'), 2, '0'))),
            (DATE_TRUNC('month', CURRENT_DATE)::date),
            ((DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month')::date)
        );


        CALL masters.add_monthly_partitions_to_trans(
            (CONCAT(TO_CHAR(DATE_TRUNC('month', CURRENT_DATE + INTERVAL '1 month'), 'YYYY'), LPAD(TO_CHAR(DATE_TRUNC('month', CURRENT_DATE + INTERVAL '1 month'), 'MM'), 2, '0'))),
            ((DATE_TRUNC('month', CURRENT_DATE)+ INTERVAL '1 month')::date),
            ((DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '2 month')::date)
        );


END $$;