package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.model.ListReplica;
import org.springframework.http.ResponseEntity;

public interface ListApiService {

    public ResponseEntity<String> addlist(String body, Integer itenantid);


    public ResponseEntity<String> deleteList(ListReplica input);
}
