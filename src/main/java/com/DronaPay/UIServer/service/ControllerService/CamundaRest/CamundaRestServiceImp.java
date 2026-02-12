package com.DronaPay.UIServer.service.ControllerService.CamundaRest;

import com.DronaPay.UIServer.model.EmailAuditTrail;
import com.DronaPay.UIServer.model.EmailModel;
import com.DronaPay.UIServer.model.TicketIDGenerator;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.CallBackSendMessageRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.FilePathChecker;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.ResponseParser;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.ZonedDateTime;
import java.util.List;

@Service
@Slf4j
public class CamundaRestServiceImp implements CamundaRestService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CamundaRestServiceImp.class);

    @Autowired
    private CamundaService camundaService;

    @Autowired
    private WebUserService webUserService;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private TicketIDGeneratorService ticketIDGeneratorService;

    @Autowired
    private ResponseCallBackTemplateService responseCallBackTemplateService;

    @Autowired
    private ResponseParser responseParser;

    @Autowired
    private EmailAuditTrailService emailAuditTrailService;

    @Autowired
    private EmailRepoService emailRepoService;

    @Autowired
    private FilePathChecker filePathChecker;

    @Value("${file.upload-dir}")
    private String upload_DIR;

    @Value("${email.body.processing.enabled}")
    private Boolean emailBodyProcessing;

    public ResponseEntity<?> sendMessage(String body) {
        ResponseEntity<String> clientResponse = null;
        try {
            clientResponse = camundaService.sendMessage(body);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(body));
            // activityLogService.addActivity("failed to access task list",
            // "Error : " + e.toString() + ", Parameters : " + body);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
//        String response = clientResponse.bodyToMono(String.class).block();
        String response = clientResponse.getBody();
//        clientResponse.releaseBody();
        LOGGER.info("Send message response " + response);
        LOGGER.info("Send message stataus" + clientResponse.getStatusCode());

        if (clientResponse.getStatusCode() == HttpStatus.OK) {
            // activityLogService.addActivity("message sent successfully ", "parameters : "
            // + body);
            return ResponseEntity.ok(response);
        } else {
            // activityLogService.addActivity("failed to send message", "Parameters : " +
            // body);
            return new ResponseEntity<>(response, clientResponse.getStatusCode());
        }
    }

    public ResponseEntity<?> createTicket(String bodyString, String key, Authentication pr) {
        WebUser loggedInUser = webUserService.loadUserByUsername(pr.getName());
        ResponseEntity<String> clientResponse = null;

        TicketIDGenerator ticketIDGenerator = null;

        JSONObject body = new JSONObject(bodyString);

        try {
            ticketIDGenerator = ticketIDGeneratorService.save(ticketIDGenerator);
        } catch (Exception e) {
            LOGGER.error("Error " + e);
        }
        JSONObject ticketid = new JSONObject();
        ticketid.put("type", "long");
        ticketid.put("value", ticketIDGenerator.getTicketID());

        body.getJSONObject("variables").put("TicketID", ticketid);
        ResponseEntity<String> processDefinationDetials = null;
        try {
            processDefinationDetials = camundaService.getProcessDefinationDetails(key, loggedInUser);
        } catch (Exception e) {
            e.getStackTrace();
        }
//        String processDefinationDetialsString = processDefinationDetials.bodyToMono(String.class).block();
        String processDefinationDetialsString = processDefinationDetials.getBody();
//        processDefinationDetials.releaseBody();
        JSONObject processDefinationDetialsJSONObj = new JSONObject(processDefinationDetialsString);

        JSONObject workflowname = new JSONObject();
        workflowname.put("type", "string");
        workflowname.put("value", processDefinationDetialsJSONObj.getString("name"));
        body.getJSONObject("variables").put("WorkflowName", workflowname);

        try {
            clientResponse = camundaService.createTicket(body.toString(), key, loggedInUser);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(body.toString()));
            activityLogService.addActivity(loggedInUser, "failed to create ticket",
                    "Error : " + e.toString() + ", Parameters : " + body);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

//        String response = clientResponse.bodyToMono(String.class).block();
        String response = clientResponse.getBody();
//        clientResponse.releaseBody();
        if (clientResponse.getStatusCode() == HttpStatus.OK) {
            activityLogService.addActivity(loggedInUser, "Ticket created successfully", "parameters : " + body);
            return ResponseEntity.ok(response);
        } else {
            activityLogService.addActivity(loggedInUser, "failed to create ticket", "Parameters : " + body);
            return new ResponseEntity<>(response, clientResponse.getStatusCode());
        }
    }

    @Override
    public ResponseEntity<?> sendMessage(CallBackSendMessageRequest callBackSendMessageRequest,
            List<MultipartFile> attachments, Integer tenantid) throws Exception {
        log.info("send message service called");

        EmailAuditTrail emailAuditTrail = emailAuditTrailService
                .findByCorrerlationAndStatus(callBackSendMessageRequest.getCorrelation_key(), 3, tenantid);

        // Map<String,String> paramValueMap=new HashMap<>();

        // if (emailAuditTrail.getResponseBody() != null) {
        // if (!emailAuditTrail.getResponseBody().isEmpty() &&
        // !emailAuditTrail.getResponseBody().isBlank() &&
        // emailAuditTrail.getEmailTemplateId().getResponse()!=null) {
        // if(!emailAuditTrail.getEmailTemplateId().getResponse().isEmpty() &&
        // !emailAuditTrail.getEmailTemplateId().getResponse().isBlank()){
        // paramValueMap=responseParser.parseResponse(callBackSendMessageRequest.getBody(),
        // emailAuditTrail.getEmailTemplateId().getResponse());
        // }
        // }
        // }

        JSONArray attArray = saveAttachments(attachments, callBackSendMessageRequest.getCorrelation_key(), tenantid);

        ResponseEntity<String> clientResponse = null;
        String processReq = "{\"businessKey\":" + "\"" + callBackSendMessageRequest.getCorrelation_key() +
                "\", \"tenantIdIn\":[\"" + tenantid + "\"]}";
        log.info("request body is " + loggerEncoderUtil.encode(processReq));
        try {
            clientResponse = camundaService.getProcessInstance(processReq);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(processReq));
            // activityLogService.addActivity("failed to send message",
            // "Error : " + e.toString() + ", Parameters : " + processReq);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
//        String resString = clientResponse.bodyToMono(String.class).block();
        String resString = clientResponse.getBody();
//        clientResponse.releaseBody();

        String proccInstId = "";
        if (clientResponse.getStatusCode() == HttpStatus.OK) {
            JSONArray details = new JSONArray(resString);
            if (details.length() > 0) {
                proccInstId = details.getJSONObject(0).optString("id");
            }
            log.info("Process instance id is " + proccInstId);
        }

        String reqbody = "{\n  \"processInstanceIdIn\":[\"" + proccInstId + "\"]"
                + ",\r\n    \"variableName\":\"attachmentList\"\r\n    \r\n   \r\n}";
        log.info("Request body " + loggerEncoderUtil.encode(reqbody));
        try {
            clientResponse = camundaService.getVariableInstance(reqbody);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(reqbody));
            // activityLogService.addActivity("failed to send message",
            // "Error : " + e.toString() + ", Parameters : " + reqbody);
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

//        resString = clientResponse.bodyToMono(String.class).block();
        resString = clientResponse.getBody();
        System.out.println(resString);
//        clientResponse.releaseBody();
        JSONArray curAtt = new JSONArray();
        log.info("status code " + clientResponse.getStatusCode());
        if (clientResponse.getStatusCode() == HttpStatus.OK) {
            JSONArray details = new JSONArray(resString);
            for (int i = 0; i < details.length(); i++) {
                JSONObject obj = details.getJSONObject(i);
                if (obj.getString("name").equals("attachmentList")) {
                    curAtt.putAll(new JSONArray(obj.getString("value")));
                    System.out.println("value of attachmentlist variable " + curAtt);
                }
            }
        }

        attArray.putAll(curAtt);

        JSONObject sendMessageReqBody = new JSONObject();
        sendMessageReqBody.put("businessKey", callBackSendMessageRequest.getCorrelation_key());
        JSONObject processVariables = new JSONObject();
        JSONObject attachmentList = new JSONObject();
        attachmentList.put("type", "json");
        attachmentList.put("value", attArray.toString());
        JSONObject subject = new JSONObject();
        subject.put("type", "string");
        subject.put("value", callBackSendMessageRequest.getSubject());
        // JSONObject body = new JSONObject();
        // body.put("type", "string");
        // processVariables.put("body", callBackSendMessageRequest.getBody());
        processVariables.put("subject", subject);
        processVariables.put("attachmentList", attachmentList);
        // for(String param:paramValueMap.keySet()){
        // JSONObject cam_param=new JSONObject();
        // cam_param.put("type", "string");
        // cam_param.put("value", paramValueMap.get(param));
        // processVariables.put(param, cam_param);
        // }
        if (emailBodyProcessing) {
            JSONArray bodyArray = new JSONArray();
            bodyArray.put(callBackSendMessageRequest.getBody());
            log.info("Processing email body");
            reqbody = "{\n  \"processInstanceIdIn\":[\"" + proccInstId + "\"]"
                    + ",\r\n    \"variableName\":\"JSONRenderEmailResponses\"\r\n    \r\n   \r\n}";
            log.info("Request body " + reqbody);
            try {
                clientResponse = camundaService.getVariableInstance(reqbody);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(reqbody));
                // activityLogService.addActivity("failed to send message",
                // "Error : " + e.toString() + ", Parameters : " + reqbody);
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            resString = clientResponse.bodyToMono(String.class).block();
            resString = clientResponse.getBody();
            System.out.println(resString);
//            clientResponse.releaseBody();
            log.info("status code " + clientResponse.getStatusCode());
            if (clientResponse.getStatusCode() == HttpStatus.OK) {
                JSONArray details = new JSONArray(resString);
                for (int i = 0; i < details.length(); i++) {
                    JSONObject obj = details.getJSONObject(i);
                    if (obj.getString("name").equals("JSONRenderEmailResponses")) {
                        bodyArray.putAll(new JSONArray(obj.getString("value")));
                    }
                }
            }

            JSONObject emailResponses = new JSONObject();
            emailResponses.put("type", "json");
            emailResponses.put("value", bodyArray.toString());
            processVariables.put("JSONRenderEmailResponses", emailResponses);

        }
        sendMessageReqBody.put("processVariables", processVariables);
        EmailModel emailTemplate = emailRepoService.findById(emailAuditTrail.getEmailTemplateId(),
                emailAuditTrail.getItenantId());
        sendMessageReqBody.put("messageName", emailTemplate.getCamunda_message_name());

        log.info("Camunda email receive task request body " + loggerEncoderUtil.encode(sendMessageReqBody.toString()));
        try {
            clientResponse = camundaService.sendMessage(sendMessageReqBody.toString());
        } catch (Exception e) {
            LOGGER.error("Error : " + e + " Parameters : " + loggerEncoderUtil.encode(sendMessageReqBody.toString()));
            // activityLogService.addActivity("failed to send message",
            // "Error : " + e.toString() + ", Parameters : " +
            // sendMessageReqBody.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "something went wrong"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
//        String response = clientResponse.bodyToMono(String.class).block();
        String response = clientResponse.getBody();
//        clientResponse.releaseBody();
        LOGGER.info("Send message response " + response);
        LOGGER.info("Send message stataus" + clientResponse.getStatusCode());

        if (clientResponse.getStatusCode() == HttpStatus.NO_CONTENT) {
            emailAuditTrail.setStatusTimeStamp(ZonedDateTime.now());
            emailAuditTrail.setProcessingStatus(3);
            emailAuditTrailService.save(emailAuditTrail);
            // activityLogService.addActivity("message sent successfully ", "parameters : "
            // + sendMessageReqBody.toString());
            return ResponseEntity.ok(response);
        } else {
            // activityLogService.addActivity("failed to send message", "Parameters : " +
            // sendMessageReqBody.toString());
            return new ResponseEntity<>(response, clientResponse.getStatusCode());
        }
    }

    private JSONArray saveAttachments(List<MultipartFile> attachments, String correlation_key, Integer tenantid)
            throws IOException {

        JSONArray attachmentArr = new JSONArray();
        if (attachments == null) {
            return attachmentArr;
        }
        for (MultipartFile file : attachments) {
            JSONObject fileName = new JSONObject();
            String pathString = upload_DIR + File.separator + tenantid + File.separator + correlation_key
                    + File.separator + file.getOriginalFilename();
            if (filePathChecker.isValidPath(pathString)) {
                Path path = Path.of(pathString).toAbsolutePath().normalize();
                Files.createDirectories(path.getParent());
                Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                filePathChecker.setPermissions(path);
                fileName.put("filename", file.getOriginalFilename());
                attachmentArr.put(fileName);
            }
        }

        return attachmentArr;

    }
}
