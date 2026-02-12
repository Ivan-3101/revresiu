package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.requests.ErrorLogRequest;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import org.springframework.security.core.Authentication;

@Service
public class ReactErrorLoggerServiceImpl implements ReactErrorLoggerService {

        // final Level react = Level.parse("REACT");
        // private static final Logger LOGGER =
        // LoggerFactory.getLogger(ReactErrorLoggerServiceImpl.class);

        Logger LOGGER = LoggerFactory.getLogger("appuilogger");

        @Autowired
        private LoggerEncoderUtil loggerEncoderUtil;

        @Override
        public ResponseEntity<?> logErrors(ErrorLogRequest errorLogRequest, Authentication user) {
                String username = null;
                if (user != null) {
                        username = user.getName();
                }

                String level = errorLogRequest.getLevel();
                if (level.equalsIgnoreCase("error")) {
                        LOGGER.error(loggerEncoderUtil
                                        .encode("[ UserName: " + username + " ] " +
                                                        "\n - Error :" + errorLogRequest.getError() +
                                                        "\n - Message :" + errorLogRequest.getMessage() +
                                                        "\n - URL :" + errorLogRequest.getUrl() +
                                                        "\n - Body :" + errorLogRequest.getBody() +
                                                        "\n - RequestType :" + errorLogRequest.getRequestType()));
                } else if (level.equalsIgnoreCase("warn")) {
                        LOGGER.warn(loggerEncoderUtil
                                        .encode("[ UserName: " + username + " ] " +
                                                        "\n - Error :" + errorLogRequest.getError() +
                                                        "\n - Message :" + errorLogRequest.getMessage() +
                                                        "\n - URL :" + errorLogRequest.getUrl() +
                                                        "\n - Body :" + errorLogRequest.getBody() +
                                                        "\n - RequestType :" + errorLogRequest.getRequestType()));
                } else if (level.equalsIgnoreCase("info")) {
                        LOGGER.info(loggerEncoderUtil
                                        .encode("[ UserName: " + username + " ] " +
                                                        "\n - Error :" + errorLogRequest.getError() +
                                                        "\n - Message :" + errorLogRequest.getMessage() +
                                                        "\n - URL :" + errorLogRequest.getUrl() +
                                                        "\n - Body :" + errorLogRequest.getBody() +
                                                        "\n - RequestType :" + errorLogRequest.getRequestType()));
                } else if (level.equalsIgnoreCase("debug")) {
                        LOGGER.debug(loggerEncoderUtil
                                        .encode("[ UserName: " + username + " ] " +
                                                        "\n - Error :" + errorLogRequest.getError() +
                                                        "\n - Message :" + errorLogRequest.getMessage() +
                                                        "\n - URL :" + errorLogRequest.getUrl() +
                                                        "\n - Body :" + errorLogRequest.getBody() +
                                                        "\n - RequestType :" + errorLogRequest.getRequestType()));
                }
                return ResponseEntity.ok(errorLogRequest);
        }
}
