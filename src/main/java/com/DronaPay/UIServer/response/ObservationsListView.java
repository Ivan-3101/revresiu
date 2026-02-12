package com.DronaPay.UIServer.response;

import lombok.Data;

import java.util.List;

@Data
public class ObservationsListView {

    private List<ObservationResponse> observationsList;
    private Boolean view;
    private Boolean add;
    private Boolean delete;
    private Boolean edit;
    private Boolean approve;
    private Boolean publish;
}
