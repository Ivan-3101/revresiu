package com.DronaPay.UIServer.configuration;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.DronaPay.UIServer.repository.TenantRepository;

@Component
public class TopicConfiguration {
    @Autowired
    private TenantRepository tenantRepositoryService;

    @Value("${spring.kafka.email-topic}")
    private String emailTopic;

    public String[] getEmailTopics() {
        return getTopics(emailTopic);
    }

    private String[] getTopics(String topic) {
        List<String> allTopics = tenantRepositoryService.findAll()
                .stream().map(tnt->{return topic + "_" +  tnt.getItenantid();})
                .toList();

        return allTopics.toArray(new String[0]);
    }
}
