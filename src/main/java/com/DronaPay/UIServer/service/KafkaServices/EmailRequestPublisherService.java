package com.DronaPay.UIServer.service.KafkaServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.util.LoggerEncoderUtil;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class EmailRequestPublisherService {

    @Value(value = "${spring.kafka.email-topic}")
    private String emailTopic;

    @Autowired
    private KafkaTemplate<String, String> emailTemplate;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;
    
    public void submit(String request, Integer tenantid) throws Exception {
        log.debug("Email request publisher invoked with request " + request);
        emailTemplate.send(emailTopic + "_" + tenantid, request);
        log.info("Email request published to kafka on topic " + loggerEncoderUtil.encode(emailTopic) + "_" + loggerEncoderUtil.encode(String.valueOf(tenantid)));
    }

}