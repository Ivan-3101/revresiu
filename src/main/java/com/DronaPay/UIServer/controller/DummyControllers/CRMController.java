package com.DronaPay.UIServer.controller.DummyControllers;



import com.DronaPay.UIServer.service.ControllerService.DummyControllers.CRMControllerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/v1/dummy/crm")
public class CRMController {

    @Autowired
    private CRMControllerService crmControllerService;
}
