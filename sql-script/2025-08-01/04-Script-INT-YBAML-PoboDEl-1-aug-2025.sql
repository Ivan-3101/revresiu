-- Analytics
DO $$
DECLARE
    tenant_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM analytics.trans WHERE itenantid = 16 LIMIT 1
    ) INTO tenant_exists;
    IF tenant_exists THEN
        RAISE NOTICE 'Deleting from batchdecisiondetails';
        DELETE FROM analytics.batchdecisiondetails WHERE itenantid = 16;
        RAISE NOTICE 'Deleting from batch_rule_triggered';
        DELETE FROM analytics.batch_rule_triggered WHERE itenantid = 16;
        RAISE NOTICE 'Deleting from rule_triggered';
        DELETE FROM analytics.rule_triggered WHERE itenantid = 16;
        RAISE NOTICE 'Deleting from rule_performance';
        DELETE FROM analytics.rule_performance WHERE itenantid = 16;
        RAISE NOTICE 'Deleting from batchtrans';
        DELETE FROM analytics.batchtrans WHERE itenantid = 16;
        RAISE NOTICE 'Deleting from scorerequests';
        DELETE FROM analytics.scorerequests WHERE itenantid = 16;
        RAISE NOTICE 'Deleting from arb_requests';
        DELETE FROM analytics.arb_requests WHERE itenantid = 16;
        RAISE NOTICE 'Deleting from trans';
        DELETE FROM analytics.trans WHERE itenantid = 16;
        RAISE NOTICE 'Deleting from decisiondetails';
        DELETE FROM analytics.decisiondetails WHERE itenantid = 16;
        RAISE NOTICE 'Tenant 16 deleted successfully from analytics schema.';
    ELSE
        RAISE NOTICE 'No records found for tenant ID 16 in analytics schema.';
    END IF;
END $$;

-- Batch
DO $$
DECLARE
    tenant_id CONSTANT INT := 16;
BEGIN
    IF EXISTS (SELECT 1 FROM batch.batch_job WHERE itenantid = tenant_id LIMIT 1) THEN
        RAISE NOTICE 'Deleting from batch.batch_job where itenantid = %', tenant_id;
        DELETE FROM batch.batch_job WHERE itenantid = tenant_id;
    ELSE
        RAISE NOTICE 'No records found in batch.batch_job for tenant ID %', tenant_id;
    END IF;
    RAISE NOTICE 'Tenant ID % deleted successfully from batch schema.', tenant_id;
END $$;

-- Camunda (Updated: Corrected Order to Avoid FK Constraints)
-- Camunda (Corrected Order)
DO $$
DECLARE
    tenant_id CONSTANT TEXT := '16'; 
