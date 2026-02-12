package com.DronaPay.UIServer.service.ApiServices;

import java.net.http.HttpResponse;

import com.DronaPay.UIServer.model.TransactionClassesUI;
import org.springframework.http.ResponseEntity;

public interface TransactionClassApiService {
    
    public ResponseEntity<String> addTransactionClass(TransactionClassesUI transactionClassesUI) throws Exception;

    public ResponseEntity<String> editTransactionClass(TransactionClassesUI transactionClassesUIi) throws Exception;

    public ResponseEntity<String> getTransactionClass(String apikey, String classname) throws Exception;

    public ResponseEntity<String> deleteTransactionClass(String apikey, String classname) throws Exception;
}
