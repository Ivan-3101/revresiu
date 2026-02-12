package com.DronaPay.UIServer.util;

import org.thymeleaf.TemplateEngine;
import org.thymeleaf.templateresolver.StringTemplateResolver;

public class HtmlTemplateEngine extends TemplateEngine {

    public HtmlTemplateEngine() {
        super();
        StringTemplateResolver htmlTemplateResolver = new StringTemplateResolver();
        this.setTemplateResolver(htmlTemplateResolver);
    }

}