BEGIN
    RAISE NOTICE 'Starting deletion for tenant %', tenant_id;

    -- Step 1: Delete identity links referencing tasks
    DELETE FROM camunda.act_ru_identitylink WHERE task_id_ IN (
        SELECT id_ FROM camunda.act_ru_task WHERE proc_inst_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
        )
    );

    -- Step 2: Delete comments and attachments referencing tasks
    DELETE FROM camunda.act_hi_comment WHERE task_id_ IN (
        SELECT id_ FROM camunda.act_ru_task WHERE proc_inst_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
        )
    );
    DELETE FROM camunda.act_hi_attachment WHERE task_id_ IN (
        SELECT id_ FROM camunda.act_ru_task WHERE proc_inst_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
        )
    );

    -- Step 3: Delete incidents related to tasks
    DELETE FROM camunda.act_ru_incident WHERE execution_id_ IN (
        SELECT id_ FROM camunda.act_ru_execution WHERE proc_inst_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
        )
    );

    -- Step 4: Delete jobs
    DELETE FROM camunda.act_ru_job WHERE process_instance_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 5: Delete job logs
    DELETE FROM camunda.act_hi_job_log WHERE job_id_ IN (
        SELECT id_ FROM camunda.act_ru_job WHERE process_instance_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
        )
    );

    -- Step 6: Delete external task logs
    DELETE FROM camunda.act_hi_ext_task_log WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 7: Delete operation logs
    DELETE FROM camunda.act_hi_op_log WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 8: Delete history incidents
    DELETE FROM camunda.act_hi_incident WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 9: Delete ext tasks
    DELETE FROM camunda.act_ru_ext_task WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 10: Delete variables
    DELETE FROM camunda.act_ru_variable WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 11: Delete tasks FIRST before executions
    DELETE FROM camunda.act_ru_task WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 12: Now it's safe to delete executions
    DELETE FROM camunda.act_ru_execution WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 13: Delete other runtime entities
    DELETE FROM camunda.act_ru_batch WHERE tenant_id_ = tenant_id;
    DELETE FROM camunda.act_ru_incident WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 14: Delete history details
    DELETE FROM camunda.act_hi_actinst WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );
    DELETE FROM camunda.act_hi_detail WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );
    DELETE FROM camunda.act_hi_varinst WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );
    DELETE FROM camunda.act_hi_taskinst WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id
    );

    -- Step 15: Delete case instances
    DELETE FROM camunda.act_hi_caseactinst WHERE case_inst_id_ IN (
        SELECT id_ FROM camunda.act_hi_caseinst WHERE tenant_id_ = tenant_id
    );
    DELETE FROM camunda.act_hi_caseinst WHERE tenant_id_ = tenant_id;

    -- Step 16: Delete high-level process instances
    DELETE FROM camunda.act_hi_procinst WHERE tenant_id_ = tenant_id;

    -- Step 17: Delete definition-level data
    DELETE FROM camunda.act_hi_decinst WHERE dec_def_key_ IN (
        SELECT key_ FROM camunda.act_re_decision_def WHERE tenant_id_ = tenant_id
    );
    DELETE FROM camunda.act_re_decision_def WHERE tenant_id_ = tenant_id;
    DELETE FROM camunda.act_re_procdef WHERE tenant_id_ = tenant_id;
    DELETE FROM camunda.act_re_case_def WHERE tenant_id_ = tenant_id;
    DELETE FROM camunda.act_re_camformdef WHERE tenant_id_ = tenant_id;

    -- Step 18: Delete deployment and byte array data
    DELETE FROM camunda.act_re_deployment WHERE id_ IN (
        SELECT deployment_id_ FROM camunda.act_ge_bytearray WHERE tenant_id_ = tenant_id
    );
    DELETE FROM camunda.act_ge_bytearray WHERE tenant_id_ = tenant_id;

    -- Step 19: Remove tenant from identity links
    DELETE FROM camunda.act_ru_identitylink WHERE user_id_ IN (
        SELECT id_ FROM camunda.act_id_user WHERE tenant_id_ = tenant_id
    );

    RAISE NOTICE 'Tenant % deleted successfully from Camunda.', tenant_id;
END $$;

-- Masters
DO $$
DECLARE
    tenant_id CONSTANT INT := 16;
BEGIN
    IF EXISTS (
        SELECT 1 FROM masters.tenants WHERE itenantid = tenant_id LIMIT 1
    ) THEN
        RAISE NOTICE 'Deleting tenant % from masters schema...', tenant_id;
        DELETE FROM masters.updlog WHERE itenantid = tenant_id;
        DELETE FROM masters.verifiedaddresses WHERE itenantid = tenant_id;
        DELETE FROM masters.mcclimits WHERE itenantid = tenant_id;
        DELETE FROM masters.lists WHERE itenantid = tenant_id;
        DELETE FROM masters.observationwindows WHERE itenantid = tenant_id;
        DELETE FROM masters.observations WHERE itenantid = tenant_id;
        DELETE FROM masters.rulesdraft WHERE itenantid = tenant_id;
        DELETE FROM masters.rules WHERE itenantid = tenant_id;
        DELETE FROM masters.customers WHERE itenantid = tenant_id;
        DELETE FROM masters.accounts WHERE itenantid = tenant_id;
        DELETE FROM masters.vpa WHERE itenantid = tenant_id;
        DELETE FROM masters.transactionclasses WHERE itenantid = tenant_id;
        DELETE FROM masters.decisions WHERE itenantid = tenant_id;
        DELETE FROM masters.holidaycalender WHERE itenantid = tenant_id;
        DELETE FROM masters.tenants WHERE itenantid = tenant_id;
        RAISE NOTICE 'Tenant % deleted successfully from masters schema.', tenant_id;
    ELSE
        RAISE NOTICE 'Tenant % not found in masters.tenants.', tenant_id;
    END IF;
