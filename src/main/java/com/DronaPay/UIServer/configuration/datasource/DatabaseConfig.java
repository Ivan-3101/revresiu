package com.DronaPay.UIServer.configuration.datasource;

import com.DronaPay.UIServer.Constants.Enum.DatabaseType;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.util.*;

@Configuration
public class DatabaseConfig {

    private static final Logger LOGGER = LoggerFactory.getLogger(DatabaseConfig.class);

    @Autowired
    private Environment env;

    @Bean
    @Primary
    public DataSource primaryDataSource() {
        return dataSourceMap().get(DatabaseType.POSTGRESQL_TRANSACTIONAL);
    }

    @Bean
    public Map<DatabaseType, DataSource> dataSourceMap() {
        Map<DatabaseType, DataSource> dataSources = new EnumMap<>(DatabaseType.class);

        for (DatabaseType dbType : DatabaseType.values()) {
            String prefix = "jdbc." + dbType.toFormattedString();
            if (hasRequiredProperties(prefix)) {
                System.out.println("Creating JdbcTemplate beans...");
                dataSources.put(dbType, createHikariDataSource(prefix));
            } else {
                LOGGER.warn("Skipping database {} due to missing properties.", dbType);
            }
        }

        return dataSources;
    }

    @Bean
    @Primary
    public Map<DatabaseType, JdbcTemplate> jdbcTemplateMap() {
        Map<DatabaseType, JdbcTemplate> templates = new EnumMap<>(DatabaseType.class);
        dataSourceMap().forEach((type, source) -> templates.put(type, new JdbcTemplate(source)));
        return templates;
    }

    private DataSource createHikariDataSource(String prefix) {
        try {
            HikariConfig config = new HikariConfig();
            config.setPoolName(prefix + "-pool");
            config.setDriverClassName(env.getRequiredProperty(prefix + ".driverClassName"));
            config.setJdbcUrl(env.getRequiredProperty(prefix + ".url"));
            config.setUsername(env.getRequiredProperty(prefix + ".username"));
            config.setPassword(env.getRequiredProperty(prefix + ".password"));
            config.setMinimumIdle(Integer.parseInt(env.getProperty("spring.datasource.hikari.minimumIdle", "2")));
            config.setMaximumPoolSize(Integer.parseInt(env.getProperty("spring.datasource.hikari.maximumPoolSize", "10")));

            return new HikariDataSource(config);
        } catch (Exception e) {
            LOGGER.error("Failed to create Hikari DataSource for prefix: {}", prefix, e);
            throw new RuntimeException("Error initializing DataSource for: " + prefix, e);
        }
    }

    private boolean hasRequiredProperties(String prefix) {
        return env.containsProperty(prefix + ".driverClassName") &&
                env.containsProperty(prefix + ".url") &&
                env.containsProperty(prefix + ".username") &&
                env.containsProperty(prefix + ".password");
    }
}
