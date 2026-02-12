package com.DronaPay.UIServer.configuration;

import java.util.Map;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.autoconfigure.kafka.KafkaProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.kafka.config.ConcurrentKafkaListenerContainerFactory;
import org.springframework.kafka.config.KafkaListenerContainerFactory;
import org.springframework.kafka.core.ConsumerFactory;
import org.springframework.kafka.core.DefaultKafkaConsumerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.listener.ConcurrentMessageListenerContainer;
import org.springframework.kafka.listener.DefaultErrorHandler;
import org.springframework.kafka.retrytopic.RetryTopicConfiguration;
import org.springframework.kafka.retrytopic.RetryTopicConfigurationBuilder;
import org.springframework.util.backoff.FixedBackOff;

import lombok.extern.slf4j.Slf4j;

@EnableKafka
@Configuration
@Slf4j
@ConditionalOnProperty(name = "spring.kafka.email.enable", havingValue = "true")
public class EmailRequestConsumerConfig {

    @Value(value = "${spring.kafka.consumer.backoff.interval}")
    private Long interval;

    @Value(value = "${spring.kafka.consumer.backoff.max_failure}")
    private Integer maxAttempts;

    @Value(value = "${spring.kafka.email-topic}")
    private String emailTopic;

    @Autowired
    private KafkaProperties kafkaProperties;

    @Bean
    public Map<String, Object> consumerConfigs() {
        Map<String, Object> props = kafkaProperties.buildConsumerProperties();

        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);

        return props;
    }

    @Bean
    public ConsumerFactory<String, String> consumerFactory() {
        return new DefaultKafkaConsumerFactory<>(consumerConfigs());
    }

    @Bean
    public RetryTopicConfiguration emailRetryTopic(KafkaTemplate<String, String> template) {
        log.info("Configuring email retry topic - maxAttempts: {}, interval: {}ms",
                maxAttempts, interval);
        return RetryTopicConfigurationBuilder
                .newInstance()
                .fixedBackOff(interval)
                .maxAttempts(maxAttempts)
                .includeTopic(emailTopic)
                .doNotAutoCreateRetryTopics()  // Prevent automatic retry topic creation
                .create(template);
    }

    @Bean
    public KafkaListenerContainerFactory<ConcurrentMessageListenerContainer<String, String>> kafkaListenerContainerFactory() {
        ConcurrentKafkaListenerContainerFactory<String, String> factory =
                new ConcurrentKafkaListenerContainerFactory<>();
        factory.setConsumerFactory(consumerFactory());


            DefaultErrorHandler errorHandler = new DefaultErrorHandler(
                    new FixedBackOff(interval, maxAttempts - 1) // maxAttempts - 1 because first attempt doesn't count as retry
            );
            factory.setCommonErrorHandler(errorHandler);
            log.info("Error handler configured with {} retries and {}ms interval", maxAttempts - 1, interval);


        return factory;
    }
}