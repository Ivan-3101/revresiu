package com.DronaPay.UIServer.service.ApiServices;

import org.springframework.http.ResponseEntity;

import java.net.http.HttpResponse;

public interface SanctionApiService {

    ResponseEntity<String> search(String search_body) throws Exception;

    ResponseEntity<String> fetch(String search_body) throws Exception;

}
