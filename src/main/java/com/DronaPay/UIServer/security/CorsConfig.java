package com.DronaPay.UIServer.security;

import com.DronaPay.UIServer.model.Organization;
import com.DronaPay.UIServer.service.RepositoryService.OrganizationRepositoryService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Configuration
@Slf4j
public class CorsConfig implements WebMvcConfigurer {

//    @Value("${drona.ui.url}")
//    private String frontEnd;

    @Autowired
    private OrganizationRepositoryService organizationRepositoryService;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        List<Organization> orgs_lists = organizationRepositoryService.findAllOrgs();

        List<String> front_end_url = orgs_lists.stream()
                .map(org -> org.getAttribs().get("drona.ui.url"))
                .filter(Objects::nonNull)
                .flatMap(urlNode -> {
                    List<String> urls = new ArrayList<>();
                    if (urlNode.isArray()) {
                        urlNode.forEach(node -> {
                            if (node.isTextual()) {
                                urls.add(node.asText());
                            }
                        });
                    }
                    return urls.stream();
                })
                .distinct()
                .toList();

        log.info("allowed frontend urls "+ front_end_url);
        registry.addMapping("/**")
                .allowedOrigins(front_end_url.toArray(new String[0])) // allow all origins
                .allowedMethods("GET", "POST", "PUT", "DELETE", "PATCH") // allow specified HTTP methods
                .allowedHeaders("*"); // allow all headers
    }
}