END $$;

-- Profiles
DO $$
DECLARE
    tenant_id CONSTANT INT := 16;
BEGIN
    IF EXISTS (
        SELECT 1 FROM profiles.metadata WHERE itenantid = tenant_id LIMIT 1
    ) OR EXISTS (
        SELECT 1 FROM profiles.account_monthly WHERE itenantid = tenant_id LIMIT 1
    ) OR EXISTS (
        SELECT 1 FROM profiles.vpa_monthly WHERE itenantid = tenant_id LIMIT 1
    ) THEN
        RAISE NOTICE 'Deleting from profiles schema for tenant %', tenant_id;
        DELETE FROM profiles.metadata WHERE itenantid = tenant_id;
        DELETE FROM profiles.account_monthly WHERE itenantid = tenant_id;
        DELETE FROM profiles.account_weekly WHERE itenantid = tenant_id;
        DELETE FROM profiles.vpa_monthly WHERE itenantid = tenant_id;
        DELETE FROM profiles.vpa_weekly WHERE itenantid = tenant_id;
        DELETE FROM profiles.mcc WHERE itenantid = tenant_id;
        RAISE NOTICE 'Tenant % deleted successfully from profiles schema.', tenant_id;
    ELSE
        RAISE NOTICE 'No records found for tenant % in profiles schema.', tenant_id;
    END IF;
END $$;

-- Sim
DO $$
DECLARE
    tenant_id CONSTANT INT := 16;
BEGIN
    IF EXISTS (SELECT 1 FROM sim.simulations WHERE itenantid = tenant_id LIMIT 1) THEN
        RAISE NOTICE 'Deleting tenant % from sim schema...', tenant_id;
        DELETE FROM sim.results WHERE runid IN (
            SELECT runid FROM sim.runs WHERE simid IN (
                SELECT simid FROM sim.simulations WHERE itenantid = tenant_id
            )
        );
        DELETE FROM sim.runs WHERE simid IN (
            SELECT simid FROM sim.simulations WHERE itenantid = tenant_id
        );
        DELETE FROM sim.simulations WHERE itenantid = tenant_id;
        RAISE NOTICE 'Tenant % deleted successfully from sim schema.', tenant_id;
    ELSE
        RAISE NOTICE 'No data found for tenant % in sim schema.', tenant_id;
    END IF;
END $$;

-- Transactions
DO $$
DECLARE
    tenant_id CONSTANT INT := 16;
BEGIN
    IF EXISTS (
        SELECT 1 FROM transactions.livetrans WHERE itenantid = tenant_id LIMIT 1
    ) OR EXISTS (
        SELECT 1 FROM transactions.arb_requests WHERE itenantid = tenant_id LIMIT 1
    ) OR EXISTS (
        SELECT 1 FROM transactions.scorerequests WHERE itenantid = tenant_id LIMIT 1
    ) THEN
        RAISE NOTICE 'Deleting from transactions schema for tenant %', tenant_id;
        DELETE FROM transactions.arb_requests WHERE itenantid = tenant_id;
        DELETE FROM transactions.livedecisiondetails WHERE itenantid = tenant_id;
        DELETE FROM transactions.scorerequests WHERE itenantid = tenant_id;
        DELETE FROM transactions.livetrans WHERE itenantid = tenant_id;
        RAISE NOTICE 'Tenant % deleted successfully from transactions schema.', tenant_id;
    ELSE
        RAISE NOTICE 'No data found for tenant % in transactions schema.', tenant_id;
    END IF;
END $$;

-- UI
-- UI
-- UI
-- UI
-- UI
-- UI
-- UI
DO $$
DECLARE
    target_tenant_id INT := 16;
