package com.DronaPay.UIServer.controller.MasterConfig;


import com.DronaPay.UIServer.requests.MasterConfigRequest;
import com.DronaPay.UIServer.service.ControllerService.MasterConfig.MasterConfigContService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/testing/masters")
public class MasterConfigController {

    @Autowired
    private MasterConfigContService masterConfigContService;

    @PostMapping("/get-master-config/{menuname}")
    public ResponseEntity<?> getConf(@RequestBody MasterConfigRequest req, @PathVariable("menuname") String menuname, Authentication pr) {
        return masterConfigContService.getMasterConfig(req, menuname, pr);
    }

}