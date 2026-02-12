package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.model.ObservationWindows;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.Data;
import com.fasterxml.jackson.databind.ObjectMapper;

@Data
public class AddWindowApiRequest {

    private String windowName;
    private String windowDuration;
    private Integer windowCount;
    private JsonNode selectExpr;
    private JsonNode whereExpr;
    private JsonNode groupByExpr;
    private Integer windowId;
    private String windowDescription;
    private JsonNode idexpr;
    private JsonNode tsexpr;

    public static AddWindowApiRequest parseTOAddWindowApiRequest(ObservationWindows observationWindows) {
        AddWindowApiRequest addWindowApiRequest = new AddWindowApiRequest();
        if(observationWindows.getGroupbyExperession() != null){
        addWindowApiRequest.setGroupByExpr(observationWindows.getGroupbyExperession());}
        if(observationWindows.getWhereExperession() != null){
        addWindowApiRequest.setWhereExpr(observationWindows.getWhereExperession());}
        if(observationWindows.getSelectExperession() != null){
        addWindowApiRequest.setSelectExpr(observationWindows.getSelectExperession());}
        addWindowApiRequest.setWindowCount(observationWindows.getWCount());
        addWindowApiRequest.setWindowDuration(observationWindows.getWDuration());
        addWindowApiRequest.setWindowName(observationWindows.getWname());
        addWindowApiRequest.setWindowId(observationWindows.getWid());
        addWindowApiRequest.setWindowDescription(observationWindows.getWdesc());
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            addWindowApiRequest.setIdexpr(objectMapper.readTree(observationWindows.getIdexpr()));
            addWindowApiRequest.setTsexpr(objectMapper.readTree(observationWindows.getTsexpr()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return addWindowApiRequest;
    }
}
