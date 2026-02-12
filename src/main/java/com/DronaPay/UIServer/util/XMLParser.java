package com.DronaPay.UIServer.util;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;

@Service
public class XMLParser {
    public Document XMLParser(String xmlString) throws Exception
    {
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();

        documentBuilderFactory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        documentBuilderFactory.setFeature("http://xml.org/sax/features/external-general-entities", false);
        documentBuilderFactory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);

        DocumentBuilder builder = documentBuilderFactory.newDocumentBuilder();

        InputSource src = new InputSource();
        src.setCharacterStream(new StringReader(xmlString));

        org.w3c.dom.Document doc = builder.parse(src);

        return doc;
    }
}
