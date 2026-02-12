package com.DronaPay.UIServer.Constants.Enum;

public enum DatabaseType {
    POSTGRESQL_TRANSACTIONAL(1),
    POSTGRESQL_ANALYTICS(2),
    TRINO_DATALAKE(3);

    private final int value;

    DatabaseType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static DatabaseType fromValue(int value) {
        for (DatabaseType type : DatabaseType.values()) {
            if (type.getValue() == value) {
                return type;
            }
        }
        throw new IllegalArgumentException("Unknown database type: " + value);
    }

    public String toFormattedString() {
        return this.name().toLowerCase().replace("_", ".");
    }
}

