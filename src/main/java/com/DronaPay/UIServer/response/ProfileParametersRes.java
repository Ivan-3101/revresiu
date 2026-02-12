package com.DronaPay.UIServer.response; 
import java.util.*;
import lombok.Data;

@Data
public class ProfileParametersRes {
    private Map<String, Object> payerVpa;
    private Map<String, Object> payeeVpa;
    private Map<String, Object> payerAccount;
    private Map<String, Object> payeeAccount;
}