package com.DronaPay.UIServer.Logging;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class HeartbeatLogger {

    private static final Logger logger = LoggerFactory.getLogger(HeartbeatLogger.class);

    @Scheduled(fixedRateString = "${heartbeat.interval}")
    public void logHeartbeat() {
        logger.info("✅ Heartbeat: Application is alive at {}", System.currentTimeMillis());
    }
}
