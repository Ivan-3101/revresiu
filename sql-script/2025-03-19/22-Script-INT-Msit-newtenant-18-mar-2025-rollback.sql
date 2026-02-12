DO $$
DECLARE
    itenantid_to_delete INT := 1001;
    iorg_value INT := 1;
BEGIN
    -- Delete from all tables in reverse order of creation
    DELETE FROM camunda.act_id_tenant_member WHERE tenant_id_ = itenantid_to_delete::varchar;
    DELETE FROM camunda.act_id_tenant WHERE id_ = itenantid_to_delete::varchar;
    
    DELETE FROM ui.panelaccessmap WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.grouptotaskfiltermap WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.listmaster WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.emailtemplate WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.tasklhsmap WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.workflowmasters WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.masterextractattribs WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.dashboardfilters WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.sectionparameters WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.dashboardresultset WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.dashboardqueryparameters WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.dashboardquery WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.dashboard WHERE itenantid = itenantid_to_delete;
    
    DELETE FROM ui.webusermapping WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.rolemenuaccessmap WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.roledesc WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.groupdesc WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.validationfieldslist WHERE itenantid = itenantid_to_delete;
    
    -- Delete from core tenant tables
    DELETE FROM masters.tenants WHERE itenantid = itenantid_to_delete;
    DELETE FROM ui.tenants WHERE itenantid = itenantid_to_delete;
    
    -- Reset sequences if needed
    PERFORM setval(pg_get_serial_sequence('ui.tenants', 'itenantid'), 
        (SELECT MAX(itenantid) FROM ui.tenants));
    
    PERFORM setval(pg_get_serial_sequence('masters.tenants', 'itenantid'), 
        (SELECT MAX(itenantid) FROM masters.tenants));
    
    -- Drop any tenant-specific partitions that were created
    -- Note: This part is more complex as it requires dynamic SQL to drop partitions
    -- You may need to customize based on your actual partition naming scheme
    
    RAISE NOTICE 'Successfully deleted all data for tenant %', itenantid_to_delete;
END $$;