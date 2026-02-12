package com.DronaPay.UIServer.service.ApiServices;

import com.DronaPay.UIServer.model.Rules;
import com.DronaPay.UIServer.requests.AddRuleApiRequest;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Service
public class RuleApiServiceImpl implements RuleApiServices {

    @Value("${springapi.server.url}")
    private String spring_api_url;


    @Value("${rules.topic}")
    private String rules_topic;


    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Override
    public ResponseEntity<String> addRule(Rules rulesTemp, Integer itenantid) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(AddRuleApiRequest.parseRuleTmepToAddRuleApiRequest(rulesTemp, "A"));
//        if (rulesTemp.getGetStartRule() != 0) {
//            JSONObject jsonObject = new JSONObject(json);
//            jsonObject.put("StartRule", rulesTemp.getGetStartRule());
//            json = jsonObject.toString();
//        }
//        System.out.println("add request body " + json);
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/arb/" + rules_topic + "_" + itenantid + "/"
//                                + rulesTemp.getIRuleID()))
//                //.header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid))
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(AddRuleApiRequest.parseRuleTmepToAddRuleApiRequest(rulesTemp, "A"));
        if (rulesTemp.getGetStartRule() != 0) {
            JSONObject jsonObject = new JSONObject(json);
            jsonObject.put("StartRule", rulesTemp.getGetStartRule());
            json = jsonObject.toString();
        }
        System.out.println("add request body " + json);
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/arb/" + rules_topic + "_" + itenantid + "/" + rulesTemp.getIRuleID(),
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }

    @Override
    public ResponseEntity<String> editRule(Rules rulesTemp, Integer itenantid) throws Exception {
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(AddRuleApiRequest.parseRuleTmepToAddRuleApiRequest(rulesTemp, "M"));
//        if (rulesTemp.getGetStartRule() != 0) {
//            JSONObject jsonObject = new JSONObject(json);
//            jsonObject.put("StartRule", rulesTemp.getGetStartRule());
//            json = jsonObject.toString();
//        }
//        System.out.println("edit requet body " + json);
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/arb/" + rules_topic + "_" + itenantid + "/"
//                                + rulesTemp.getIRuleID()))
//                //.header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid))
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(AddRuleApiRequest.parseRuleTmepToAddRuleApiRequest(rulesTemp, "M"));
        if (rulesTemp.getGetStartRule() != 0) {
            JSONObject jsonObject = new JSONObject(json);
            jsonObject.put("StartRule", rulesTemp.getGetStartRule());
            json = jsonObject.toString();
        }
        System.out.println("edit request body " + json);
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/arb/" + rules_topic + "_" + itenantid + "/" + rulesTemp.getIRuleID(),
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }

    @Override
    public ResponseEntity<String> deleteRule(Rules rulesTemp, Integer itenantid) throws Exception {
        rulesTemp.setBdelete(false);
        ResponseEntity<String> edited = editRule(rulesTemp, itenantid);
        if (edited.getStatusCode() != HttpStatus.OK) {
            return edited;
        }
        rulesTemp.setBdelete(true);
//        HttpClient client = HttpClient.newHttpClient();
//        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
//        String json = ow.writeValueAsString(DeleteRuleApiRequest.parseRuleTemp(rulesTemp));
//        System.out.println("Rule id of deleted rule " + rulesTemp.getIRuleID());
//        System.out.println(json);
//        // System.out.println(json.toString());
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(
//                        spring_api_url + "/arb/" + rules_topic + "_" + itenantid + "/"
//                                + rulesTemp.getIRuleID()))
//                //.header("X-API-Key", env.getProperty("score.server.key"))
//                .header("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid))
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers
//                        .ofString(json))
//                .build();
//        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//        return response;
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(AddRuleApiRequest.parseRuleTmepToAddRuleApiRequest(rulesTemp, "X"));
        System.out.println("Rule id of deleted rule " + rulesTemp.getIRuleID());
        System.out.println(json);
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-API-Key", tenantRepositoryService.findAPIKeyTenant(itenantid));
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(json, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                spring_api_url + "/arb/" + rules_topic + "_" + itenantid + "/" + rulesTemp.getIRuleID(),
                HttpMethod.POST,
                entity,
                String.class
        );
        return response;
    }
}
