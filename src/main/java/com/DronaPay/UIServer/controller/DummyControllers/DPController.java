package com.DronaPay.UIServer.controller.DummyControllers;


import com.DronaPay.UIServer.service.ControllerService.DummyControllers.DPControllerService;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/dummy/dp")
public class DPController {

    @Autowired
    private DPControllerService dpControllerService;


    @PostMapping("/block-fund")
    public ResponseEntity<?> blockFund(@RequestBody String jsonString) {
        return dpControllerService.blockFund(jsonString);
    }
}
