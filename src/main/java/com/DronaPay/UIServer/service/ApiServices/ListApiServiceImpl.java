package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.model.ListReplica;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
@Slf4j
public class ListApiServiceImpl implements ListApiService {


    @Value("${springapi.server.url}")
    private String spring_api_url;


    @Autowired
    private TenantRepositoryService tenantRepositoryService;


    public ResponseEntity<String> addlist(String body, Integer itenantid) {
        System.out.println(body);
//
//        return WebClient.create(spring_api_url).post().uri("/lists")
//                //.header(env.getProperty("score.server.key.name"), env.getProperty("score.server.key"))
//                .header("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid))
//                .header("{ \"Content-Type\":\"application/json\"}").contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON).body(BodyInserters.fromValue(body)).exchange()
//                .block();
//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> res = restTemplate.exchange(
                spring_api_url + "/lists",
                HttpMethod.POST, entity, String.class);
        return res;
    }


    public ResponseEntity<String> deleteList(ListReplica input) {

//        return WebClient.create(spring_api_url).delete()
//                .uri("/lists/" + input.getVcExternalListItemId())
//                //.header(env.getProperty("score.server.key.name"), env.getProperty("score.server.key"))
//                .header("X-API-Key", tenantRepositoryService.findAPIKeyTenant(input.getIlistType().getId().getItenantId().getItenantid()))
//                .header("{ \"Content-Type\":\"application/json\"}")
//                .exchange().block();


//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(input.getIlistType().getId().getItenantId().getItenantid()));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        ResponseEntity<String> res = restTemplate.exchange(
                spring_api_url + "/lists/" + input.getVcExternalListItemId(),
                HttpMethod.DELETE, entity, String.class);
        return res;
    }


}
