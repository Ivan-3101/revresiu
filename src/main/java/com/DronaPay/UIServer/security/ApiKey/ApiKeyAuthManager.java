package com.DronaPay.UIServer.security.ApiKey;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import com.DronaPay.UIServer.util.LoggerEncoderUtil;

public class ApiKeyAuthManager implements AuthenticationManager {
    private static final Logger logger = LoggerFactory.getLogger(ApiKeyAuthManager.class);

    private final String api_key;


    private LoggerEncoderUtil loggerEncoderUtil;

    public ApiKeyAuthManager(String key_file, LoggerEncoderUtil loggerEncoderUtil) throws Exception {
//        String keyFromFile = Files.readString(Paths.get(key_file), StandardCharsets.US_ASCII);
//        this.api_key = keyFromFile.replace("\n","").replace("\r","");
        this.api_key = key_file;
        this.loggerEncoderUtil = loggerEncoderUtil;
    }

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String principal = (String) authentication.getPrincipal();
        if (principal.compareTo(api_key) == 0) {
            authentication.setAuthenticated(true);
            return authentication;
        } else {
            logger.error("API_KEY is not valid.");
            logger.info("principal:" + loggerEncoderUtil.encode(principal) + " - " + (principal.length()));
            throw new BadCredentialsException("API_KEY is not valid.");
        }
    }

}
