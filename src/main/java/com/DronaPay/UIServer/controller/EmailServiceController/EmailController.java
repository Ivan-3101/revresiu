package com.DronaPay.UIServer.controller.EmailServiceController;

import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.requests.AddUserAllocationMapping;
import com.DronaPay.UIServer.requests.EmailRequest;
import com.DronaPay.UIServer.requests.GetUserMappingRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.ControllerService.AllocationMapper.AllocationMapperService;
import com.DronaPay.UIServer.service.ControllerService.EmailControllerService.EmailControllerService;
import com.DronaPay.UIServer.service.KafkaServices.EmailRequestPublisherService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/testing/email-service")
@Slf4j
public class EmailController {
    @Autowired
    private EmailControllerService emailService;

    @Value(value = "${spring.kafka.email.enable}")
    Boolean kafkaEnable;

    @Autowired
    private EmailRequestPublisherService emailPublisher;

    @PostMapping("/send-email/tenant-id/{tenantid}")
    public ResponseEntity<?> sendEmail(@RequestBody String emailRequestString,
            @PathVariable("tenantid") Integer itenantId) {
        ObjectMapper mapper = new ObjectMapper();
        EmailRequest emailRequest;
        try {
            emailRequest = mapper.readValue(emailRequestString, EmailRequest.class);
            emailRequest.setItenantId(itenantId);
            emailRequestString = mapper.writeValueAsString(emailRequest);
        } catch (Exception e) {
            log.error("Exception invoking email send method " + e);
            return new ResponseEntity<>(new ApiResponse(false, "Email send method invocation failed"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        
        if (kafkaEnable) {
            log.info("Using kafka publish for sending email");
            try {
                emailPublisher.submit(emailRequestString, itenantId);
            } catch (Exception e) {
                log.error("Exception invoking kafka publisher" + e);
                return new ResponseEntity<>(new ApiResponse(false, "Email request kafka publish failed"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            return new ResponseEntity<>(new ApiResponse(true, "Email request published to kafka"),
                    HttpStatus.OK);
        } else {
            log.info("Sending email directly without kafka");
            try {
                return emailService.sendEmail(emailRequest);
            } catch (Exception e) {
                log.error("Exception invoking email send method " + e);
                return new ResponseEntity<>(new ApiResponse(false, "Email send method invocation failed"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

    }
}