BEGIN
    IF EXISTS (SELECT 1 FROM ui.tenants WHERE itenantid = target_tenant_id) THEN
        RAISE NOTICE 'Deleting from allocationusers for tenant %', target_tenant_id;
        DELETE FROM camunda.allocationusers WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from panelaccessmap for tenant %', target_tenant_id;
        DELETE FROM ui.panelaccessmap WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from tasklhsmap for tenant %', target_tenant_id;
        DELETE FROM ui.tasklhsmap WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from workflowmasters for tenant %', target_tenant_id;
        DELETE FROM ui.workflowmasters WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from grouptotaskfiltermap for tenant %', target_tenant_id;
        DELETE FROM ui.grouptotaskfiltermap WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from groupdesc for tenant %', target_tenant_id;
        DELETE FROM ui.groupdesc WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from listmaster for tenant %', target_tenant_id;
        DELETE FROM ui.listmaster WHERE itenantid = target_tenant_id;

     
        RAISE NOTICE 'Deleting from rolemenuaccessmap for tenant %', target_tenant_id;
        DELETE FROM ui.rolemenuaccessmap WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from roledesc for tenant %', target_tenant_id;
        DELETE FROM ui.roledesc WHERE itenantid = target_tenant_id;
		
		RAISE NOTICE 'Deleting from emailaudittrail for tenant %', target_tenant_id;
        DELETE FROM ui.emailaudittrail WHERE itenantid = target_tenant_id;
		
        RAISE NOTICE 'Deleting from webusermapping';
        DELETE FROM ui.webusermapping WHERE itenantid = target_tenant_id;
        DELETE FROM ui.dashboardfilters WHERE itenantid = target_tenant_id;
        DELETE FROM ui.dashboardqueryparameters WHERE itenantid = target_tenant_id;
        DELETE FROM ui.sectionparameters WHERE itenantid = target_tenant_id;
        DELETE FROM ui.dashboardresultset WHERE itenantid = target_tenant_id;
        DELETE FROM ui.dashboardquery WHERE itenantid = target_tenant_id;
        DELETE FROM ui.dashboard WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from masters.tenants';
        DELETE FROM masters.tenants WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Deleting from ui.tenants';
        DELETE FROM ui.tenants WHERE itenantid = target_tenant_id;

        RAISE NOTICE 'Tenant "pobo" (ID: %) deleted successfully.', target_tenant_id;
    ELSE
        RAISE NOTICE 'Tenant with ID % and name "pobo" not found.', target_tenant_id;
    END IF;
END $$;
-- SELECT table_schema, table_name
-- FROM information_schema.tables
-- WHERE table_name ILIKE 'workflowmasters';
-- SELECT table_schema, table_name
-- FROM information_schema.tables
-- WHERE table_name ILIKE 'allocationusers';

-- SELECT table_schema, table_name
-- FROM information_schema.tables
-- WHERE table_name ILIKE 'tasklhsmap';
-- SELECT table_schema, table_name
-- FROM information_schema.tables
-- WHERE table_name ILIKE 'groupdesc';



-- SELECT 
--     'allocationusers' AS table_name, EXISTS (
--         SELECT 1 FROM information_schema.tables 
--         WHERE table_schema = 'ui' AND table_name = 'allocationusers'
--     ) AS exists_in_ui
-- UNION ALL
-- SELECT 
--     'panelaccessmap', EXISTS (
--         SELECT 1 FROM information_schema.tables 
--         WHERE table_schema = 'ui' AND table_name = 'panelaccessmap'
--     )
-- UNION ALL
-- SELECT 
--     'tasklhsmap', EXISTS (
--         SELECT 1 FROM information_schema.tables 
--         WHERE table_schema = 'ui' AND table_name = 'tasklhsmap'
--     )
-- UNION ALL
-- SELECT 
--     'workflowmasters', EXISTS (
--         SELECT 1 FROM information_schema.tables 
--         WHERE table_schema = 'ui' AND table_name = 'workflowmasters'
--     )
-- UNION ALL
-- SELECT 
--     'tenants', EXISTS (
--         SELECT 1 FROM information_schema.tables 
--         WHERE table_schema = 'ui' AND table_name = 'tenants'
-- --     );
-- SELECT table_schema, table_name
-- FROM information_schema.tables
-- WHERE table_name ILIKE 'emailaudittrail';