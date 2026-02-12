package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.model.DecisionUi;
import org.springframework.http.ResponseEntity;

import java.net.http.HttpResponse;

public interface DecisionApiService {

    public ResponseEntity<String> addDecision(DecisionUi decisionUi) throws Exception;

    public ResponseEntity<String> editDecision(DecisionUi decisionUi) throws Exception;

//    public HttpResponse<String> getDecision(Integer decisionid) throws Exception;

    public ResponseEntity<String> deleteDecision(String apikey, Integer decisionid) throws Exception;
}
