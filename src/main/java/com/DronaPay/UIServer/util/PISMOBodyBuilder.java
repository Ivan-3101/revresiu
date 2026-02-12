package com.DronaPay.UIServer.util;

import org.springframework.stereotype.Component;

@Component
public class PISMOBodyBuilder {

    public String accessTokenRequestBody(String serverkey, String serversecret, String accountid) {
        return "{\n" +
                "    \"server_key\": \"" + serverkey + "\",\n" +
                "    \"server_secret\": \"" + serversecret + "\",\n" +
                "    \"account_id\": " + accountid + "\n" +
                "}";
    }

}
