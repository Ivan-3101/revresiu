package com.DronaPay.UIServer.service.ApiServices;

import java.net.http.HttpResponse;

import com.DronaPay.UIServer.model.Rules;
import org.springframework.http.ResponseEntity;

public interface RuleApiServices {
    
    public ResponseEntity<String> addRule(Rules rulesTemp, Integer itenantid) throws Exception;

    public ResponseEntity<String> editRule(Rules rulesTemp, Integer itenantid) throws Exception;

    public ResponseEntity<String> deleteRule(Rules rulesTemp, Integer itenantid) throws Exception;
}
