package com.DronaPay.UIServer.service.ApiServices;

import org.springframework.http.ResponseEntity;

import java.util.List;

public interface MlModelApiService {

    public ResponseEntity<String> getTrainedModels(List<Integer> tenantids) throws Exception;
}
