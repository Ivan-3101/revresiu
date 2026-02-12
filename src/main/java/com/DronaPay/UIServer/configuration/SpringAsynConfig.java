package com.DronaPay.UIServer.configuration;

import java.util.concurrent.Executor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

@Configuration
@EnableAsync
public class SpringAsynConfig {


    @Value("${TaskScheduler.MaxThread.PoolSize:10}")
    private int maxPoolSize;

    @Value("${Async.CorePoolSize:5}")
    private int corePoolSize;

    @Value("${Async.MaxPoolSize:10}")
    private int asyncMaxPoolSize;

    @Value("${Async.QueueCapacity:100}")
    private int queueCapacity;

    @Bean(name = "threadPoolTaskExecutor")
    Executor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(corePoolSize);
        executor.setMaxPoolSize(asyncMaxPoolSize);
        executor.setQueueCapacity(queueCapacity);
        executor.setThreadNamePrefix("Task Pool Thread -");
        executor.initialize();
        return executor;
    }

    @Bean
    public ThreadPoolTaskScheduler taskScheduler() {
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        scheduler.setPoolSize(maxPoolSize); // thread pool like your executor
        scheduler.setThreadNamePrefix("Task-Scheduler-");
        return scheduler;
    }

}
