package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WebUserAudit;
import com.DronaPay.UIServer.requests.CamundaRequests.AddComment;
import com.DronaPay.UIServer.requests.CamundaRequests.CamundaRequestVO.CamundaProfile;
import com.DronaPay.UIServer.requests.CamundaRequests.NewCamundaUser;
import com.DronaPay.UIServer.requests.CreateAuthorization;
import com.DronaPay.UIServer.requests.GetTaskListRequest;
import com.DronaPay.UIServer.requests.LoadMoreTaskListRequest;
import com.DronaPay.UIServer.service.ApiServices.PineLabAPIServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.WorkflowMasterService;
import com.DronaPay.UIServer.util.CamundaBasicAuthUtil;
import com.DronaPay.UIServer.util.FilePathChecker;
import com.DronaPay.UIServer.util.RestTemplateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClientBuilder;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.client.MultipartBodyBuilder;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.http.codec.ClientCodecConfigurer;
import org.springframework.stereotype.Service;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.DefaultUriBuilderFactory;
import org.springframework.util.MultiValueMap;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.util.UriComponentsBuilder;
import reactor.core.publisher.Mono;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;
import java.util.function.Consumer;
import java.util.stream.Collectors;

@Service
public class CamundaServiceImpl implements CamundaService {

    final Consumer<ClientCodecConfigurer> consumer = configurer -> {
        final ClientCodecConfigurer.ClientDefaultCodecs codecs = configurer.defaultCodecs();
        codecs.maxInMemorySize(20 * 1024 * 1024);
    };

    private static final Logger LOGGER = LoggerFactory.getLogger(CamundaServiceImpl.class);

    @Autowired
    private CamundaBasicAuthUtil camundaBasicAuthUtil;
    @Autowired
    private FilePathChecker filePathChecker;

    @Value("${camunda.server.url}")
    private String camundaURL;

    @Value("${file.upload-dir}")
    private String attachement_dir;

    @Autowired
    private WorkflowMasterService workflowMasterService;

    // @Autowired
    // private UriBuilder uriBuilder;

