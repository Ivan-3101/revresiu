package com.DronaPay.UIServer.controller.PISMOController;


import com.DronaPay.UIServer.service.ControllerService.PISMOServices.PismoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api/v1/pismo/")
public class PISMOController {

    @Autowired
    private PismoService pismoService;

    @GetMapping("account/{account_id}/class/{class_name}/contact/tenant-id/{tenantid}")
    public ResponseEntity<?> claimTask(Authentication pr, @PathVariable("account_id") String account_id, @PathVariable("class_name") String class_name, @PathVariable("tenantid") Integer tenantid) throws Exception {
        return pismoService.contactNumber(pr, account_id, class_name, tenantid);
    }

}
