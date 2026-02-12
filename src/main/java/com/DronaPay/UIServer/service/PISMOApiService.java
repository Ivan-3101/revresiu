package com.DronaPay.UIServer.service;

import org.json.JSONObject;
import org.springframework.http.ResponseEntity;

import java.io.IOException;
import java.net.http.HttpResponse;;

public interface PISMOApiService {

    public ResponseEntity<String> getAccessToken(String server_key, String server_secret, String account_id) throws IOException, InterruptedException;

    public ResponseEntity<String> getAccountDetails(String token, String account_id)
            throws IOException, InterruptedException;

    public ResponseEntity<String> getCustomerDetails(String token, String customre_id)
            throws IOException, InterruptedException;

    public ResponseEntity<String> getPhoneDetails(String token, String account_id,String phone_id)
            throws IOException, InterruptedException;

}
