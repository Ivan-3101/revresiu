DO $$
DECLARE
    -- Your variable containing the value for iorgid
    -- Replace 3 with the actual variable or value
    old_itenantid_value INT = 19;
    itenantid_value INT := 29;
    vctenantname_value VARCHAR := 'BCBO';
    iorg_value INT := 6;
    madmin_email VARCHAR := 'madmin@ybfrm.com';
    cadmin_email VARCHAR := 'cadmin@ybfrm.com';
    api_key text ;
    drona_key text :='1234';
    api_key_expiry_date VARCHAR := '2026-02-28';
    -- tenant_value : =

BEGIN

    INSERT INTO ui.tenants VALUES (itenantid_value, NULL, NULL, '{}', 0, vctenantname_value, NULL, NULL, NULL, iorg_value, '{}');

    perform setval(pg_get_serial_sequence('ui.tenants', 'itenantid'),
        (SELECT MAX(itenantid) FROM ui.tenants)
    );

    INSERT INTO masters.tenants VALUES (itenantid_value, iorg_value, vctenantname_value, '{}', '{}', 0, CURRENT_TIMESTAMP);

    perform setval(pg_get_serial_sequence('masters.tenants', 'itenantid'),
        (SELECT MAX(itenantid) FROM masters.tenants)
    );

    CALL masters.partition_for_tenants(iorg_value);

    CALL masters.partition_for_orgs(iorg_value);

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

/* ------------------------------- Inserting into groupdesc - groups for camunda -------------------------------*/

    INSERT INTO ui.groupdesc(
	    igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid, iorgid)
    SELECT igroupid, dtapproverstamp, dtentrystamp,  regexp_replace(vcgroupid, '_[0-9]+$', '_' || itenantid_value) AS vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus, itenantid_value ,iorgid
        FROM ui.groupdesc WHERE itenantid = old_itenantid_value ;

/* ------------------------------- Inserting into roledesc - roles ------------------------------- */

    INSERT INTO ui.roledesc(
        iroleid,dtentrystamp, vcrolename, istatus, itenantid, iorgid)
    SELECT iroleid,dtentrystamp, vcrolename, istatus, itenantid_value, iorgid
	    FROM ui.roledesc WHERE itenantid = old_itenantid_value;


/* ------------------------------- Inserting into rolemenuaccessmap - ------------------------------- */

    INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid, itenantid, iorgid)
        SELECT irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid,  itenantid_value, iorgid
    FROM ui.rolemenuaccessmap where itenantid = old_itenantid_value ;

    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT -1, 'Workflow', wb.iuserid,wb.iorgid,itenantid_value
            FROM  ui.webuser wb
        WHERE  wb.iorgid = iorg_value
        and wb.vcusername in (madmin_email, cadmin_email);


    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT -1, 'TransactionClass', wb.iuserid, wb.iorgid, itenantid_value
        FROM  ui.webuser wb
        WHERE  wb.iorgid = iorg_value
        and wb.vcusername in (madmin_email, cadmin_email);


    INSERT INTO ui.webusermapping(
	    mappingid, mappingtype, webuserid, iorgid, itenantid)
        SELECT itenantid_value, 'Tenant', wb.iuserid, wb.iorgid, itenantid_value
        FROM  ui.webuser wb
        WHERE  wb.iorgid = iorg_value
        and wb.vcusername in (madmin_email, cadmin_email);

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

    INSERT INTO ui.dashboardresultset(idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, itenantid, iorgid)
        SELECT idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, itenantid_value, iorgid
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

        INSERT INTO ui.webusermapping(mappingid,mappingtype, webuserid, iorgid, itenantid)
        SELECT DISTINCT wb.igroupid,'Group',wb1.iuserid,iorg_value,itenantid_value
        FROM  ui.groupdesc wb, ui.webuser wb1
        WHERE wb.itenantid =itenantid_value AND wb1.iorgid = iorg_value and wb1.vcusername in (cadmin_email, madmin_email);

        INSERT INTO camunda.act_id_group (id_, rev_, name_, type_)
        SELECT vcgroupid, 1, vcgroupname, 'WORKFLOW' from ui.groupdesc where itenantid = itenantid_value
        and vcgroupid not in (select id_ from camunda.act_id_group);

        INSERT INTO camunda.act_ru_authorization(id_, rev_, type_, group_id_, resource_type_, resource_id_, perms_)
        SELECT ENCODE(gen_random_bytes(32), 'hex'), 1, 1, vcgroupid, 2, vcgroupid, 2
	    from ui.groupdesc where itenantid = itenantid_value
        and vcgroupid not in (select distinct group_id_ from camunda.act_ru_authorization where group_id_ IS NOT NULL);

        INSERT INTO camunda.act_id_tenant (id_, rev_, name_)
        SELECT cast(itenantid as VARCHAR), 1, vctenantid from ui.tenants WHERE iorgid = iorg_value and itenantid = itenantid_value ;

        INSERT INTO camunda.act_id_tenant_member(id_, tenant_id_, user_id_)
        SELECT ENCODE(gen_random_bytes(32), 'hex'), wbm.itenantid::varchar, wbm.webuserid::varchar
	    FROM ui.webusermapping wbm
	    join camunda.act_id_user aiu on aiu.id_ = wbm.webuserid::varchar
	    where mappingtype='Tenant' and aiu.email_ in (cadmin_email, madmin_email) and  wbm.itenantid = itenantid_value ;


        INSERT INTO camunda.act_id_membership(user_id_, group_id_)
        select wbm.webuserid::varchar, gd.vcgroupid
	    FROM ui.webusermapping wbm
		join ui.groupdesc gd on gd.igroupid = wbm.mappingid and gd.itenantid= wbm.itenantid
	    join camunda.act_id_user aiu on aiu.id_ = wbm.webuserid::varchar
	    where mappingtype='Group' and aiu.email_ in (cadmin_email, madmin_email) and  wbm.itenantid = itenantid_value  on conflict do nothing;

        call masters.add_weekly_partitions_to_trans();

END $$;