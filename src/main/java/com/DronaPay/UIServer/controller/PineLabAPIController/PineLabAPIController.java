package com.DronaPay.UIServer.controller.PineLabAPIController;

import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.ApiServices.PineLabAPIService;
import jakarta.servlet.http.HttpServletRequest;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

import java.util.UUID;

@RestController
public class PineLabAPIController {

    @Autowired
    private PineLabAPIService pineLabAPIService;

    @PostMapping("/api/v1/pinelabs/settlements/hold_unhold")
    public ResponseEntity<String> holdAndUnholTransaction(@RequestBody String body) throws Exception {
        return pineLabAPIService.holdAndUnholdTransaction(body);
    }

    @PostMapping("/api/v1/pinelabs/settlements/hold_unhold/enquiry")
    public ResponseEntity<String> holdAndUnholEnquiry(@RequestBody String body) throws Exception {
        return pineLabAPIService.holdAndUnholdEnquiry(body);
    }

    @PostMapping("/api/risk/transaction")
    public ResponseEntity<?> dummyPineLab(@RequestBody String body, HttpServletRequest httpServletRequest)
            throws Exception {
        JSONObject response = new JSONObject(body);
        response.put("status", "PENDING");
        response.put("message", "Request received");
        String buissness_key = httpServletRequest.getHeader("X-requestId");
        return  pineLabAPIService.dummyCallBackResponse(response, buissness_key);
       
    }

    @PostMapping(path = "/api/risk/transaction/callback", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ApiResponse> callBackAPISettlements(@RequestBody String body,
                                                              HttpServletRequest httpServletRequest) throws Exception {
        String buissness_key = httpServletRequest.getHeader("X-requestId");
        pineLabAPIService.callBackAPI(body, buissness_key);
        return new ResponseEntity<ApiResponse>(
                new ApiResponse(true, "Call back response received", HttpStatus.ACCEPTED),
                HttpStatus.ACCEPTED);
    }

    @PostMapping("/api/risk/merchant/callback")
    public ResponseEntity<String> callBackAPIMerchant(@RequestBody String body) throws Exception {
        pineLabAPIService.callBackAPIMerchant(body);
        return ResponseEntity.ok("Call back response received");
    }

    @PostMapping("/v1/identity/oauth/token")
    public ResponseEntity<?> dummyAuth(@RequestBody String body) throws Exception {
        JSONObject response = new JSONObject();
        response.put("access_token", UUID.randomUUID().toString());
        response.put("expires_in", -58516703);
        response.put("token_type", "ullamco ea ex minim");
        response.put("scope", "elit ea Ut ex");
        return ResponseEntity.ok(response.toMap());
    }

    @GetMapping("/api/v1/pinelabs/get-trans/{address}/{level}/{date}/workflowkey/{workflowkey}/tenant-id/{tenantid}")
    public ResponseEntity<?> getTrans(
            @PathVariable(value = "address", required = true) String address,
            @PathVariable(value = "level", required = true) String level,
            @PathVariable(value = "date", required = true) String date,
            @PathVariable(value = "workflowkey", required = true) String workflowkey,
            @PathVariable(value = "tenantid", required = true) Integer tenantid,
            Authentication pr) {
        return pineLabAPIService.getTrans(address, level, date, workflowkey, tenantid,"", 65000, pr);
    }
    
    @GetMapping("/api/v1/pinelabs/get-trans-pinelabs/{address}/{level}/{date}/workflowkey/{workflowkey}/tenant-id/{tenantid}/{txnid}/settlementType/{settlementType}/exceptionCase/{exceptionCase}/limit/{limit}")
    public ResponseEntity<?> getTrans(
            @PathVariable(value = "address", required = true) String address,
            @PathVariable(value = "level", required = true) String level,
            @PathVariable(value = "date", required = true) String date,
            @PathVariable(value = "workflowkey", required = true) String workflowkey,
            @PathVariable(value = "tenantid", required = true) Integer tenantid,
            @PathVariable(value = "txnid", required = false) String txnid,
            @PathVariable(value = "settlementType", required = true) String settlementType, 
            @PathVariable(value = "exceptionCase", required = true) Boolean exceptionCase,
            @PathVariable(value = "limit", required = true) String limit,
            Authentication pr
    ) {

        return pineLabAPIService.getTransNew(address, level, date, workflowkey, tenantid, txnid, limit,settlementType,exceptionCase, pr);
    }

    @GetMapping("/api/v1/pinelabs/get-trans-workflow/{address}/{level}/{date}/workflowkey/{workflowkey}/tenant-id/{tenantid}")
    public ResponseEntity<?> getTransWorkflow(
            @PathVariable(value = "address", required = true) String address,
            @PathVariable(value = "level", required = true) String level,
            @PathVariable(value = "date", required = true) String date,
            @PathVariable(value = "workflowkey", required = true) String workflowkey,
            @PathVariable(value = "tenantid", required = true) Integer tenantid,
            Authentication pr) {
        return pineLabAPIService.getTrans(address, level, date, workflowkey, tenantid, "", 65000, pr);
    }


    @GetMapping("/api/risk/transaction/enquiry")
    public ResponseEntity<?> dummyPineLab(HttpServletRequest httpServletRequest)
            throws Exception {
        String requestid = httpServletRequest.getHeader("X-requestId");
        return pineLabAPIService.dummyEnquiry(requestid);
    }
}
