package com.DronaPay.UIServer.util;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import org.json.simple.JSONObject;
@Service
public class ExternalApiUtil {
    public ClientResponse ExternalApiPost(
            String url,
            String uri,
            String header,
            String body) throws Exception
    {
       return WebClient.create(url)
                .post()
                .uri( uri )
                .header(header)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .body(BodyInserters.fromValue(body))
                .exchange()
                .block();
    }

    public ClientResponse ExternalApiPostWithoutHeader(
            String url,
            String uri,
            Object body) throws Exception
    {

        return WebClient.create(url)
                .post()
                .uri( uri )
                .header("{ \"Content-Type\":\"application/json\"}")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .body(BodyInserters.fromValue(body.toString()))
                .exchange()
                .block();
    }
}
