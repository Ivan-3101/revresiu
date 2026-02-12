package com.DronaPay.UIServer.response.Records;

import com.fasterxml.jackson.databind.JsonNode;


public record SSOConfigResponse(String authorizeurl, String clientid, String scope, Boolean sso, String redirectURL,
                                String ssoType, String logoutUrl, Boolean pismoEnabled, String logoUrl,
                                String logoStyle, String PublicKey, String UsfbIvrLink, String esafIvrLink,
                                String CubIvrLink, String SSFBIvrLink, Long bulkProcessingLimit, Integer tokenExpiryTime,
                                JsonNode dashboardAutoSearch, JsonNode casemgmt) {
}
