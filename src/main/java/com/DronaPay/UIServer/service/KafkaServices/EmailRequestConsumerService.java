package com.DronaPay.UIServer.service.KafkaServices;

import com.DronaPay.UIServer.requests.EmailRequest;
import com.DronaPay.UIServer.service.ControllerService.EmailControllerService.EmailControllerService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@ConditionalOnProperty(name = "spring.kafka.email.enable", havingValue = "true")
public class EmailRequestConsumerService {

    @Autowired
    private EmailControllerService emailService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;


    // @KafkaListener(topics = "${spring.kafka.email-topic}")
    @KafkaListener(topics = "#{topicConfiguration.getEmailTopics()}")
    public void consume(@Payload String emailRequestBody,
                        @Header(KafkaHeaders.OFFSET) Long offset,
                        @Header(KafkaHeaders.RECEIVED_PARTITION) int partition,
                        @Header(KafkaHeaders.RECEIVED_TOPIC) String topic) throws Exception {
        log.debug("kafka email consumer invoked with payload " + loggerEncoderUtil.encode(emailRequestBody));
        log.info("kafka offset " + loggerEncoderUtil.encode(offset.toString()) + " kafka partition " + loggerEncoderUtil.encode(String.valueOf(partition)) + " kafka topic " + loggerEncoderUtil.encode(topic));
        ObjectMapper mapper = new ObjectMapper();
        EmailRequest emailRequest = mapper.readValue(emailRequestBody, EmailRequest.class);
        emailService.sendEmail(emailRequest);
        log.info("kafka email consumer processing complete for offset " + loggerEncoderUtil.encode(String.valueOf(offset)) + " kafka partition " + loggerEncoderUtil.encode(String.valueOf(partition)));
    }


}