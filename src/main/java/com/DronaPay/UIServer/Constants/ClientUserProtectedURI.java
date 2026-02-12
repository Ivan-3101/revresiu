package com.DronaPay.UIServer.Constants;

public class ClientUserProtectedURI {
    public static final String[] Client_Protected_Url = {

            "/api/v1/auth/get-api-key/*",
            "/api/v1/reports/get-active-scheduled-reports/tenant-id/*",
            "/api/v1/tenant/*",
            "/api/v1/testing/email-service/send-email/tenant-id/*",
            "/api/v1/reports/generate-and-send-report/*/tenant-id/*",
            "/api/v1/pinelabs/settlements/hold_unhold",
            "/api/v1/camunda-rest/send-message",
            "/api/risk/transaction/callback",
            "/api/risk/merchant/callback",
            "/api/v1/pinelabs/settlements/hold_unhold",
            "/api/v1/pinelabs/settlements/hold_unhold/enquiry",
            "/api/v1/camunda-rest/callback/send-message/tenant-id/*",
            "/api/v1/testing/allocation-mapper/get-user-mapping/tenant-id/*",
            "/api/v1/case-management/tasks/get-users-qc/*/tenant-id/*",
            "/api/v1/pinelabs/get-trans/*/*/*",
            "/api/v1/score_batch/run_query/*/tenant-id/*",
            "/api/v1/score_batch/response_api",
            "/api/v1/jpb/block-account",
            "/api/v1/jpb/ivr-call",
            "/api/v1/case-management/process-bulk-tickets/reassign-task/external",
            "/api/v1/case-management/process-bulk-tickets/submit-bulk/external",
            "/api/v1/tenant/*",
            "/api/v1/testing/batch/job/list",
            "/api/v1/testing/batch/job/customer"

    };

    public static final String[] Api_Protected_Url = {
            "/api/v1/testing/rule-configurator/get-rule/*",
            "/api/v1/client/new-client",
            "/api/v1/auth/sso-config",
            "/api/v1/auth/sso-config/*"
    };

    public static final String[] PUBLIC_URLS = {
            "/api/v1/client/token",
            "/dronaui/auth/logout",
            "/manifest.json",
            "/favicon.png",
            "/static",
            "/static/**",
            "/dronaui/",
            "/dronaui/**",
            "/v2/api-docs",
            "/webjars/**",
            "/api/v1/auth/login",
            "/api/v1/auth/refreshtoken",
            "/api/v1/auth/token",
            "/api/v1/forgot-password/*",
            "/api/v1/validate-token",
            "/api/v1/reset-password",
            "/api/v1/testing/list-management/add-list-without-audit",
            "/api/v1/case-management/tasks/get-field-list",
            "/api/risk/transaction",
            "/dummy-ivr-callback",
            "/log-error",
            "/webjars",
            "/api/v1/testing/allocation-mapper/get-user-mapping",
            "/api/v1/case-management/tasks/get-users-qc",
            "/v1/identity/oauth/token",
            "/api/v1/score_batch/dummy_response_api",
            "/api/v1/download-logo/**",
            "/api/v1/dummy/**",
//            "/actuator",
            "/actuator/health",
            "/actuator/health/*",
            "/actuator/prometheus",
            "/api/risk/transaction/enquiry",
            "/api/v1/timeout-check/*"
    };


//    public static final String[] saml_public = {
//            "/api/v1/client/token",
//            "/api/v1/auth/sso-config",
//            "/api/v1/auth/sso-config/*",
//            "/dronaui/auth/logout",
//            "/api/risk/transaction",
//            "/dummy-ivr-callback",
//            "/dronaui/auth/login",
//            "/manifest.json",
//            "/favicon.png",
//            "/static",
//            "/static/**",
//            "/v2/api-docs",
//            "/webjars/**",
//            "/api/v1/testing/list-management/add-list-without-audit",
//            "/api/v1/tenant/*",
//            "/api/v1/case-management/tasks/get-field-list",
//            "/webjars",
//            "/api/v1/testing/allocation-mapper/get-user-mapping",
//            "/api/v1/case-management/tasks/get-users-qc",
//            "/api/v1/download-logo/**",
//            "/api/v1/dummy/**",
//            "/actuator",
//            "/actuator/health",
//            "/actuator/health/*",
//            "/actuator/prometheus",
//            "/v1/identity/oauth/token",
//            "/api/v1/score_batch/dummy_response_api"
//    };
}
