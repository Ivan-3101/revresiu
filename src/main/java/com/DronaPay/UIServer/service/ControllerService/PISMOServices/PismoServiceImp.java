package com.DronaPay.UIServer.service.ControllerService.PISMOServices;

import java.net.http.HttpResponse;

import org.springframework.security.core.Authentication;

import java.util.Arrays;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.http.HttpStatus;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.UserAndPermissions;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.PISMOApiService;
import com.DronaPay.UIServer.service.ApiServices.TransactionClassApiService;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.TenantRepositoryService;
import com.DronaPay.UIServer.service.RepositoryService.WebUserService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PismoServiceImp implements PismoService {

    @Value(value = "${tenant.id}")
    private String tenant_id;

    @Autowired
    private PISMOApiService pismoApiService;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private WebUserService webUserService;

    final String menu_name = MenuNames.Tasks;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private TransactionClassApiService transactionClassApiService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Override
    public ResponseEntity<?> contactNumber(Authentication pr, String account_id, String class_name, Integer tenantid) throws Exception {
        log.info("enter in class " + PismoServiceImp.class + "in method contactNumber");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp.isView()) {

            String serverKey = null;
            String serverSecret = null;
            String tenantId = null;
            String apikey = tenantRepositoryService.findAPIKeyTenant(tenantid);
            ResponseEntity<String> tenant_response = transactionClassApiService
                    .getTransactionClass(apikey, class_name);
            log.info("Get Class detail response " + tenant_response.getBody());
            log.info("Get Class status " + tenant_response.getStatusCode());

            if (tenant_response.getStatusCode() == HttpStatus.OK) {

                ObjectMapper mapper = new ObjectMapper();
                JsonNode node = mapper.readTree(tenant_response.getBody());
                if (node.get("attribs").has("tenantid")) {
                    log.info("tenantid", node.get("attribs").get("tenantid").asText());

                    tenantId = node.get("attribs").get("tenantid").asText();
                }

                if (node.get("attribs").has("serverkey")) {
                    log.info("serverkey", node.get("attribs").get("serverkey").asText());

                    serverKey = node.get("attribs").get("serverkey").asText();
                }

                if (node.get("attribs").has("serversecret")) {
                    log.info("serverseceret", node.get("attribs").get("serversecret").asText());

                    serverSecret = node.get("attribs").get("serversecret").asText();
                }

            }

            if (serverKey == null || serverSecret == null) {

                log.error("Error :  No serverkey or secrever secret is null \nparam={server_key:" + serverKey + ",server_secret:"
                        + serverSecret + ",accountid:" + account_id + "}");
                activityLogService.addActivity(loggedInUser, "failed to call access token api",
                        "\nparam={server_key:" + serverKey + ",server_secret:"
                                + serverSecret + ",accountid:"
                                + account_id + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(null, false, "Fail to get server secrets of PISMO"),
                        HttpStatus.INTERNAL_SERVER_ERROR);

            }
            ResponseEntity<String> access_token_response = null;
            try {
                access_token_response = pismoApiService.getAccessToken(serverKey,
                        serverSecret,
                        account_id);
            } catch (Exception e) {
                log.error("Error : " + e + "\nparam={server_key:" + serverKey + ",server_secret:"
                        + serverSecret + ",accountid:" + account_id + "}");
                activityLogService.addActivity(loggedInUser, "failed to call access token api",
                        "\nparam={server_key:" + serverKey + ",server_secret:"
                                + serverSecret + ",accountid:"
                                + account_id + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(null, false, "failed to call access token api"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (access_token_response.getStatusCode() != HttpStatus.CREATED) {

                log.error("Error : API response " + access_token_response.getBody()
                        + "\nparam={server_key:"
                        + serverKey
                        + ",server_secret:"
                        + serverSecret + ",accountid:" + account_id + "}");
                activityLogService.addActivity(loggedInUser,
                        "failed to call access token api with response "
                                + access_token_response.getBody(),
                        "\nparam={server_key:" + serverKey + ",server_secret:"
                                + serverSecret + ",accountid:"
                                + account_id + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(access_token_response.getBody(), false,
                                "failed to call access token api with response "
                                        + access_token_response.getBody()),
                        HttpStatus.INTERNAL_SERVER_ERROR);

            }

            ObjectMapper mapper = new ObjectMapper();

            JsonNode access_token_response_json = null;

            try {
                access_token_response_json = mapper.readTree(access_token_response.getBody());

            } catch (JsonProcessingException e) {
                log.error("Error : JSON Parsing exception " + e + "\n APi response "
                        + access_token_response.getBody() + "");
                activityLogService.addActivity(loggedInUser, "failed to parse acces token api response",
                        "\n APi response " + access_token_response.getBody() + "");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(access_token_response.getBody(), false,
                                "failed to parse access token api response"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            ResponseEntity<String> account_detail_response = null;

            try {
                account_detail_response = pismoApiService.getAccountDetails(
                        access_token_response_json.get("token").asText(), account_id);
            } catch (Exception e) {
                log.error("Error : " + e + "\nparam={accountid:" + loggerEncoderUtil.encode(account_id) + "access_token_response:"
                        + access_token_response.getBody() + "}");
                activityLogService.addActivity(loggedInUser, "failed to call account detail API ",
                        "\nparam={accountid:" + account_id + "access_token_response:"
                                + access_token_response.getBody() + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(null, false, "failed to call account detail API"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (account_detail_response.getStatusCode() != HttpStatus.OK) {
                log.error("Error : Account detail API response " + account_detail_response.getBody()
                        + "\nparam={accountid:" + loggerEncoderUtil.encode(account_id) + "access_token_response:"
                        + access_token_response.getBody() + "}");
                activityLogService.addActivity(loggedInUser,
                        "failed to call account detail api with response "
                                + account_detail_response.getBody(),
                        "\nparam={accountid:" + account_id + "access_token_response:"
                                + access_token_response.getBody() + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(account_detail_response.getBody(), false,
                                "failed to call account detail api with response "
                                        + account_detail_response.getBody()),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            JsonNode account_detail_response_json = null;

            try {
                account_detail_response_json = mapper.readTree(account_detail_response.getBody());

            } catch (JsonProcessingException e) {
                log.error("Error : JSON Parsing exception " + e + "\n Account detail APi response "
                        + account_detail_response.getBody() + "");
                activityLogService.addActivity(loggedInUser,
                        "failed to parse account detail api response",
                        "\n APi response " + account_detail_response.getBody() + "");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(account_detail_response.getBody(), false,
                                "failed to parse account detail api response"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            ResponseEntity<String> customer_detail_response = null;

            try {
                customer_detail_response = pismoApiService.getCustomerDetails(
                        access_token_response_json.get("token").asText(),
                        account_detail_response_json.get("customer_id").asText());
            } catch (Exception e) {
                log.error("Error : " + e + "\nparam={accounst_detail_response :"
                        + account_detail_response.getBody() + "access_token_response:"
                        + access_token_response.getBody() + "}");
                activityLogService.addActivity(loggedInUser, "failed to call customer detail API ",
                        "\nparam={accounst_detail_response :" + account_detail_response.getBody()
                                + "access_token_response:"
                                + access_token_response.getBody() + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(null, false, "failed to call customer detail API"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (customer_detail_response.getStatusCode() != HttpStatus.OK) {
                log.error("Error : Customer detail API response " + customer_detail_response.getBody()
                        + "\nparam={accounst_detail_response :" + account_detail_response.getBody()
                        + "access_token_response:"
                        + access_token_response.getBody() + "}");
                activityLogService.addActivity(loggedInUser,
                        "failed to call customer detail api with response "
                                + customer_detail_response.getBody(),
                        "\nparam={accounst_detail_response :" + account_detail_response.getBody()
                                + "access_token_response:"
                                + access_token_response.getBody() + "}");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(account_detail_response.getBody(), false,
                                "failed to call account detail api with response "
                                        + customer_detail_response.getBody()),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            JsonNode customer_detail_response_json = null;
            log.info(customer_detail_response.getBody());

            try {
                customer_detail_response_json = mapper.readTree(customer_detail_response.getBody());

            } catch (JsonProcessingException e) {
                log.error("Error : JSON Parsing exception " + e + "\n Customer detail APi response "
                        + customer_detail_response.getBody() + "");
                activityLogService.addActivity(loggedInUser,
                        "failed to parse Customer detail api response",
                        "\n APi response " + customer_detail_response.getBody() + "");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(customer_detail_response.getBody(), false,
                                "failed to parse Customer detail api response"),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            log.info("phone " + customer_detail_response_json.get("customer").get("phones"));

            JSONArray phone_ids = new JSONArray(
                    customer_detail_response_json.get("customer").get("phones").toString());
            String phone_id = null;
            for (int i = 0; i < phone_ids.length(); i++) {
                JSONObject phone_id_obj = phone_ids.getJSONObject(i);
                log.info(phone_id_obj.toString());
                if (phone_id_obj.get("type").equals("MOBILE")) {
                    phone_id = phone_id_obj.get("phone_id").toString();
                    i = phone_ids.length();
                }
            }

            if (phone_id != null) {
                ResponseEntity<String> phone_detail_response = null;

                try {
                    phone_detail_response = pismoApiService.getPhoneDetails(
                            access_token_response_json.get("token").asText(), account_id,
                            phone_id);
                } catch (Exception e) {
                    log.error("Error : " + e + "\nparam={customer_detail_respone : "
                            + customer_detail_response.getBody()
                            + "account_detail_response :" + account_detail_response.getBody()
                            + "access_token_response:"
                            + access_token_response.getBody() + "}");
                    activityLogService.addActivity(loggedInUser,
                            "failed to call customer detail API ",
                            "\nparam={customer_detail_respone : "
                                    + customer_detail_response.getBody()
                                    + "account_detail_response :"
                                    + account_detail_response.getBody()
                                    + "access_token_response:"
                                    + access_token_response.getBody() + "}");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(null, false, "failed to call phone detail API"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                log.info("phone detail response for phone id " + phone_id + " is " + phone_detail_response.getBody());
                log.info("phone detail response for phone id " + phone_id + " is " + phone_detail_response.getStatusCode());

                if (phone_detail_response.getStatusCode() != HttpStatus.OK) {
                    log.error("Error : Phone detail API response " + phone_detail_response.getBody()
                            + "\nparam={customer_detail_respone : "
                            + customer_detail_response.getBody()
                            + "account_detail_response :" + account_detail_response.getBody()
                            + "access_token_response:"
                            + access_token_response.getBody() + "}");
                    activityLogService.addActivity(loggedInUser,
                            "failed to call phone detail api with response "
                                    + customer_detail_response.getBody(),
                            "\nparam={customer_detail_respone : "
                                    + customer_detail_response.getBody()
                                    + "account_detail_response :"
                                    + account_detail_response.getBody()
                                    + "access_token_response:"
                                    + access_token_response.getBody() + "}");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(account_detail_response.getBody(), false,
                                    "failed to call phone detail api with response "
                                            + account_detail_response
                                            .getBody()),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                JsonNode phone_detail_response_json = null;
                log.info("phone_detail_response " + phone_detail_response.getBody());

                try {
                    phone_detail_response_json = mapper.readTree(phone_detail_response.getBody());

                } catch (JsonProcessingException e) {
                    log.error("Error : JSON Parsing exception " + e
                            + "\n Phone detail APi response "
                            + phone_detail_response.getBody() + "");
                    activityLogService.addActivity(loggedInUser,
                            "failed to parse Customer detail api response",
                            "\n Phone deatail APi response " + phone_detail_response.getBody()
                                    + "");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(phone_detail_response.getBody(), false,
                                    "failed to parse Customer detail api response"),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                return ResponseEntity.ok(phone_detail_response_json.get("number").asText());
            } else {
                log.error("No phone id for account " + loggerEncoderUtil.encode(account_id) + " ,\nCustomer detail response "
                        + customer_detail_response.getBody());
                activityLogService.addActivity(loggedInUser, "No phone ids found ",
                        "\nCustomer detail response "
                                + customer_detail_response.getBody());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(customer_detail_response.getBody(), false,
                                "No phone Id found for account id " + account_id),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access phone number of pismo accout " + account_id);
            log.debug("Exiting contactNumber Method in " + PismoServiceImp.class
                    + " class with response  : unauthorized to access phone number of pismo accout "
                    + account_id);
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "unauthorized to access phone number of pismo accout "
                                    + account_id),
                    HttpStatus.FORBIDDEN);
        }

    }

}
