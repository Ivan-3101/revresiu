package com.DronaPay.UIServer.util;

import com.DronaPay.UIServer.model.FormMaster;
import com.DronaPay.UIServer.model.FormValue;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.AddFormValue;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.ControllerService.ListManagement.ListManagementServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.FormMasterService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Component
@Slf4j
public class STRFromActionAfterCreation {

    @Autowired
    private CamundaService camundaService;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private FormMasterService formMasterService;

    public ResponseEntity<?> validate(FormValue formValue, AddFormValue addFormValue, WebUser loggedInUser,
            String type) {

        FormMaster formMaster = formMasterService.findByID(formValue.getIFormID(), loggedInUser, addFormValue.getItenantId());
        System.out.println(formMaster.getActionAfterCreation().toString());
        JSONObject actionjson = new JSONObject(formMaster.getActionAfterCreation().toString());
        JSONArray postArray = actionjson.getJSONArray(type);

        for (int i = 0; i < postArray.length(); i++) {
            JSONObject postObject = postArray.getJSONObject(i);

            // UpdateProcessVariableCamunda
            JSONArray camundaArray = postObject.optJSONArray("UpdateProcessVariableCamunda");
            Map<String, Object> modifications = new HashMap<>();

            if (camundaArray != null && !addFormValue.getProcessInstanceID().isEmpty()) {
                for (int j = 0; j < camundaArray.length(); j++) {

                    JSONObject camundaObject = camundaArray.getJSONObject(j);
                    String processVariableName = camundaObject.getString("ProcessVariableName");
                    String processVariableType = camundaObject.getString("ProcessVariableType");
                    Object processVariableValue = getJsonValue(
                            addFormValue, formValue,
                            camundaObject.getString("ProcessVariableValue"),
                            getClassFromString(processVariableType));

                    System.out.println(processVariableValue);
                    modifications.put(processVariableName,
                            Map.of("type", processVariableType, "value", processVariableValue));

                }

                Map<String, Object> bodyMap = new HashMap<>();
                bodyMap.put("modifications", modifications);

                JSONObject body = new JSONObject(bodyMap);

                System.out.println(body);
                try {
                    ResponseEntity<String> variableupdate = camundaService.addVariable(addFormValue.getProcessInstanceID(),
                            body, loggedInUser);
//                    variableupdate.releaseBody();
                } catch (Exception e) {
                    activityLogService.addActivity(loggedInUser, "failed to add variable in camunda");
                    log.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to add variable in camunda");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "audit entry saved but failed to add variable in camunda"),
                            HttpStatus.BAD_REQUEST);
                }
            }

            // Update Process History
            JSONArray historyArray = postObject.optJSONArray("UpdateProcessHistory");

            if (historyArray != null && !addFormValue.getProcessInstanceID().isEmpty()) {
                for (int j = 0; j < historyArray.length(); j++) {
                    JSONObject camundaObject = historyArray.getJSONObject(j);
                    String processVariableName = camundaObject.getString("ProcessVariableName");
                    String processVariableType = camundaObject.getString("ProcessVariableType");
                    JSONObject processVariableValue = camundaObject.getJSONObject("ProcessVariableValue");
                    processVariableValue.put("user", loggedInUser.getIuserID());
                    System.out.println(processVariableValue);
                    modifications.put(processVariableName,
                            Map.of("type", processVariableType, "value", processVariableValue.toString()));
                }
                Map<String, Object> bodyMap = new HashMap<>();
                bodyMap.put("modifications", modifications);

                JSONObject body = new JSONObject(bodyMap);

                System.out.println(body);
                try {
                    ResponseEntity<String> variableupdate = camundaService.addVariable(addFormValue.getProcessInstanceID(),
                            body, loggedInUser);
                    System.out.println(variableupdate.getStatusCode());
//                    variableupdate.releaseBody();
                } catch (Exception e) {
                    activityLogService.addActivity(loggedInUser, "failed to add variable in camunda");
                    log.error("Exiting Add List  Method in " + ListManagementServiceImpl.class
                            + " class with response  : failed to add variable in camunda");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "audit entry saved but failed to add variable in camunda"),
                            HttpStatus.BAD_REQUEST);
                }

            }
            // ApisToBeCalled
            JSONArray apiArray = postObject.optJSONArray("ApisToBeCalled");
            if (apiArray != null) {
                for (int j = 0; j < apiArray.length(); j++) {
                    JSONObject apiObject = apiArray.getJSONObject(j);
                    String route = apiObject.getString("route");
                    String body = apiObject.getString("body");
                    // Call API
                    callApi(route, body);
                }
            }

            // DbQueryToBeExecuted
            JSONArray queryArray = postObject.optJSONArray("DbQueryToBeExecuted");
            if (queryArray != null) {
                for (int j = 0; j < queryArray.length(); j++) {
                    JSONObject queryObject = queryArray.getJSONObject(j);
                    String query = queryObject.getString("query");
                    // Execute query
                    executeQuery(query);
                }
            }
        }
        return new ResponseEntity<ApiResponse>(new ApiResponse(true, "form added successfully"), HttpStatus.OK);
    }

    private void executeQuery(String query) {

    }

    public <T> T getJsonValue(AddFormValue object1, FormValue object2, String path, Class<T> type) {
        String[] pathElements = path.split("\\.");
        Object node;
        if (!pathElements[0].equals("this")) {
            return (T) path;
        }

        if (pathElements[1].equals("AddFormValue")) {
            if (object1 != null) {
                node = object1;
            } else {
                return null;
            }
        } else if (pathElements[1].equals("FormValue")) {
            if (object2 != null) {
                node = object2;
            } else {
                return null;
            }
        } else {
            return null;
        }
        for (int i = 2; i < pathElements.length; i++) {
            try {
                Field field = node.getClass().getDeclaredField(pathElements[i]);
                field.setAccessible(true);
                node = field.get(node);
            } catch (Exception e) {
                log.error(e.getMessage());
                return null;
            }
            if (node == null) {
                return null;
            }
        }

        if (node instanceof JsonNode) {
            return new ObjectMapper().convertValue(node, type);
        } else {
            return new ObjectMapper().convertValue(node.toString(), type);
        }
    }

    public Class<?> getClassFromString(String className) {
        if (className.equalsIgnoreCase("integer")) {
            return Integer.class;
        } else if (className.equalsIgnoreCase("string")) {
            return String.class;
        } else if (className.equalsIgnoreCase("boolean")) {
            return Boolean.class;
        } else {
            return null;
        }
    }

    private void updateCamundaVariable(String processVariableName, String processVariableValue,
            String processInstanceId) {
        // Code to call Camunda API to update process variable
        // You can use any HTTP client library, such as Apache HttpClient or OkHttp
        // Here's an example using Apache HttpClient:
        /*
         * try {
         * String url =
         * "http://camunda-server/api/engine/engine/default/process-instance/" +
         * processInstanceId + "/variables/" + processVariableName;
         * String body = "{\"value\": \"" + processVariableValue + "\"}";
         * HttpClient client = HttpClient.newHttpClient();
         * HttpRequest request = HttpRequest.newBuilder()
         * .uri(URI.create(url))
         * .header("Content-Type", "application/json")
         * .PUT(HttpRequest.BodyPublishers.ofString(body))
         * .build();
         * HttpResponse<String> response = client.send(request,
         * HttpResponse.BodyHandlers.ofString());
         * int statusCode = response.statusCode();
         * String responseBody = response.body();
         * // Handle response
         * } catch (Exception e) {
         * // Handle exception
         * }
         */
    }

    private void callApi(String route, String body) {
        // Code to call API
        // You can use any HTTP client library
    }
}
