package com.DronaPay.UIServer.util;

import org.owasp.esapi.ESAPI;
import org.springframework.stereotype.Service;

@Service
public class LoggerEncoderUtil {
    public String encode(String message) {
        if (message == null ) return "";
        message = message.replace( '\n' ,  '_' ).replace( '\r' , '_' )
                .replace( '\t' , '_' );
        message = ESAPI.encoder().encodeForHTML( message );
        return message;
    }
}
