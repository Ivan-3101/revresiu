package com.DronaPay.UIServer.service.ControllerService.Tenant;

import java.net.http.HttpResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.response.TenantDetialResponse;
import com.DronaPay.UIServer.service.ApiServices.TransactionClassApiService;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TenantControllerServiceImpl implements TenantControllerService {

    @Autowired
    private TransactionClassApiService transactionClassApiService;

    @Override
    public ResponseEntity<?> getByTenantId(String class_name) throws Exception {
        log.info("entere in " + TenantControllerServiceImpl.class + " in method getByTenandID");
        // Tenant tenant = tenantService.getByTenantId(tenant_id);
        // log.info("Tenant Detail retrieved successfully "+ tenant.toString());
//        HttpResponse<String> response = transactionClassApiService.getTransactionClass("", class_name);
//        return new ResponseEntity<String>(response.body(), HttpStatus.valueOf(response.statusCode()));
        ResponseEntity<String> response = transactionClassApiService.getTransactionClass("", class_name);
        return response;

    }

}
