package com.DronaPay.UIServer.controller.DummyControllers;

import com.DronaPay.UIServer.service.ControllerService.DummyControllers.FRMControllerService;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/dummy/frm")
public class FRMController {

    @Autowired
    private FRMControllerService frmControllerService;

    @PostMapping("/enrich-case")
    public ResponseEntity<?> blockFund(@RequestBody String jsonString) {
       return frmControllerService.blockFund(jsonString);
    }

}
