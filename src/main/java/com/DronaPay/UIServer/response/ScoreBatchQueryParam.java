package com.DronaPay.UIServer.response;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Data;

@Data
public class ScoreBatchQueryParam {

    private String parameter_name;
    private String parameter_type;
    private Object value;
    private String trans_json_pointer;
    private String result_json_pointer;
    private Calculate calculate;


    @Data
    public class Calculate{
        private String operator;
        private String unit;
        private Object value;
    }
    
}
