package com.DronaPay.UIServer.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.exception.InvalidResponse;

@Component
public class ResponseParser {

    private String[] extractGroupNames(String patternString) {
        Pattern groupNamePattern = Pattern.compile("\\(\\?<([a-zA-Z][a-zA-Z0-9]*)>");
        Matcher groupNameMatcher = groupNamePattern.matcher(patternString);
        int count = 0;
        while (groupNameMatcher.find()) {
            count++;
        }
        String[] groupNames = new String[count];
        groupNameMatcher.reset();
        int index = 0;
        while (groupNameMatcher.find()) {
            groupNames[index++] = groupNameMatcher.group(1);
        }
        return groupNames;
    }

    public Map<String,String> parseResponse(String response,String response_template) throws InvalidResponse{

        Pattern response_pattern= Pattern.compile(response_template);

        Matcher response_Matcher=response_pattern.matcher(response);

        if(response_Matcher.matches()){
            Map<String,String> extractedValues=new HashMap<>();

            String[] groupNames=extractGroupNames(response_template);

            for(String group:groupNames){
                extractedValues.put(group, response_Matcher.group(group));
            }

            return extractedValues;
        }


        throw new InvalidResponse("Invalid response doesn't match with template");

    }
    
}
