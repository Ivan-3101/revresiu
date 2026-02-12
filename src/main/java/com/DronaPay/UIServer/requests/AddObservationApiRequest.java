package com.DronaPay.UIServer.requests;

import com.DronaPay.UIServer.model.ObservationsUi;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.Data;

@Data
public class AddObservationApiRequest {

    private String observationName;
    private JsonNode groupByExpr;
    private String observationDuration;
    private Integer observationCount;
    private String aggregationType;
    private Integer windowId;
    private Integer observationId;
    private String observationDescription;
    private JsonNode whereExpr;

    public static AddObservationApiRequest parseObservatioUi(ObservationsUi observationsUi) {
        AddObservationApiRequest addObservationApiRequest = new AddObservationApiRequest();
        addObservationApiRequest.setAggregationType(observationsUi.getAggregationType());
        addObservationApiRequest.setGroupByExpr(observationsUi.getWExperession());
        addObservationApiRequest.setObservationCount(observationsUi.getOCount());
        addObservationApiRequest.setObservationDuration(observationsUi.getODuration());
        addObservationApiRequest.setObservationName(observationsUi.getOname());
        addObservationApiRequest.setWindowId(observationsUi.getWid());
        addObservationApiRequest.setObservationId(observationsUi.getOid());
        addObservationApiRequest.setObservationDescription(observationsUi.getOdesc());
        if(observationsUi.getWhereExperession()  != null) {
            addObservationApiRequest.setWhereExpr(observationsUi.getWhereExperession());
        }
        return addObservationApiRequest;
    }
}
