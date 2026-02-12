package com.DronaPay.UIServer.util;

import org.apache.commons.lang.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class DashboardErrorUtil {

    @Value("${dashboard.error}")
    private String error_json;

    @Cacheable(value= "error_code", key = "#error_code", unless = "#result == null")
    public String getErrorMessage(String error_code)
    {
        JSONObject jsonObject= new JSONObject(error_json);
        String response= jsonObject.optString(error_code);
        if(!StringUtils.isBlank(response))
        {
            return response;
        }
        return response;
    }

    public String extractErrorCode(String message) {
        if (message == null) {
            return null;
        }

        // Match text like: error code [65542]
        Pattern pattern = Pattern.compile("error code\\s*\\[(\\d+)\\];");
        Matcher matcher = pattern.matcher(message);

        if (matcher.find()) {
            return matcher.group(1); // returns "65542"
        }

        return null; // no match found
    }
}
