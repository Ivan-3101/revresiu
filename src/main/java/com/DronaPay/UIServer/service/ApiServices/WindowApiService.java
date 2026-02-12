package com.DronaPay.UIServer.service.ApiServices;

import java.net.http.HttpResponse;

import com.DronaPay.UIServer.requests.AddWindowApiRequest;
import org.springframework.http.ResponseEntity;


public interface WindowApiService {
    
    public ResponseEntity<String> addWindowApi(String apikey, AddWindowApiRequest addWindowApiRequest) throws Exception;

    public ResponseEntity<String> deactivateWindow(String apikey, Integer id) throws Exception;
}
