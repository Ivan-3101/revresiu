package com.DronaPay.UIServer.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class JsonConverterUtil {

    @Autowired
    private ObjectMapper objectMapper;

    public String convertToJson(Object obj) throws Exception {
        return objectMapper.writeValueAsString(obj);
    }

    public <T> T convertFromJson(String json, Class<T> clazz) throws Exception {
        return objectMapper.readValue(json, clazz);
    }
}
