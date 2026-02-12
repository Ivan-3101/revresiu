package com.DronaPay.UIServer.response.Records;

public record ClientLogin(String token, String tokentype, Integer expirein) {
}
