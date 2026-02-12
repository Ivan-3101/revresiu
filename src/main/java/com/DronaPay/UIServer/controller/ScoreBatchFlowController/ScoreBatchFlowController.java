package com.DronaPay.UIServer.controller.ScoreBatchFlowController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.DronaPay.UIServer.service.ControllerService.ScoreBatchFlow.ScoreBatchFlowService;

@RestController
@RequestMapping("/api/v1/score_batch/")
public class ScoreBatchFlowController {

    @Autowired
    private ScoreBatchFlowService scoreBatchFlowService;

    @PostMapping("run_query/{ruleid}/tenant-id/{tenantid}")
    public ResponseEntity<?> executeQueryById(@PathVariable("ruleid") Integer iRuleId, @PathVariable("tenantid")
    Integer tenantid, @RequestBody String event)
            throws Exception {
        return scoreBatchFlowService.findByRuleIdAndExecuteQuery(iRuleId, event, tenantid);
    }

    @PostMapping("response_api")
    public ResponseEntity<?> callResponseAPI(@RequestBody String body) throws Exception {
        return scoreBatchFlowService.callResponseAPI(body);
    }

    @PostMapping("dummy_response_api")
    public ResponseEntity<?> dummyResponseAPI(@RequestBody String body) throws Exception {
        return ResponseEntity.ok().body(body);
    }


}
