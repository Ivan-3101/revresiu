package com.DronaPay.UIServer.configuration;

import java.util.HashMap;
import java.util.Map;

import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.StringSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.kafka.KafkaProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.core.DefaultKafkaProducerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.core.ProducerFactory;
import org.springframework.retry.annotation.EnableRetry;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;


@Configuration
@Slf4j
@EnableRetry
public class EmailRequestProducerConfig {

    // @Value(value = "kafka:9092")
    // private String bootstrapAddress;

    @Autowired
    private KafkaProperties kafkaProperties;

    @Bean
    public ProducerFactory<String, String> emailProducerFactory() {
        Map<String, Object> configProps = kafkaProperties.buildProducerProperties();
        // log.info("kafka node address configured for publisher " + bootstrapAddress);
        // configProps.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapAddress);
        configProps.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        configProps.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        return new DefaultKafkaProducerFactory<>(configProps);
    }

    @Bean
    public KafkaTemplate<String, String> emailProducerTemplate() {
        return new KafkaTemplate<>(emailProducerFactory());
    }

}
