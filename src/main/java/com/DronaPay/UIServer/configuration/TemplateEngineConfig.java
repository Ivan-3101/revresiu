package com.DronaPay.UIServer.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.DronaPay.UIServer.util.HtmlTemplateEngine;
import com.DronaPay.UIServer.util.TextTemplateEngine;

@Configuration
public class TemplateEngineConfig {

    @Bean
    TextTemplateEngine textTemplateEngine() {
        return new TextTemplateEngine();
    }

    @Bean
    HtmlTemplateEngine htmlTemplateEngine(){
        return new HtmlTemplateEngine();
    }

}
