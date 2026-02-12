package com.DronaPay.UIServer.service.ApiServices;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface PineLabAPIService {

    ResponseEntity<String> holdAndUnholdTransaction(String body) throws Exception;

    ResponseEntity<String> holdAndUnholdEnquiry(String body) throws Exception;

    ResponseEntity<?> dummyCallBackResponse(JSONObject body,String buissness_key) throws Exception;

    void callBackAPI(String body,String buissness_key) throws Exception;

    void callBackAPIMerchant(String body) throws Exception;

    ResponseEntity<?> getTrans(String address, String level, String date,String workflowkey, Integer tenantid, String txnid, Integer limit, Authentication pr);

    ResponseEntity<?> getTransNew(String address, String level, String date, String workflowkey, Integer tenantid, String txnid, String limit, String settlementType, Boolean exceptionCase, Authentication pr);

    ResponseEntity<?> dummyEnquiry(String requestid);

}
