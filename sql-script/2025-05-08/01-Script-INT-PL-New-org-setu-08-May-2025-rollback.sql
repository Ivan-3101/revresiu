DO $$
DECLARE
    itenantid_value INT := 27;
    new_org_id INT := 12;
BEGIN
    -- Start with the most deeply nested dependencies

    -- 1. First delete grouptotaskfiltermap entries
    DELETE FROM ui.grouptotaskfiltermap
    WHERE itenantid = itenantid_value AND igroupid IN (
        SELECT igroupid FROM ui.groupdesc WHERE itenantid = itenantid_value
    );

    -- 2. Delete web user mapping audit records
    DELETE FROM ui.webusermappingaudit
    WHERE iorgid = new_org_id;

    -- 3. Delete web user audit records
    DELETE FROM ui.webuseraudit
    WHERE iorgid = new_org_id;

    -- 4. Delete activity logs for these users
    DELETE FROM ui.activitylog
    WHERE iorgid = new_org_id;

    -- 5. Delete from analytics transaction partitions
    EXECUTE format('DROP TABLE IF EXISTS analytics.trans_%s CASCADE', itenantid_value);

    -- 6. Delete from camunda tables
    DELETE FROM camunda.act_id_tenant_member WHERE tenant_id_ = itenantid_value::varchar;
    DELETE FROM camunda.act_id_tenant WHERE id_ = itenantid_value::varchar;

    -- 7. Delete ALL web user mappings for this org
    DELETE FROM ui.webusermapping WHERE iorgid = new_org_id;

    -- 8. Delete dashboard related data
    DELETE FROM ui.dashboardfilters WHERE itenantid = itenantid_value;
    DELETE FROM ui.sectionparameters WHERE itenantid = itenantid_value;
    DELETE FROM ui.dashboardresultset WHERE itenantid = itenantid_value AND iorgid = new_org_id;
    DELETE FROM ui.dashboardqueryparameters WHERE itenantid = itenantid_value;
    DELETE FROM ui.dashboardquery WHERE itenantid = itenantid_value;
    DELETE FROM ui.dashboard WHERE itenantid = itenantid_value;

    -- 9. Delete workflow and task related data
    DELETE FROM ui.panelaccessmap WHERE itenantid = itenantid_value;
    DELETE FROM ui.listmaster WHERE itenantid = itenantid_value;
    DELETE FROM ui.emailtemplate WHERE itenantid = itenantid_value;
    DELETE FROM ui.tasklhsmap WHERE itenantid = itenantid_value;
    DELETE FROM ui.workflowmasters WHERE itenantid = itenantid_value;
    DELETE FROM ui.masterextractattribs WHERE itenantid = itenantid_value;

    -- 10. Delete role menu access mappings
    DELETE FROM ui.rolemenuaccessmap WHERE  itenantid = itenantid_value;

    -- 11. Delete roles and groups (must come after grouptotaskfiltermap)
    DELETE FROM ui.roledesc WHERE  itenantid = itenantid_value;
    DELETE FROM ui.groupdesc WHERE  itenantid = itenantid_value;

    -- 12. Delete validation fields
    DELETE FROM ui.validationfieldslist WHERE itenantid = itenantid_value;

    -- 13. Now delete ALL web users for this org
    DELETE FROM ui.webuser WHERE iorgid = new_org_id;

    -- 14. Delete tenants
    DELETE FROM masters.tenants WHERE itenantid = itenantid_value;
    DELETE FROM ui.tenants WHERE itenantid = itenantid_value;

    -- 15. Finally delete orgs (after all dependent records are removed)
    DELETE FROM ui.orgs WHERE iorgid = new_org_id;
    DELETE FROM masters.orgs WHERE iorgid = new_org_id;

    -- 16. Reset sequences
    PERFORM setval(pg_get_serial_sequence('ui.tenants', 'itenantid'),
        (SELECT COALESCE(MAX(itenantid), 1) FROM ui.tenants));

    PERFORM setval(pg_get_serial_sequence('masters.tenants', 'itenantid'),
        (SELECT COALESCE(MAX(itenantid), 1) FROM masters.tenants));

    PERFORM setval(pg_get_serial_sequence('masters.orgs', 'iorgid'),
        (SELECT COALESCE(MAX(iorgid), 1) FROM masters.orgs));

    PERFORM setval(pg_get_serial_sequence('ui.orgs', 'iorgid'),
        (SELECT COALESCE(MAX(iorgid), 1) FROM ui.orgs));

    RAISE NOTICE 'Rollback completed successfully for tenant % and org %', itenantid_value, new_org_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Rollback failed at step: %. Error: %',
            CASE
                WHEN SQLERRM LIKE '%grouptotaskfiltermap%' THEN 'grouptotaskfiltermap deletion'
                WHEN SQLERRM LIKE '%webusermappingaudit%' THEN 'webusermappingaudit deletion'
                WHEN SQLERRM LIKE '%webuseraudit%' THEN 'webuseraudit deletion'
                WHEN SQLERRM LIKE '%activitylog%' THEN 'activitylog deletion'
                WHEN SQLERRM LIKE '%webuser%' THEN 'webuser deletion'
                WHEN SQLERRM LIKE '%orgs%' THEN 'orgs deletion'
                ELSE 'unknown step: ' || SQLERRM
            END,
            SQLERRM;
END $$;