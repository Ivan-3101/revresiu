DO $$
DECLARE
    rec RECORD;
    itenantid_value INT := 16;
BEGIN
    -- Delete dependent records first to satisfy FK constraints
    DELETE FROM ui.listmaster WHERE itenantid = itenantid_value;
    DELETE FROM ui.emailaudittrail WHERE itenantid = itenantid_value;
    DELETE FROM ui.emailtemplate WHERE itenantid = itenantid_value;
    DELETE FROM ui.tasklhsmap WHERE itenantid = itenantid_value;
    DELETE FROM ui.panelaccessmap WHERE itenantid = itenantid_value;
    DELETE FROM ui.workflowmasters WHERE itenantid = itenantid_value;
    DELETE FROM ui.masterextractattribs WHERE itenantid = itenantid_value;
    DELETE FROM ui.dashboardfilters WHERE itenantid = itenantid_value;
    DELETE FROM ui.sectionparameters WHERE itenantid = itenantid_value;
    DELETE FROM ui.dashboardresultset WHERE itenantid = itenantid_value;
    DELETE FROM ui.dashboardqueryparameters WHERE itenantid = itenantid_value;
    DELETE FROM ui.dashboardquery WHERE itenantid = itenantid_value;
    DELETE FROM ui.dashboard WHERE itenantid = itenantid_value;
    DELETE FROM ui.webusermapping WHERE itenantid = itenantid_value;
    DELETE FROM ui.rolemenuaccessmap WHERE itenantid = itenantid_value;
    DELETE FROM ui.roledesc WHERE itenantid = itenantid_value;
    DELETE FROM ui.grouptotaskfiltermap WHERE itenantid = itenantid_value;
    DELETE FROM ui.groupdesc WHERE itenantid = itenantid_value;
    DELETE FROM ui.validationfieldslist WHERE itenantid = itenantid_value;
    DELETE FROM ui.rules WHERE itenantid = itenantid_value;
    DELETE FROM ui.decisions WHERE itenantid = itenantid_value;
    DELETE FROM masters.rules WHERE itenantid = itenantid_value;
    DELETE FROM masters.decisions WHERE itenantid = itenantid_value;
    DELETE FROM camunda.allocationusers WHERE itenantid = itenantid_value;
    DELETE FROM camunda.act_id_tenant_member WHERE tenant_id_ = itenantid_value::TEXT;
    DELETE FROM camunda.act_id_tenant WHERE id_ = itenantid_value::TEXT;

    -- Analytics schema deletions
    DELETE FROM analytics.batchdecisiondetails WHERE itenantid = itenantid_value;
    DELETE FROM analytics.batch_rule_triggered WHERE itenantid = itenantid_value;
    DELETE FROM analytics.rule_triggered WHERE itenantid = itenantid_value;
    DELETE FROM analytics.rule_performance WHERE itenantid = itenantid_value;
    DELETE FROM analytics.batchtrans WHERE itenantid = itenantid_value;
    DELETE FROM analytics.scorerequests WHERE itenantid = itenantid_value;
    DELETE FROM analytics.arb_requests WHERE itenantid = itenantid_value;
    DELETE FROM analytics.trans WHERE itenantid = itenantid_value;
    DELETE FROM analytics.decisiondetails WHERE itenantid = itenantid_value;

    -- Batch schema deletions
    DELETE FROM batch.batch_job WHERE itenantid = itenantid_value;

    -- Camunda schema deletions
    DELETE FROM camunda.act_ru_identitylink
    WHERE task_id_ IN (
        SELECT id_ FROM camunda.act_ru_task
        WHERE proc_inst_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst
            WHERE tenant_id_ = itenantid_value::TEXT
        )
    );

    DELETE FROM camunda.act_hi_comment
    WHERE task_id_ IN (
        SELECT id_ FROM camunda.act_ru_task
        WHERE proc_inst_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst
            WHERE tenant_id_ = itenantid_value::TEXT
        )
    );

    DELETE FROM camunda.act_hi_attachment
    WHERE task_id_ IN (
        SELECT id_ FROM camunda.act_ru_task
        WHERE proc_inst_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst
            WHERE tenant_id_ = itenantid_value::TEXT
        )
    );

    DELETE FROM camunda.act_ru_incident
    WHERE execution_id_ IN (
        SELECT id_ FROM camunda.act_ru_execution
        WHERE proc_inst_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst
            WHERE tenant_id_ = itenantid_value::TEXT
        )
    );

    DELETE FROM camunda.act_ru_job
    WHERE process_instance_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_hi_job_log
    WHERE job_id_ IN (
        SELECT id_ FROM camunda.act_ru_job
        WHERE process_instance_id_ IN (
            SELECT proc_inst_id_ FROM camunda.act_hi_procinst
            WHERE tenant_id_ = itenantid_value::TEXT
        )
    );

    DELETE FROM camunda.act_hi_ext_task_log
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_hi_op_log
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_hi_incident
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_ru_ext_task
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_ru_variable
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_ru_task
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_ru_execution
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_ru_batch WHERE tenant_id_ = itenantid_value::TEXT;

    DELETE FROM camunda.act_hi_actinst
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_hi_detail
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_hi_varinst
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_hi_taskinst
    WHERE proc_inst_id_ IN (
        SELECT proc_inst_id_ FROM camunda.act_hi_procinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_hi_caseactinst
    WHERE case_inst_id_ IN (
        SELECT id_ FROM camunda.act_hi_caseinst
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_hi_caseinst WHERE tenant_id_ = itenantid_value::TEXT;

    DELETE FROM camunda.act_hi_procinst WHERE tenant_id_ = itenantid_value::TEXT;

    DELETE FROM camunda.act_hi_decinst
    WHERE dec_def_key_ IN (
        SELECT key_ FROM camunda.act_re_decision_def
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_re_decision_def WHERE tenant_id_ = itenantid_value::TEXT;
    DELETE FROM camunda.act_re_procdef WHERE tenant_id_ = itenantid_value::TEXT;
    DELETE FROM camunda.act_re_case_def WHERE tenant_id_ = itenantid_value::TEXT;
    DELETE FROM camunda.act_re_camformdef WHERE tenant_id_ = itenantid_value::TEXT;

    DELETE FROM camunda.act_re_deployment
    WHERE id_ IN (
        SELECT deployment_id_ FROM camunda.act_ge_bytearray
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    DELETE FROM camunda.act_ge_bytearray WHERE tenant_id_ = itenantid_value::TEXT;

    DELETE FROM camunda.act_ru_identitylink
    WHERE user_id_ IN (
        SELECT id_ FROM camunda.act_id_user
        WHERE tenant_id_ = itenantid_value::TEXT
    );

    -- Masters schema deletions
    DELETE FROM masters.updlog WHERE itenantid = itenantid_value;
    DELETE FROM masters.verifiedaddresses WHERE itenantid = itenantid_value;
    DELETE FROM masters.mcclimits WHERE itenantid = itenantid_value;
    DELETE FROM masters.lists WHERE itenantid = itenantid_value;
    DELETE FROM masters.observationwindows WHERE itenantid = itenantid_value;
    DELETE FROM masters.observations WHERE itenantid = itenantid_value;
    DELETE FROM masters.rulesdraft WHERE itenantid = itenantid_value;
    DELETE FROM masters.customers WHERE itenantid = itenantid_value;
    DELETE FROM masters.accounts WHERE itenantid = itenantid_value;
    DELETE FROM masters.vpa WHERE itenantid = itenantid_value;
    DELETE FROM masters.transactionclasses WHERE itenantid = itenantid_value;
    DELETE FROM masters.holidaycalender WHERE itenantid = itenantid_value;

    -- Profiles schema deletions
    DELETE FROM profiles.metadata WHERE itenantid = itenantid_value;
    DELETE FROM profiles.account_monthly WHERE itenantid = itenantid_value;
    DELETE FROM profiles.account_weekly WHERE itenantid = itenantid_value;
    DELETE FROM profiles.vpa_monthly WHERE itenantid = itenantid_value;
    DELETE FROM profiles.vpa_weekly WHERE itenantid = itenantid_value;
    DELETE FROM profiles.mcc WHERE itenantid = itenantid_value;

    -- Sim schema deletions
    DELETE FROM sim.runs
    WHERE simid IN (
        SELECT simid FROM sim.simulations WHERE itenantid = itenantid_value
    );
    DELETE FROM sim.simulations WHERE itenantid = itenantid_value;

    -- Transactions schema deletions
    DELETE FROM transactions.arb_requests WHERE itenantid = itenantid_value;
    DELETE FROM transactions.livedecisiondetails WHERE itenantid = itenantid_value;
    DELETE FROM transactions.scorerequests WHERE itenantid = itenantid_value;
    DELETE FROM transactions.livetrans WHERE itenantid = itenantid_value;

    -- Drop tenant-specific tables
    FOR rec IN
        SELECT * FROM (
            VALUES
                ('analytics', 'arb_requests_' || itenantid_value),
                ('analytics', 'batch_rule_triggered_' || itenantid_value),
                ('analytics', 'batchdecisiondetails_' || itenantid_value),
                ('analytics', 'batchlog_' || itenantid_value),
                ('analytics', 'batchtrans_' || itenantid_value),
                ('analytics', 'decisiondetails_' || itenantid_value),
                ('analytics', 'rule_performance_' || itenantid_value),
                ('analytics', 'rule_triggered_' || itenantid_value),
                ('analytics', 'scorerequests_' || itenantid_value),
                ('analytics', 'trans_' || itenantid_value),
                ('camunda', 'allocationusers_' || itenantid_value),
                ('masters', 'accounts_' || itenantid_value),
                ('masters', 'customers_' || itenantid_value),
                ('masters', 'holidaycalender_' || itenantid_value),
                ('masters', 'lists_' || itenantid_value),
                ('masters', 'mcclimits_' || itenantid_value),
                ('masters', 'observations_' || itenantid_value),
                ('masters', 'observationwindows_' || itenantid_value),
                ('masters', 'rulesavailable_' || itenantid_value),
                ('masters', 'rulesdraft_' || itenantid_value),
                ('masters', 'transactionclasses_' || itenantid_value),
                ('masters', 'updlog_' || itenantid_value),
                ('masters', 'verifiedaddresses_' || itenantid_value),
                ('masters', 'vpa_' || itenantid_value),
                ('profiles', 'account_' || itenantid_value),
                ('profiles', 'account_monthly_' || itenantid_value),
                ('profiles', 'account_weekly_' || itenantid_value),
                ('profiles', 'mcc_' || itenantid_value),
                ('profiles', 'metadata_' || itenantid_value),
                ('profiles', 'vpa_' || itenantid_value),
                ('profiles', 'vpa_monthly_' || itenantid_value),
                ('profiles', 'vpa_weekly_' || itenantid_value),
                ('transactions', 'arb_requests_' || itenantid_value),
                ('transactions', 'livedecisiondetails_' || itenantid_value),
                ('transactions', 'livetrans_' || itenantid_value),
                ('transactions', 'scorerequests_' || itenantid_value),
                ('ui', 'dashboard_' || itenantid_value),
                ('ui', 'dashboardcustomlayout_' || itenantid_value),
                ('ui', 'dashboardcustomlayoutaudit_' || itenantid_value),
                ('ui', 'dashboardfilters_' || itenantid_value),
                ('ui', 'dashboardquery_' || itenantid_value),
                ('ui', 'dashboardqueryparameters_' || itenantid_value),
                ('ui', 'dashboardresultset_' || itenantid_value),
                ('ui', 'dashboardresultsetaudit_' || itenantid_value),
                ('ui', 'decisionsaudit_' || itenantid_value),
                ('ui', 'decisionsworkflowaudit_' || itenantid_value),
                ('ui', 'emailaudittrail_' || itenantid_value),
                ('ui', 'emailtemplate_' || itenantid_value),
                ('ui', 'formmaster_' || itenantid_value),
                ('ui', 'formvalue_' || itenantid_value),
                ('ui', 'groupdesc_' || itenantid_value),
                ('ui', 'grouptotaskfiltermap_' || itenantid_value),
                ('ui', 'list_' || itenantid_value),
                ('ui', 'listaudit_' || itenantid_value),
                ('ui', 'listmaster_' || itenantid_value),
                ('ui', 'masterextractattribs_' || itenantid_value),
                ('ui', 'metadata_' || itenantid_value),
                ('ui', 'metadataaudit_' || itenantid_value),
                ('ui', 'observationsui_' || itenantid_value),
                ('ui', 'observationsuiaudit_' || itenantid_value),
                ('ui', 'observationwindowsuiaudit_' || itenantid_value),
                ('ui', 'observationwindowsui_' || itenantid_value),
                ('ui', 'panelaccessmap_' || itenantid_value),
                ('ui', 'profileparamsconfig_' || itenantid_value),
                ('ui', 'reportmailconfig_' || itenantid_value),
                ('ui', 'reportmaillog_' || itenantid_value),
                ('ui', 'roledesc_' || itenantid_value),
                ('ui', 'rolemenuaccessmap_' || itenantid_value),
                ('ui', 'rulesaudit_' || itenantid_value),
                ('ui', 'rulesavailable_' || itenantid_value),
                ('ui', 'rulesavailableaudit_' || itenantid_value),
                ('ui', 'rulesdraft_' || itenantid_value),
                ('ui', 'rulesdraftaudit_' || itenantid_value),
                ('ui', 'sectionparameters_' || itenantid_value),
                ('ui', 'tasklhsmap_' || itenantid_value),
                ('ui', 'transactionclasses_' || itenantid_value),
                ('ui', 'transactionclassesaudit_' || itenantid_value),
                ('ui', 'workflowmasters_' || itenantid_value)
        ) AS t(schema_name, table_name)
    LOOP
        EXECUTE format('DROP TABLE IF EXISTS %I.%I CASCADE;', rec.schema_name, rec.table_name);
    END LOOP;

    -- Final tenant deletions
    DELETE FROM masters.tenants WHERE itenantid = itenantid_value;
    DELETE FROM ui.tenants WHERE itenantid = itenantid_value;
END $$;