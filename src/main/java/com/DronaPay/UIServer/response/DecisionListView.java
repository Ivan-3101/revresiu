package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.ResponseVO.DecisionClassDropDown;
import lombok.Data;

import java.util.List;

@Data
public class DecisionListView {
    private List<DecisionClassDropDown> decisionList;
    private Boolean view;
    private Boolean add;
    private Boolean delete;
    private Boolean edit;
    private Boolean approve;
    private Boolean publish;
}
