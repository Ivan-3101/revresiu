package com.DronaPay.UIServer.util;

import org.thymeleaf.TemplateEngine;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.StringTemplateResolver;

public class TextTemplateEngine extends TemplateEngine {

    public TextTemplateEngine() {
        super();
        StringTemplateResolver textTemplateResolver = new StringTemplateResolver();
        textTemplateResolver.setTemplateMode(TemplateMode.TEXT);
        this.setTemplateResolver(textTemplateResolver);
    }

}
