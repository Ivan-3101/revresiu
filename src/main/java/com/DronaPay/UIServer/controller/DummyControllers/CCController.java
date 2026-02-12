package com.DronaPay.UIServer.controller.DummyControllers;
import com.DronaPay.UIServer.service.ControllerService.DummyControllers.CCControllerService;

import org.springframework.http.ResponseEntity;

import lombok.SneakyThrows;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/dummy/cc")
public class CCController {


    @Autowired
    private CCControllerService ccControllerService;

    @SneakyThrows
    @PostMapping("/decline-transaction-cc")
    public ResponseEntity<?> ccCall(@RequestBody String jsonString){
        return ccControllerService.ccCall(jsonString);
    }


}