    public ResponseEntity<String> addNewUser(NewCamundaUser body, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/user/create")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(Mono.just(body), NewCamundaUser.class)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<NewCamundaUser> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/user/create",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> createAuthorization(CreateAuthorization body, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/authorization/create")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(Mono.just(body), NewCamundaUser.class)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<CreateAuthorization> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/authorization/create",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> mapToGroup(WebUserAudit user, WebUser loggedIn, String groupid) throws Exception {
//        return WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/group/" + groupid + "/members/"
//                        + user.getIUserID().toString())
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedIn))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedIn));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/group/" + groupid + "/members/" + user.getIUserID().toString(),
                HttpMethod.PUT,
                entity,
                String.class
        );

    }

    @Override
    public ResponseEntity<String> mapToTenant(WebUserAudit wua, WebUser loggedIn, String tenantid) throws Exception {
//        return WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/tenant/" + tenantid + "/user-members/"
//                        + wua.getIUserID().toString())
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedIn))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedIn));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/tenant/" + tenantid + "/user-members/" + wua.getIUserID().toString(),
                HttpMethod.PUT,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> deleteUserTenant(WebUserAudit wua, WebUser loggedin, String tenantid) throws Exception {
//        return WebClient.create(camundaURL)
//                .delete()
//                .uri("/engine-rest/tenant/" + tenantid + "/user-members/" + wua.getIUserID().toString())
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedin))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedin));
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/tenant/" + tenantid + "/user-members/" + wua.getIUserID().toString(),
                HttpMethod.DELETE,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> deleteUser(WebUserAudit user, WebUser loggedin) throws Exception {
//        return WebClient.create(camundaURL)
//                .delete()
//                .uri("/engine-rest/user/" + user.getIUserID().toString())
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedin))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedin));
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/user/" + user.getIUserID().toString(),
                HttpMethod.DELETE,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> deleteUserGroup(WebUserAudit user, WebUser loggedin, String groupName) throws Exception {
//        return WebClient.create(camundaURL)
//                .delete()
//                .uri("/engine-rest/group/" + groupName + "/members/" + user.getIUserID().toString())
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedin))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedin));
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/group/" + groupName + "/members/" + user.getIUserID().toString(),
                HttpMethod.DELETE,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getTaskList(String parameters, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task" + parameters)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task" + parameters,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> claimTask(String taskid, String processInstanceId, WebUser user) throws Exception {

//        ClientResponse varUpdate = WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue("{\"value\":\"{\\n  \\\"user\\\":\\\""
//                        + user.getIuserID()
//                        + "\\\",\\n  \\\"id\\\":\\\"" + taskid
//                        + "\\\",\\n  \\\"action\\\":\\\"Claim\\\"\\n}\",\"type\":\"String\"}"))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        String varUpdateBody = "{\"value\":\"{\\n  \\\"user\\\":\\\""
                + user.getIuserID()
                + "\\\",\\n  \\\"id\\\":\\\"" + taskid
                + "\\\",\\n  \\\"action\\\":\\\"Claim\\\"\\n}\",\"type\":\"String\"}";
        HttpEntity<String> varUpdateEntity = new HttpEntity<>(varUpdateBody, headers);
        ResponseEntity<String> varUpdate = restTemplate.exchange(
                camundaURL + "/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity",
                HttpMethod.PUT,
                varUpdateEntity,
                String.class
        );
        if (varUpdate.getStatusCode() == HttpStatus.NO_CONTENT) {
//            varUpdate.releaseBody();
//            return WebClient.create(camundaURL)
//                    .post()
//                    .uri("/engine-rest/task/" + taskid + "/claim")
//                    .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                    .contentType(MediaType.APPLICATION_JSON)
//                    .accept(MediaType.APPLICATION_JSON)
//                    .body(BodyInserters.fromValue("{\"userId\": \"" + user.getIuserID() + "\"}"))
//                    .exchange()
//                    .block();
            String claimTaskBody = "{\"userId\": \"" + user.getIuserID() + "\"}";
            HttpEntity<String> claimTaskEntity = new HttpEntity<>(claimTaskBody, headers);
            return restTemplate.exchange(
                    camundaURL + "/engine-rest/task/" + taskid + "/claim",
                    HttpMethod.POST,
                    claimTaskEntity,
                    String.class
            );
        } else {
            return varUpdate;
        }

    }

    public ResponseEntity<String> unClaimTask(String taskid, String processInstanceId, WebUser user) throws Exception {
//        ClientResponse varUpdate = WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue("{\"value\":\"{\\n  \\\"user\\\":\\\""
//                        + user.getIuserID()
//                        + "\\\",\\n  \\\"id\\\":\\\"" + taskid
//                        + "\\\",\\n  \\\"action\\\":\\\"Unclaim\\\"\\n}\",\"type\":\"String\"}"))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        String varUpdateBody = "{\"value\":\"{\\n  \\\"user\\\":\\\""
                + user.getIuserID()
                + "\\\",\\n  \\\"id\\\":\\\"" + taskid
                + "\\\",\\n  \\\"action\\\":\\\"Unclaim\\\"\\n}\",\"type\":\"String\"}";
        HttpEntity<String> varUpdateEntity = new HttpEntity<>(varUpdateBody, headers);
        ResponseEntity<String> varUpdate = restTemplate.exchange(
                camundaURL + "/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity",
                HttpMethod.PUT,
                varUpdateEntity,
                String.class
        );
        if (varUpdate.getStatusCode() == HttpStatus.NO_CONTENT) {
//            varUpdate.releaseBody();
//            return WebClient.create(camundaURL)
//                    .post()
//                    .uri("/engine-rest/task/" + taskid + "/unclaim")
//                    .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                    .contentType(MediaType.APPLICATION_JSON)
//                    .accept(MediaType.APPLICATION_JSON)
//                    .body(BodyInserters.fromValue("{\"userId\": \"" + user.getIuserID() + "\"}"))
//                    .exchange()
//                    .block();
            String unClaimTaskBody = "{\"userId\": \"" + user.getIuserID() + "\"}";
            HttpEntity<String> unClaimTaskEntity = new HttpEntity<>(unClaimTaskBody, headers);
            return restTemplate.exchange(
                    camundaURL + "/engine-rest/task/" + taskid + "/unclaim",
                    HttpMethod.POST,
                    unClaimTaskEntity,
                    String.class
            );
        } else {
            return varUpdate;
        }
    }

    public ResponseEntity<String> reassignTask(String taskid, String processInstanceId, WebUser assignedUser,
                                               WebUser reassignUser) {
//        ClientResponse varUpdate = WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(assignedUser))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue("{\"value\":\"{\\n  \\\"user\\\":\\\""
//                        + assignedUser.getIuserID()
//                        + "\\\",\\n  \\\"id\\\":\\\"" + taskid
//                        + "\\\",\\n  \\\"action\\\":\\\"Reassigned to "
//                        + reassignUser.getVcUserName()
//                        + "\\\"\\n}\",\"type\":\"String\"}"))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(assignedUser));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        String varUpdateBody = "{\"value\":\"{\\n  \\\"user\\\":\\\""
                + assignedUser.getIuserID()
                + "\\\",\\n  \\\"id\\\":\\\"" + taskid
                + "\\\",\\n  \\\"action\\\":\\\"Reassigned to "
                + reassignUser.getVcUserName()
                + "\\\"\\n}\",\"type\":\"String\"}";
        HttpEntity<String> varUpdateEntity = new HttpEntity<>(varUpdateBody, headers);
        ResponseEntity<String> varUpdate = restTemplate.exchange(
                camundaURL + "/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity",
                HttpMethod.PUT,
                varUpdateEntity,
                String.class
        );
        if (varUpdate.getStatusCode() == HttpStatus.NO_CONTENT) {
//            varUpdate.releaseBody();
//            ClientResponse unClaim = WebClient.create(camundaURL)
//                    .post()
//                    .uri("/engine-rest/task/" + taskid + "/unclaim")
//                    .header("Authorization", camundaBasicAuthUtil.getBasicAuth(assignedUser))
//                    .contentType(MediaType.APPLICATION_JSON)
//                    .accept(MediaType.APPLICATION_JSON)
//                    .body(BodyInserters.fromValue(
//                            "{\"userId\": \"" + assignedUser.getIuserID() + "\"}"))
//                    .exchange()
//                    .block();
            String unClaimBody = "{\"userId\": \"" + assignedUser.getIuserID() + "\"}";
            HttpEntity<String> unClaimEntity = new HttpEntity<>(unClaimBody, headers);
            ResponseEntity<String> unClaim = restTemplate.exchange(
                    camundaURL + "/engine-rest/task/" + taskid + "/unclaim",
                    HttpMethod.POST,
                    unClaimEntity,
                    String.class
            );
            if (unClaim.getStatusCode() == HttpStatus.NO_CONTENT) {
//                unClaim.releaseBody();
//                return WebClient.create(camundaURL)
//                        .post()
//                        .uri("/engine-rest/task/" + taskid + "/claim")
//                        .header("Authorization",
//                                camundaBasicAuthUtil.getBasicAuth(reassignUser))
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .accept(MediaType.APPLICATION_JSON)
//                        .body(BodyInserters.fromValue("{\"userId\": \""
//                                + reassignUser.getIuserID() + "\"}"))
//                        .exchange()
//                        .block();
                String claimBody = "{\"userId\": \"" + reassignUser.getIuserID() + "\"}";
                HttpEntity<String> claimEntity = new HttpEntity<>(claimBody, headers);
                return restTemplate.exchange(
                        camundaURL + "/engine-rest/task/" + taskid + "/claim",
                        HttpMethod.POST,
                        claimEntity,
                        String.class
                );
            } else {
                return unClaim;
            }
        } else {
            return varUpdate;
        }
    }

    public ResponseEntity<String> getComments(String taskid, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task/" + taskid + "/comment")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/comment",
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> addComment(AddComment addComment, WebUser user) throws Exception {
        // org.json.JSONObject comment = new org.json.JSONObject();
        // comment.put("user", user.getIuserID());
        // comment.put("message", addComment.getMessage());
        // addComment.setMessage(comment.toString(4));
        ObjectMapper mapper = new ObjectMapper();
        ObjectNode comment = mapper.createObjectNode();
        comment.put("user", user.getIuserID());
        comment.put("message", addComment.getMessage());
        addComment.setMessage(comment.toString());
        // addComment.setMessage("{\n \"user\":\"" + user.getIuserID() + "\",\n
        // \"message\":\""
        // + addComment.getMessage().replace("\n", "\\n") + "\"\n}");
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task/" + addComment.getTaskid() + "/comment/create")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .body(Mono.just(addComment), AddComment.class)
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<AddComment> entity = new HttpEntity<>(addComment, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + addComment.getTaskid() + "/comment/create",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> addAttachment(MultipartFile file,
                                                String id,
                                                String attachmentName,
                                                String attachmentDescription,
                                                String attachmentType,
                                                String url,
                                                WebUser user) throws Exception {
        MultipartBodyBuilder builder = new MultipartBodyBuilder();
        builder.part("attachment-name", attachmentName == null ? "" : attachmentName);
        builder.part("attachment-description",
                attachmentDescription == null
                        ? "{\n  \"user\":\"" + user.getIuserID()
                        + "\",\n  \"description\":\"\"\n}"
                        : "{\n  \"user\":\"" + user.getIuserID()
                        + "\",\n  \"description\":\""
                        + attachmentDescription + "\"\n}");
        builder.part("attachment-type", attachmentType == null ? "" : attachmentType);
        builder.part("url", url == null ? "" : url);
        builder.part("content", file.getResource());

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        builder.build().forEach((key, value) -> body.add(key, value.get(0)));
//        MultiValueMap<String, Object> body = builder.build();

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task/" + id + "/attachment/create")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.MULTIPART_FORM_DATA)
//                .body(BodyInserters.fromMultipartData(builder.build()))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<MultiValueMap<String, Object>> entity = new HttpEntity<>(body, headers);
        System.out.println("BODY" + body);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + id + "/attachment/create",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getRenderedForm(String taskid, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task/" + taskid + "/rendered-form")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_XHTML_XML)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_XHTML_XML));
        HttpEntity<String> entity = new HttpEntity<>(headers);

        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/rendered-form",
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getFormVariable(String taskid, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task/" + taskid + "/form-variables?deserializeValues=false")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/form-variables?deserializeValues=false",
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> submitForm(String taskid, String processInstanceId, String body, WebUser user)
            throws Exception {

//        ClientResponse varUpdate = WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task/" + taskid + "/submit-form")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> varUpdate = restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/submit-form",
                HttpMethod.POST,
                entity,
                String.class
        );

        if (varUpdate.getStatusCode() == HttpStatus.NO_CONTENT) {

//            ClientResponse exist = WebClient.create(camundaURL)
//                    .get()
//                    .uri("/engine-rest/process-instance/" + processInstanceId)
//                    .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                    .accept(MediaType.APPLICATION_JSON)
//                    .exchange()
//                    .block();
            HttpHeaders headers1 = new HttpHeaders();
            headers1.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
            headers1.set("Accept", "application/json");
            ResponseEntity<String> exist = restTemplate.exchange(
                    camundaURL + "/engine-rest/process-instance/" + processInstanceId,
                    HttpMethod.GET,
                    new HttpEntity<>(headers1),
                    String.class
            );
            if (exist.getStatusCode() == HttpStatus.OK) {
//                ClientResponse temp = WebClient.create(camundaURL)
//                        .put()
//                        .uri("/engine-rest/process-instance/" + processInstanceId
//                                + "/variables/userActivity")
//                        .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .accept(MediaType.APPLICATION_JSON)
//                        .body(BodyInserters.fromValue("{\"value\":\"{\\n  \\\"user\\\":\\\""
//                                + user.getIuserID()
//                                + "\\\",\\n  \\\"id\\\":\\\"" + taskid
//                                + "\\\",\\n  \\\"action\\\":\\\"Submit\\\"\\n}\",\"type\":\"String\"}"))
//                        .exchange()
//                        .block();
//                temp.releaseBody();
                HttpEntity<String> updateEntity = new HttpEntity<>("{\"value\":\"{\\n  \\\"user\\\":\\\""
                        + user.getIuserID()
                        + "\\\",\\n  \\\"id\\\":\\\"" + taskid
                        + "\\\",\\n  \\\"action\\\":\\\"Submit\\\"\\n}\",\"type\":\"String\"}", headers);
                restTemplate.exchange(
                        camundaURL + "/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity",
                        HttpMethod.PUT,
                        updateEntity,
                        String.class
                );
            }
//            exist.releaseBody();
            return varUpdate;

        } else {
            return varUpdate;
        }
    }

    public ResponseEntity<String> addVariable(String taskid, JSONObject body, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/process-instance/" + taskid + "/variables")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body.toString()))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body.toString(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/process-instance/" + taskid + "/variables",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> submitFormJson(String taskid, JSONObject body, WebUser user) throws Exception {

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task/" + taskid + "/submit-form")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body.toString(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/submit-form",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getAttachment(String taskid, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task/" + taskid + "/attachment")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/attachment",
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getUserOperation(String taskid, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/history/user-operation?taskId=" + taskid)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/user-operation?taskId=" + taskid,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<byte[]> downloadAttachment(String taskid, String attachmentid, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task/" + taskid + "/attachment/" + attachmentid + "/data")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_OCTET_STREAM)
//                .retrieve()
//                .bodyToFlux(byte[].class);
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_OCTET_STREAM));
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/attachment/" + attachmentid + "/data",
                HttpMethod.GET,
                entity,
                byte[].class
        );
    }

//    public Resource downloadAttachmentFromInputStream(String taskid, String attachmentid, WebUser user)
//            throws Exception {
//        URLConnection url = new URL(camundaURL + "/engine-rest/task/" + taskid
//                + "/attachment/" + attachmentid + "/data").openConnection();
//        url.setRequestProperty("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
//        InputStream in = url.getInputStream();
//
//        long time = System.currentTimeMillis();
//        if (!filePathChecker.isValidPath(
//                attachement_dir + "//" + taskid + attachmentid + time)) {
//            throw new Exception("File path is invalid");
//        }
//
//        File file = new File(attachement_dir + "//" + taskid + attachmentid + time)
//                .getCanonicalFile();
//        copyInputStreamToFile(in, file);
//        filePathChecker.setPermissions(file.toPath());
//        Path fileStorageLocation = Paths.get(attachement_dir + "//").toAbsolutePath()
//                .normalize();
//        Path filePath = fileStorageLocation.resolve(taskid + attachmentid + time).toAbsolutePath().normalize();
//        Resource resource = new UrlResource(filePath.toUri());
//        return resource;
//
//    }

    public Resource downloadAttachmentFromInputStream(String taskid, String attachmentid, WebUser user)
            throws Exception {
        // === Security Validation ===
        if (!FilePathChecker.isValidUUID(taskid)){
            LOGGER.error("Invalid task ID format: {}", taskid);
            throw new Exception("Invalid task ID format");
        }
        if (!FilePathChecker.isValidUUID(attachmentid)) {
            LOGGER.error("Invalid attachment ID format: {}", attachmentid);
            throw new Exception("Invalid attachment ID format");
        }

        // === SSRF-Proof URL Construction ===
        URL camundaBaseUrl = new URL(camundaURL);
        URL requestUrl = new URL(camundaBaseUrl, "/engine-rest/task/" + taskid
                + "/attachment/" + attachmentid + "/data");

        // Block DNS rebinding attacks
        if (!requestUrl.getHost().equalsIgnoreCase(camundaBaseUrl.getHost())) {
            LOGGER.error("Host mismatch attempt");
            throw new Exception("Unauthorized service endpoint");
        }

        // === Secure File Handling ===
        URLConnection conn = requestUrl.openConnection();
        conn.setRequestProperty("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        InputStream in = conn.getInputStream();

        long time = System.currentTimeMillis();
        String filename = taskid + attachmentid + time;
        File dir = new File(attachement_dir);

        // === Path Traversal Protection ===
        File file = filePathChecker.sanitizePath(dir, filename);

        // Defense-in-depth with original validation
        if (!filePathChecker.isValidPath(file.getPath())) {
            LOGGER.error("Path validation failed");
            throw new Exception("File path validation failed");
        }

        copyInputStreamToFile(in, file);
        filePathChecker.setPermissions(file.toPath());
        Path fileStorageLocation = dir.toPath().toAbsolutePath().normalize();
        Path filePath = fileStorageLocation.resolve(file.getName()).normalize();
        return new UrlResource(filePath.toUri());
    }

    private void copyInputStreamToFile(InputStream inputStream, File file)
            throws IOException {
        try (FileOutputStream outputStream = new FileOutputStream(file, false)) {
            int read;
            byte[] bytes = new byte[8192];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }

    }

    public ResponseEntity<String> getVariableData(String taskid, String variablename, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task/" + taskid + "/variables/" + variablename + "/data")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_OCTET_STREAM)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/variables/" + variablename + "/data",
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getTaskGroups(String taskid, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task/" + taskid + "/identity-links")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/identity-links",
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getActivityInstance(String parameters, WebUser user) throws Exception {

//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL + "/engine-rest/history/activity-instance?" + parameters,
                HttpMethod.GET, entity, String.class);
        return res;
    }

    public ResponseEntity<String> getTaskHistory(String taskid, WebUser user) throws Exception {

//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/history/task?" + taskid)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/task?" + taskid,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getProcessDefinationList(String parameters, WebUser user) throws Exception {

//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/process-definition?" + parameters)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/process-definition?" + parameters,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> sendMessage(String body) throws Exception {

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/message/")
//                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/message/",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getClaimUnclaim(String parameters, WebUser user) throws Exception {

//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/history/user-operation?" + parameters)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/user-operation?" + parameters,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getHistoryDetail(String parameters, WebUser user) throws Exception {

//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL + "/engine-rest/history/detail?" + parameters,
                HttpMethod.GET, entity, String.class);
        return res;
    }

    @Override
    public ResponseEntity<String> getBPMN(String processDef, WebUser user) throws Exception {


//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL + "/engine-rest/process-definition/" + processDef + "/xml",
                HttpMethod.GET, entity, String.class);
        return res;
    }

    @Override
    public ResponseEntity<String> getStatestics(String processDef, String startDate, String endDate, WebUser user)
            throws Exception {

        String baseUrl = camundaURL;
        DefaultUriBuilderFactory factory = new DefaultUriBuilderFactory(baseUrl);
        factory.setEncodingMode(DefaultUriBuilderFactory.EncodingMode.NONE);

//        // Customize the RestTemplate..
//        RestTemplate restTemplate = new RestTemplate();
//        restTemplate.setUriTemplateHandler(factory);
//
//        // Customize the WebClient..
//        WebClient client = WebClient.builder().uriBuilderFactory(factory).build();
//
//        return client
//                .get()
//                .uri(uriBuilder -> uriBuilder
//                        .path("/engine-rest/history/process-definition/{processDef}/statistics")
//                        .queryParam("finished", false)
//                        .queryParam("startedBefore", URLEncoder.encode(endDate))
//                        .queryParam("startedAfter", URLEncoder.encode(startDate))
//                        .build(processDef))
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();

        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        restTemplate.setUriTemplateHandler(factory);
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromPath("/engine-rest/history/process-definition/{processDef}/statistics")
                .queryParam("finished", false)
                .queryParam("startedBefore", URLEncoder.encode(endDate, StandardCharsets.UTF_8))
                .queryParam("startedAfter", URLEncoder.encode(startDate, StandardCharsets.UTF_8));
        String url = uriBuilder.buildAndExpand(processDef).toUriString();
        System.out.println(url);
        return restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
    }

    @Override
    public ResponseEntity<String> getDefinition(String proessInstanceId, WebUser user) throws Exception {

//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/process-instance/" + proessInstanceId)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/process-instance/" + proessInstanceId,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> createTicket(String body, String key, WebUser user) throws Exception {

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/process-definition/key/" + key + "/start")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/process-definition/key/" + key + "/start",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> createTicket(String body, String key, String tenantid) throws Exception {

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/process-definition/key/" + key + "/tenant-id/" + tenantid + "/start")
//                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        headers.set("Accept", "application/json");
        headers.set("Content-Type", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/process-definition/key/" + key + "/tenant-id/" + tenantid + "/start",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getProcessDefinationDetails(String key, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/process-definition/key/" + key)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/process-definition/key/" + key,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    public ResponseEntity<String> getVariableInstance(String proessInstanceId, WebUser user)
            throws Exception {

//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/variable-instance?processInstanceIdIn=" + proessInstanceId)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/variable-instance?processInstanceIdIn=" + proessInstanceId,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getWorkFlowName(LoggedUser loggedUser) throws Exception {
        String tenantids = loggedUser.getUserTenant().stream().map(String::valueOf)
                .collect(Collectors.joining(","));
        String workflowKeys = String.join(",", loggedUser.getWorkflows()
                .stream()
                .map(wfl -> wfl.getWorkflowKey())
                .toList());

        String queryParams = "&tenantIdIn=" + tenantids;
        queryParams += "&keysIn=" + workflowKeys;

//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/process-definition?latestVersion=true" + queryParams)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedUser.getWebUser()))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(loggedUser.getWebUser()));
        headers.set("Accept", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/process-definition?latestVersion=true" + queryParams,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    @Override
    public Integer getCount(String url, String body, WebUser user) throws Exception {

//        ClientResponse clientResponse = WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest" + url)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
//        String responses = clientResponse.bodyToMono(String.class).block();
//        clientResponse.releaseBody();
//        if (clientResponse.statusCode() == HttpStatus.OK) {
//            org.json.JSONObject objectInArray = new JSONObject(responses);
//            return objectInArray.getInt("count");
//        } else {
//            return 0;
//        }
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> response = restTemplate.exchange(
                camundaURL + "/engine-rest" + url,
                HttpMethod.POST,
                entity,
                String.class
        );
        if (response.getStatusCode() == HttpStatus.OK) {
            org.json.JSONObject objectInArray = new JSONObject(response.getBody());
            return objectInArray.getInt("count");
        } else {
            return 0;
        }
    }

    @Override
    public ResponseEntity<String> getHistoryProcessInstance(String body, WebUser user) throws Exception {

        // return WebClient.create(camundaURL)
        // .post()
        // .uri("/engine-rest/history/process-instance")
        // .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
        // .contentType(MediaType.APPLICATION_JSON)
        // .accept(MediaType.APPLICATION_JSON)
        // .body(BodyInserters.fromValue(body))
        // .exchange()
        // .block();

//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL + "/engine-rest/history/process-instance",
                HttpMethod.POST, entity, String.class);
        return res;

    }

    @Override
    public ResponseEntity<String> getAllProcessInstance(String body, String max, WebUser user) throws Exception {

        // Flux<DataBuffer> databuffer =
        // WebClient.builder().baseUrl(camundaURL).build().post()
        // .uri("/engine-rest/history/process-instance").retrieve().bodyToFlux(DataBuffer.class);
        // ClientResponse.
        // DataBufferUtils.write(databuffer,)

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/history/process-instance?maxResults=" + max)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/process-instance?maxResults=" + max,
                HttpMethod.POST,
                entity,
                String.class
        );

    }

    @Override
    public ResponseEntity<String> getProcessInstance(String body) throws Exception {

        // Flux<DataBuffer> databuffer =
        // WebClient.builder().baseUrl(camundaURL).build().post()
        // .uri("/engine-rest/history/process-instance").retrieve().bodyToFlux(DataBuffer.class);

        // ClientResponse.

        // DataBufferUtils.write(databuffer,)

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/process-instance")
//                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/process-instance",
                HttpMethod.POST,
                entity,
                String.class
        );

    }

    @Override
    public ResponseEntity<String> getAllProcessInstance(String body, Integer max, WebUser user) throws Exception {

        // Flux<DataBuffer> databuffer =
        // WebClient.builder().baseUrl(camundaURL).build().post()
        // .uri("/engine-rest/history/process-instance").retrieve().bodyToFlux(DataBuffer.class);
        // ClientResponse.
        // DataBufferUtils.write(databuffer,)

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/history/process-instance?maxResults=" + max)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/process-instance?maxResults=" + max,
                HttpMethod.POST,
                entity,
                String.class
        );

    }

    @Override
    public ResponseEntity<String> getAllProcessInstanceCount(String body, WebUser user) throws Exception {

        // Flux<DataBuffer> databuffer =
        // WebClient.builder().baseUrl(camundaURL).build().post()
        // .uri("/engine-rest/history/process-instance").retrieve().bodyToFlux(DataBuffer.class);
        // ClientResponse.
        // DataBufferUtils.write(databuffer,)

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/history/process-instance/count")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/process-instance/count",
                HttpMethod.POST,
                entity,
                String.class
        );

    }

    @Override
    public ResponseEntity<String> getHistoricVariableInstance(String paramters, WebUser user) throws Exception {

//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/history/variable-instance?" + paramters)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/variable-instance?" + paramters,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getVariableInstance(String paramters) throws Exception {

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/variable-instance?deserializeValues=false")
//                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(paramters))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(paramters, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/variable-instance?deserializeValues=false",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getTaskListPost(GetTaskListRequest getTaskListRequest, WebUser user) throws Exception {
        // System.out.println(getTaskListRequest.getParameters());
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task?maxResults=" + getTaskListRequest.getMaxResult())
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(getTaskListRequest.getParameters()))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(getTaskListRequest.getParameters(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task?maxResults=" + getTaskListRequest.getMaxResult(),
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getTaskListPostCount(String parameter, WebUser user) throws Exception {
        // System.out.println(getTaskListRequest.getParameters());
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task/count")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(parameter))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(parameter, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/count",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getTaskListHistoryPostCount(String parameter, WebUser user) throws Exception {
        // System.out.println(getTaskListRequest.getParameters());
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/history/task/count")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(parameter))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(parameter, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/task/count",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getProcessInstHistoryPostCount(String parameter, WebUser user,
                                                                 List<String> listOfWorkflowKey) throws Exception {
        // System.out.println(getTaskListRequest.getParameters());

        JSONObject body = new JSONObject(parameter);
        body.put("processDefinitionKeyIn", listOfWorkflowKey);

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/history/process-instance/count")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body.toString()))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body.toString(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/history/process-instance/count",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getTaskListPostCount(JSONObject body) throws Exception {
        // System.out.println(getTaskListRequest.getParameters());
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task/count")
//                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body.toString()))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body.toString(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/count",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getTaskListPostLoadMore(LoadMoreTaskListRequest loadMoreTaskListRequest, WebUser user)
            throws Exception {
        // HttpClient client = HttpClient.newHttpClient();
        // HttpRequest request = HttpRequest.newBuilder()
        // .uri(URI.create(
        // camundaURL + "/engine-rest/task?"))
        // .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
        // .header("Content-Type", "application/json")
        // .POST(HttpRequest.BodyPublishers
        // .ofString(loadMoreTaskListRequest.getParameters()))
        // .build();
        // HttpResponse<String> response = client.send(request,
        // HttpResponse.BodyHandlers.ofString());
        // String lis = response.body();
        // System.out.println(lis);

        // String op=null;
        // System.out.println(DataBufferUtils.join(buffer).map(data->{
        // byte[] bytes = new byte[data.readableByteCount()];
        // data.read(bytes);
        // DataBufferUtils.release(data);
        // return bytes;
        // }).block());
        // DataBufferUtils.write(buffer, op,StandardOpenOption.CREATE)
        // buffer.next().

        // RestTemplate temp = new RestTemplate();
        // HttpHeaders headers = new HttpHeaders();
        // headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        // headers.set("Content-Type", "application/json");
        // HttpEntity<Object> entity = new
        // HttpEntity<>(loadMoreTaskListRequest.getParameters(), headers);
        // ResponseEntity<String> res = temp.exchange(
        // camundaURL + "/engine-rest/task?",
        // HttpMethod.POST, entity, String.class);
        // return res;

//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task?maxResults=" + loadMoreTaskListRequest.getMaxResult()
//                        + "&firstResult="
//                        + loadMoreTaskListRequest.getNextStartIndex())
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(loadMoreTaskListRequest.getParameters()))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(loadMoreTaskListRequest.getParameters(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task?maxResults=" + loadMoreTaskListRequest.getMaxResult()
                        + "&firstResult=" + loadMoreTaskListRequest.getNextStartIndex(),
                HttpMethod.POST,
                entity,
                String.class
        );

    }

    @Override
    public ResponseEntity<String> getTaskListPostLoadMoreHttp(LoadMoreTaskListRequest loadMoreTaskListRequest,
                                                              WebUser user)
            throws Exception {
        // HttpClient client = HttpClient.newHttpClient();
        // HttpRequest request = HttpRequest.newBuilder()
        // .uri(URI.create(
        // camundaURL + "/engine-rest/task?"))
        // .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
        // .header("Content-Type", "application/json")
        // .POST(HttpRequest.BodyPublishers
        // .ofString(loadMoreTaskListRequest.getParameters()))
        // .build();
        // HttpResponse<String> response = client.send(request,
        // HttpResponse.BodyHandlers.ofString());
        // String lis = response.body();
        // System.out.println(lis);

        // String op=null;
        // System.out.println(DataBufferUtils.join(buffer).map(data->{
        // byte[] bytes = new byte[data.readableByteCount()];
        // data.read(bytes);
        // DataBufferUtils.release(data);
        // return bytes;
        // }).block());
        // DataBufferUtils.write(buffer, op,StandardOpenOption.CREATE)
        // buffer.next().

//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(loadMoreTaskListRequest.getParameters(), headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL + "/engine-rest/task?maxResults="
                        + loadMoreTaskListRequest.getMaxResult()
                        + "&firstResult="
                        + loadMoreTaskListRequest.getNextStartIndex(),
                HttpMethod.POST, entity, String.class);
        return res;

        // return WebClient.create(camundaURL)
        // .post()
        // .uri("/engine-rest/task?maxResults=" + loadMoreTaskListRequest.getMaxResult()
        // + "&firstResult="
        // + loadMoreTaskListRequest.getNextStartIndex())
        // .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
        // .contentType(MediaType.APPLICATION_JSON)
        // .accept(MediaType.APPLICATION_JSON)
        // .body(BodyInserters.fromValue(loadMoreTaskListRequest.getParameters()))
        // .exchange()
        // .block();

    }

    @Override
    public ResponseEntity<String> getTaskListPostCodec(GetTaskListRequest getTaskListRequest, WebUser user)
            throws Exception {
//        return WebClient.builder().codecs(consumer).baseUrl(camundaURL).build()
//                .post()
//                .uri("/engine-rest/task?maxResults=" + getTaskListRequest.getMaxResult())
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(getTaskListRequest.getParameters()))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(getTaskListRequest.getParameters(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task?maxResults=" + getTaskListRequest.getMaxResult(),
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getTaskListPostHttp(GetTaskListRequest getTaskListRequest, WebUser user)
            throws Exception {

//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        System.out.println(getTaskListRequest.getParameters());
        HttpEntity<Object> entity = new HttpEntity<>(getTaskListRequest.getParameters(), headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL + "/engine-rest/task?maxResults="
                        + getTaskListRequest.getMaxResult(),
                HttpMethod.POST, entity, String.class);
        return res;
    }

    @Override
    public ResponseEntity<String> postHistoryDetail(String parameters, WebUser user) throws Exception {
//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(parameters, headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL
                        + "/engine-rest/history/detail?deserializeValues=false",
                HttpMethod.POST, entity, String.class);

        return res;
    }

    @Override
    public ResponseEntity<String> postHistoryVarInstance(String parameters, WebUser user) throws Exception {
//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(parameters, headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL
                        + "/engine-rest/history/variable-instance?deserializeValues=false",
                HttpMethod.POST, entity, String.class);

        return res;
    }

    @Override
    public ResponseEntity<String> getTaskListCompletedHttp(GetTaskListRequest getTaskListRequest, WebUser user,
                                                           List<String> listOfWorkflow)
            throws Exception {

        JSONObject body = new JSONObject(getTaskListRequest.getParameters());
        body.put("processDefinitionKeyIn", listOfWorkflow);

//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(body.toString(), headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL
                        + "/engine-rest/history/process-instance?maxResults="
                        + getTaskListRequest.getMaxResult(),
                HttpMethod.POST, entity, String.class);
        return res;
    }

    @Override
    public ResponseEntity<String> getTaskListCompletedHistoryHttp(GetTaskListRequest getTaskListRequest,
                                                                  WebUser user)
            throws Exception {
//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(getTaskListRequest.getParameters(), headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL
                        + "/engine-rest/history/task?maxResults="
                        + getTaskListRequest.getMaxResult(),
                HttpMethod.POST, entity, String.class);
        return res;
    }

    @Override
    public ResponseEntity<String> getDeployed(String taskid, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/task/" + taskid + "/deployed-form")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_XHTML_XML)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/xhtml+xml");
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/deployed-form",
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getTaskListPostHttp(String paramter, WebUser user) throws Exception {
//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        RestTemplate temp = new RestTemplate(rf);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        HttpEntity<Object> entity = new HttpEntity<>(paramter, headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL + "/engine-rest/task",
                HttpMethod.POST, entity, String.class);
        return res;
    }

    @Override
    public ResponseEntity<String> updateUser(CamundaProfile body, WebUser user) throws Exception {
//        return WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/user/" + body.getId() + "/profile")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(Mono.just(body), NewCamundaUser.class)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<CamundaProfile> entity = new HttpEntity<>(body, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/user/" + body.getId() + "/profile",
                HttpMethod.PUT,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> getFormVariableNew(String taskid, WebUser user) throws Exception {
//        SimpleClientHttpRequestFactory rf = new SimpleClientHttpRequestFactory();
//        rf.setBufferRequestBody(false);
//        CloseableHttpClient httpClient = HttpClientBuilder.create().disableAutomaticRetries().build();
//        HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory(httpClient);
//
//        RestTemplate temp = new RestTemplate(requestFactory);
        RestTemplate temp = RestTemplateUtil.createRestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Content-Type", "application/json");
       
//        temp.setErrorHandler(customResponseErrorHandler());
        
        HttpEntity<Object> entity = new HttpEntity<>(headers);
        ResponseEntity<String> res = temp.exchange(
                camundaURL + "/engine-rest/task/" + taskid
                        + "/form-variables?deserializeValues=true",
                HttpMethod.GET, entity, String.class);
        return res;
    }

    @Override
    public ResponseEntity<String> getWorkFlowNameAllDeployed(WebUser user, String keys, Integer tenantid) throws Exception {

//        return WebClient.create(camundaURL)
//                .get()
//                .uri("/engine-rest/process-definition?latestVersion=true&keysIn=" + keys
//                        + "&tenantIdIn=" + tenantid)
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuth(user))
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuth(user));
        headers.set("Accept", "application/json");
        String url = camundaURL + "/engine-rest/process-definition?latestVersion=true&keysIn=" + keys
                + "&tenantIdIn=" + tenantid;
        HttpEntity<String> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                url,
                HttpMethod.GET,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> createTenant(String tenantid, String tenantname) {
        JSONObject body = new JSONObject();
        body.put("id", tenantid);
        body.put("name", tenantname);
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/tenant/create")
//                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body.toString()))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body.toString(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/tenant/create",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> editTenant(String tenantid, String tenantname) {
        JSONObject body = new JSONObject();
        body.put("id", tenantid);
        body.put("name", tenantname);

//        return WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/tenant/" + tenantid)
//                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body.toString()))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body.toString(), headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/tenant/" + tenantid,
                HttpMethod.PUT,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> deleteTenant(String tenantid) {
//        return WebClient.create(camundaURL)
//                .delete()
//                .uri("/engine-rest/tenant/" + tenantid)
//                .header("Authorization", camundaBasicAuthUtil.getFrmuser())
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getFrmuser());
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/tenant/" + tenantid,
                HttpMethod.DELETE,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> claimTaskOpen(String taskid, String processInstanceId, String user) throws Exception {
//        ClientResponse varUpdate = WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue("{\"value\":\"{\\n  \\\"user\\\":\\\""
//                        + user
//                        + "\\\",\\n  \\\"id\\\":\\\"" + taskid
//                        + "\\\",\\n  \\\"action\\\":\\\"Claim\\\"\\n}\",\"type\":\"String\"}"))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        String body = "{\"value\":\"{\\n  \\\"user\\\":\\\""
                + user
                + "\\\",\\n  \\\"id\\\":\\\"" + taskid
                + "\\\",\\n  \\\"action\\\":\\\"Claim\\\"\\n}\",\"type\":\"String\"}";
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> varUpdate = restTemplate.exchange(
                camundaURL + "/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity",
                HttpMethod.PUT,
                entity,
                String.class
        );
        if (varUpdate.getStatusCode() == HttpStatus.NO_CONTENT) {
//            varUpdate.releaseBody();
//            return WebClient.create(camundaURL)
//                    .post()
//                    .uri("/engine-rest/task/" + taskid + "/claim")
//                    .header("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user))
//                    .contentType(MediaType.APPLICATION_JSON)
//                    .accept(MediaType.APPLICATION_JSON)
//                    .body(BodyInserters.fromValue("{\"userId\": \"" + user + "\"}"))
//                    .exchange()
//                    .block();
            body = "{\"userId\": \"" + user + "\"}";
            entity = new HttpEntity<>(body, headers);
            return restTemplate.exchange(
                    camundaURL + "/engine-rest/task/" + taskid + "/claim",
                    HttpMethod.POST,
                    entity,
                    String.class
            );
        } else {
            return varUpdate;
        }
    }

    @Override
    public ResponseEntity<String> unClaimTaskOpen(String taskid, String processInstanceId, String user) throws Exception {
//        ClientResponse varUpdate = WebClient.create(camundaURL)
//                .put()
//                .uri("/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue("{\"value\":\"{\\n  \\\"user\\\":\\\""
//                        + user
//                        + "\\\",\\n  \\\"id\\\":\\\"" + taskid
//                        + "\\\",\\n  \\\"action\\\":\\\"Unclaim\\\"\\n}\",\"type\":\"String\"}"))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        String body = "{\"value\":\"{\\n  \\\"user\\\":\\\""
                + user
                + "\\\",\\n  \\\"id\\\":\\\"" + taskid
                + "\\\",\\n  \\\"action\\\":\\\"Unclaim\\\"\\n}\",\"type\":\"String\"}";
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> varUpdate = restTemplate.exchange(
                camundaURL + "/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity",
                HttpMethod.PUT,
                entity,
                String.class
        );
        if (varUpdate.getStatusCode() == HttpStatus.NO_CONTENT) {
//            varUpdate.releaseBody();
//            return WebClient.create(camundaURL)
//                    .post()
//                    .uri("/engine-rest/task/" + taskid + "/unclaim")
//                    .header("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user))
//                    .contentType(MediaType.APPLICATION_JSON)
//                    .accept(MediaType.APPLICATION_JSON)
//                    .body(BodyInserters.fromValue("{\"userId\": \"" + user + "\"}"))
//                    .exchange()
//                    .block();
            body = "{\"userId\": \"" + user + "\"}";
            entity = new HttpEntity<>(body, headers);
            return restTemplate.exchange(
                    camundaURL + "/engine-rest/task/" + taskid + "/unclaim",
                    HttpMethod.POST,
                    entity,
                    String.class
            );
        } else {
            return varUpdate;
        }
    }

    @Override
    public ResponseEntity<String> addCommentOpen(AddComment addComment, String user) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        ObjectNode comment = mapper.createObjectNode();
        comment.put("user", user);
        comment.put("message", addComment.getMessage());
        addComment.setMessage(comment.toString());
//        return WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task/" + addComment.getTaskid() + "/comment/create")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user))
//                .body(Mono.just(addComment), AddComment.class)
//                .accept(MediaType.APPLICATION_JSON)
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user));
        headers.set("Accept", "application/json");
        HttpEntity<AddComment> entity = new HttpEntity<>(addComment, headers);
        return restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + addComment.getTaskid() + "/comment/create",
                HttpMethod.POST,
                entity,
                String.class
        );
    }

    @Override
    public ResponseEntity<String> submitFormOpne(String taskid, String processInstanceId, String body, String user)
            throws Exception {
        long start, end;
        start = System.currentTimeMillis();
//        ClientResponse varUpdate = WebClient.create(camundaURL)
//                .post()
//                .uri("/engine-rest/task/" + taskid + "/submit-form")
//                .header("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user))
//                .contentType(MediaType.APPLICATION_JSON)
//                .accept(MediaType.APPLICATION_JSON)
//                .body(BodyInserters.fromValue(body))
//                .exchange()
//                .block();
        RestTemplate restTemplate = RestTemplateUtil.createRestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user));
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/json");
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> varUpdate = restTemplate.exchange(
                camundaURL + "/engine-rest/task/" + taskid + "/submit-form",
                HttpMethod.POST,
                entity,
                String.class
        );
        end = System.currentTimeMillis();
        System.out.println("Submit form time " + (end - start));
        if (varUpdate.getStatusCode() == HttpStatus.NO_CONTENT) {
            start = System.currentTimeMillis();
//            ClientResponse exist = WebClient.create(camundaURL)
//                    .get()
//                    .uri("/engine-rest/process-instance/" + processInstanceId)
//                    .header("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user))
//                    .accept(MediaType.APPLICATION_JSON)
//                    .exchange()
//                    .block();
            HttpHeaders headers1 = new HttpHeaders();
            headers1.set("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user));
            headers1.set("Accept", "application/json");
            ResponseEntity<String> exist = restTemplate.exchange(
                    camundaURL + "/engine-rest/process-instance/" + processInstanceId,
                    HttpMethod.GET,
                    new HttpEntity<>(headers1),
                    String.class
            );
            end = System.currentTimeMillis();
            System.out.println("Process instance time " + (end - start));
            if (exist.getStatusCode() == HttpStatus.OK) {
                start = System.currentTimeMillis();
//                ClientResponse temp = WebClient.create(camundaURL)
//                        .put()
//                        .uri("/engine-rest/process-instance/" + processInstanceId
//                                + "/variables/userActivity")
//                        .header("Authorization", camundaBasicAuthUtil.getBasicAuthOpen(user))
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .accept(MediaType.APPLICATION_JSON)
//                        .body(BodyInserters.fromValue("{\"value\":\"{\\n  \\\"user\\\":\\\""
//                                + user
//                                + "\\\",\\n  \\\"action\\\":\\\"" + taskid
//                                + "\\\",\\n  \\\"action\\\":\\\"Submit\\\"\\n}\",\"type\":\"String\"}"))
//                        .exchange()
//                        .block();
                HttpEntity<String> processEntity = new HttpEntity<>("{\"value\":\"{\\n  \\\"user\\\":\\\""
                                + user
                                + "\\\",\\n  \\\"action\\\":\\\"" + taskid
                                + "\\\",\\n  \\\"action\\\":\\\"Submit\\\"\\n}\",\"type\":\"String\"}", headers);
                ResponseEntity<String> temp = restTemplate.exchange(
                        camundaURL + "/engine-rest/process-instance/" + processInstanceId + "/variables/userActivity",
                        HttpMethod.PUT,
                        processEntity,
                        String.class
                );
                end = System.currentTimeMillis();
                System.out.println("Process variable time " + (end - start));
//                temp.releaseBody();
            }
//            exist.releaseBody();
            return varUpdate;

        } else {
            return varUpdate;
        }
    }


    private ResponseErrorHandler customResponseErrorHandler() {
        return new ResponseErrorHandler() {
            @Override
            public boolean hasError(ClientHttpResponse response) throws IOException {
                return false;
            }

            @Override
            public void handleError(ClientHttpResponse response) throws IOException {
            }
        };
    }
}
