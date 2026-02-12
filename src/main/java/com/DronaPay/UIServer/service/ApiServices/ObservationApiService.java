package com.DronaPay.UIServer.service.ApiServices;

import java.net.http.HttpResponse;

import com.DronaPay.UIServer.requests.AddObservationApiRequest;
import org.springframework.http.ResponseEntity;

public interface ObservationApiService {
    
    public ResponseEntity<String> addObservation(String apikey, AddObservationApiRequest addObservationApiRequest, Integer wId) throws Exception;

    public ResponseEntity<String>  deleteObservation(String apikey, Integer oId,Integer wId) throws Exception;
}
