package com.DronaPay.UIServer.service;


public interface Audit<T> {
    public abstract T saveAudit(T input);
}
