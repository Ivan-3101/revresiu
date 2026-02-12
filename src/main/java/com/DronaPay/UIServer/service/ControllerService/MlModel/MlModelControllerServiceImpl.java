package com.DronaPay.UIServer.service.ControllerService.MlModel;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.MlModelStatus;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.response.*;
import com.DronaPay.UIServer.service.ApiServices.MlModelApiService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class MlModelControllerServiceImpl implements MlModelControllerService {

    private static final Logger LOGGER = LoggerFactory.getLogger(MlModelControllerServiceImpl.class);
    final String menu_name = MenuNames.MlModels;

    @Autowired
    private MlModelService mlModelService;

    @Autowired
    private MlModelAuditService mlModelAuditService;

    @Autowired
    private MlModelApiService mlModelApiService;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private StatusCodeService statusCodeService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Override
    public ResponseEntity<?> getListOfAvailableMlModels(Authentication pr){
        LOGGER.debug("entered in class " + MlModelControllerServiceImpl.class + " in method getListOfAvailableMlModels");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isView()) {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access available Models list");
            LOGGER.debug("Exiting getListOfAvailableMlModels Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : Unauthorized to access list of available Models");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Unauthorized to access list of Available Models"),
                    HttpStatus.FORBIDDEN);
        }

        MlModelAvailableListView mlModelAvailableListView = new MlModelAvailableListView();
        mlModelAvailableListView.setAdd(mp.isAdd());
        mlModelAvailableListView.setApprove(mp.isApprove());
        mlModelAvailableListView.setDelete(mp.isDelete());
        mlModelAvailableListView.setEdit(mp.isEdit());
        mlModelAvailableListView.setView(mp.isView());

        List<MlModel> mlmodelsList = new ArrayList<>();
        List<MlModelAvailableResponse> responses = new ArrayList<>();
        List<MlModelAudit> mlModelAudits = new ArrayList<>();

        try {
            List<Integer> tenantids = loggedUser.getUserTenant();

            Map<String, Double> latestVersionMap = new HashMap<>();
            try {
                ResponseEntity<String> mlflowResponse = mlModelApiService.getTrainedModels(tenantids);
                if (mlflowResponse.getStatusCode().is2xxSuccessful() && mlflowResponse.getBody() != null) {
                    ObjectMapper mapper = new ObjectMapper();
                    JsonNode root = mapper.readTree(mlflowResponse.getBody());
                    JsonNode registeredModels = root.path("registered_models");
                    String stage = MlModelStatus.Production.name();

                    for (JsonNode modelNode : registeredModels) {
                        String modelName = modelNode.path("name").asText();
                        JsonNode latestVersions = modelNode.path("latest_versions");
                        Double maxProdVersion = null;

                        if (latestVersions == null || !latestVersions.isArray() || latestVersions.isEmpty()) {
                            continue;
                        } else {
                            for (JsonNode versionNode : latestVersions) {
                                if (stage.equalsIgnoreCase(versionNode.path("current_stage").asText())) {
                                    try {
                                        Double version = Double.parseDouble(versionNode.path("version").asText());
                                        if (maxProdVersion == null || version > maxProdVersion) {
                                            maxProdVersion = version;
                                        }
                                    } catch (NumberFormatException ex) {
                                        LOGGER.debug("Invalid version format for model: {}", versionNode.path("version").asText(), ex);
                                    }
                                }
                            }
                        }

                        if (maxProdVersion != null) {
                            latestVersionMap.put(modelName, maxProdVersion);
                        }
                    }
                }
            } catch (Exception e) {
                LOGGER.error("Error while fetching trained models from ML Flow. Error : " + e);
                activityLogService.addActivity(loggedInUser, "failed to get trained Model details", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            mlmodelsList = mlModelService.findAllNonDeletedTenants(tenantids);
            mlmodelsList = mlmodelsList.stream().filter(c -> c.getIrecordStatus() == 0)
                    .collect(Collectors.toList());
            mlModelAudits = mlModelAuditService.findPendingEntriesTenant(tenantids);

            for (MlModel model : mlmodelsList) {

                Double latestVersion = model.getIMlVersion();
                JsonNode detail = model.getVcModelDetail();

                if (detail != null && detail.isObject()) {
                    JsonNode modelNameNode = detail.path("registered_model").path("name");
                    if (modelNameNode != null && modelNameNode.isTextual()) {
                        String modelNameFromDetail = modelNameNode.asText();
                        latestVersion = latestVersionMap.getOrDefault(modelNameFromDetail, model.getIMlVersion());
                    } else {
                        LOGGER.info("modelName not found or not textual in vcModelDetail for modelId={}, falling back to default version", model.getImodelId());
                    }
                } else {
                    LOGGER.info("vcModelDetail is null or not an object for modelId={}, falling back to default version", model.getImodelId());
                }


                MlModelAvailableResponse response = MlModelAvailableResponse.builder()
                        .modelName(model.getVcMlFlowModelName())
                        .imodelId(model.getImodelId())
                        .description(model.getVcMlFlowModelDescription())
                        .type(model.getVcType())
                        .currentVersion(model.getIMlVersion())
                        .latestVersion(latestVersion)
                        .detail(model.getVcModelDetail())
                        .createdDate(model.getDtEntryStamp())
                        .lastUpdate(model.getDtApproverStamp())
                        .latestRemark(model.getVcRemark())
                        .itenantId(model.getItenantId())
                        .tenantName(tenantRepositoryService.findByItenantId(model.getItenantId()).getTenantName())
                        .lastStatus(model.getLastStatus())
                        .auditEntry(false)
                        .auditExist(false)
                        .makerChecker("M")
                        .build();

                responses.add(response);
            }

            for (int i = 0; i < responses.size(); i++) {
                for (int k = 0; k < mlModelAudits.size(); k++) {
                    if (mlModelAudits.get(k).getImodelId() != null) {
                        if (responses.get(i).getImodelId().equals(mlModelAudits.get(k).getImodelId())) {
                            responses.get(i).setAuditExist(true);
                        }
                    }
                }
            }

            mlModelAudits.stream()
                    .map(d -> responses.add(MlModelAvailableResponse.builder()
                            .modelName(d.getVcMlFlowModelName())
                            .imodelId(d.getImodelId() != null ? d.getImodelId() : -1)
                            .imodelAuditId(d.getImodelAuditId())
                            .description(d.getVcMlFlowModelDescription())
                            .type(d.getVcType())
                            .currentVersion(d.getIMlVersion())
                            .latestVersion(d.getIMlVersion())
                            .detail(d.getVcModelDetail())
                            .createdDate(d.getDtEntryStamp())
                            .lastUpdate(d.getDtEntryStamp())
                            .latestRemark(d.getVcRemark())
                            .lastStatus("Pending")
                            .itenantId(d.getItenantId())
                            .tenantName(tenantRepositoryService.findByItenantId(d.getItenantId()).getTenantName())
                            .auditEntry(true)
                            .auditExist(false)
                            .makerChecker(!Objects.equals(d.getIEntryUserID(), loggedInUser.getIuserID()) ? "C" : "M")
                            .action(d.getVcAction())
                            .build()))
                    .collect(Collectors.toList());

            mlModelAvailableListView.setMlModelAvailableList(responses);

            LOGGER.debug("Exiting getListOfAvailableMlModels Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : with parameters type dropdown");
            activityLogService.addActivity(loggedInUser, "Available Model list accessed");
            return ResponseEntity.ok(mlModelAvailableListView);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get available Model details", e.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @Override
    public ResponseEntity<?> getAvailableMlModel(GetMlModelRequest getMlModelRequest, Authentication pr) {
        LOGGER.debug("Entered getAvailableMlModel in class " + MlModelControllerServiceImpl.class);

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isView()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to view Model");
            LOGGER.debug("Exiting getAvailableMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : unauthorized to view Model");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to view Model"),
                    HttpStatus.FORBIDDEN);
        }

        try {
            if (!getMlModelRequest.getAudit()) {
                MlModel mlModel = null;

                try {
                    mlModel = mlModelService.findByModelIdAndTenant(getMlModelRequest.getImodelId(),
                            getMlModelRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }


                if (mlModel != null) {
                    MlModelDetailResponse mlModelDetailResponse = new MlModelDetailResponse();
                    mlModelDetailResponse.setModelId(mlModel.getImodelId());
                    mlModelDetailResponse.setModelName(mlModel.getVcMlFlowModelName());
                    mlModelDetailResponse.setDescription(mlModel.getVcMlFlowModelDescription());
                    mlModelDetailResponse.setVersion(mlModel.getIMlVersion());
                    mlModelDetailResponse.setDetail(mlModel.getVcModelDetail());
                    mlModelDetailResponse.setType(mlModel.getVcType());
                    mlModelDetailResponse.setVcRemark(mlModel.getVcRemark());
                    mlModelDetailResponse.setMakerChecker("M");
                    mlModelDetailResponse.setItenantId(mlModel.getItenantId());
                    mlModelDetailResponse.setTenantName(tenantRepositoryService.findByItenantId(mlModel.getItenantId()).getTenantName());

                    JsonNode modelDetail = mlModel.getVcModelDetail();
                    if (modelDetail != null && modelDetail.has("registered_model")) {
                        JsonNode registeredModel = modelDetail.get("registered_model");

                        if (registeredModel.has("latest_versions")) {
                            JsonNode latestVersionsArray = registeredModel.get("latest_versions");

                            if (latestVersionsArray != null && latestVersionsArray.isArray() && !latestVersionsArray.isEmpty()) {
                                JsonNode latestVersion = latestVersionsArray.get(0);

                                if (latestVersion != null && !latestVersion.isMissingNode()) {
                                    String modelStatus = latestVersion.path("current_stage").asText(null);
                                    mlModelDetailResponse.setModelStatus(modelStatus);

                                    long creationTimestampMs = registeredModel.path("creation_timestamp").asLong(0);
                                    long updateTimestampMs = registeredModel.path("last_updated_timestamp").asLong(0);

                                    ZonedDateTime creationTime = creationTimestampMs != 0
                                            ? Instant.ofEpochMilli(creationTimestampMs).atZone(ZoneId.of("Asia/Kolkata"))
                                            : null;

                                    ZonedDateTime updateTime = updateTimestampMs != 0
                                            ? Instant.ofEpochMilli(updateTimestampMs).atZone(ZoneId.of("Asia/Kolkata"))
                                            : null;

                                    mlModelDetailResponse.setCreationTimestamp(creationTime);
                                    mlModelDetailResponse.setLastUpdateTimestamp(updateTime);
                                }
                            }
                        }
                    }

                    LOGGER.debug("Exiting getAvailable Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameters type get Model details");
                    activityLogService.addActivity(loggedInUser,
                            "Model details accessed successfully");
                    return ResponseEntity.ok(mlModelDetailResponse);
                }else{
                    LOGGER.debug("Exiting getAvailableMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameters type get available Model");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access Model details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Unable to find Model"),
                            HttpStatus.BAD_REQUEST);
                }
            } else {
                MlModelAudit audit = null;

                try {
                    audit = mlModelAuditService.findPendingMlModelAuditByAuditIDAndTenant(getMlModelRequest.getImodelId(),
                            getMlModelRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (audit != null) {
                    MlModelDetailResponse mlModelDetailResponse = new MlModelDetailResponse();
                    mlModelDetailResponse.setModelId(audit.getImodelId());
                    mlModelDetailResponse.setModelName(audit.getVcMlFlowModelName());
                    mlModelDetailResponse.setDescription(audit.getVcMlFlowModelDescription());
                    mlModelDetailResponse.setVersion(audit.getIMlVersion());
                    mlModelDetailResponse.setDetail(audit.getVcModelDetail());
                    mlModelDetailResponse.setType(audit.getVcType());
                    mlModelDetailResponse.setVcRemark(audit.getVcRemark());
                    mlModelDetailResponse.setMakerChecker(!Objects.equals(audit.getIEntryUserID(),
                            loggedInUser.getIuserID()) ? "C" : "M");
                    mlModelDetailResponse.setItenantId(audit.getItenantId());
                    mlModelDetailResponse.setTenantName(tenantRepositoryService.findByItenantId(audit.getItenantId()).getTenantName());

                    JsonNode modelDetail = audit.getVcModelDetail();
                    if (modelDetail != null && modelDetail.has("registered_model")) {
                        JsonNode registeredModel = modelDetail.get("registered_model");

                        if (registeredModel.has("latest_versions")) {
                            JsonNode latestVersionsArray = registeredModel.get("latest_versions");

                            if (latestVersionsArray != null && latestVersionsArray.isArray() && !latestVersionsArray.isEmpty()) {
                                JsonNode latestVersion = latestVersionsArray.get(0);

                                if (latestVersion != null && !latestVersion.isMissingNode()) {
                                    String modelStatus = latestVersion.path("current_stage").asText(null);
                                    mlModelDetailResponse.setModelStatus(modelStatus);

                                    long creationTimestampMs = registeredModel.path("creation_timestamp").asLong(0);
                                    long updateTimestampMs = registeredModel.path("last_updated_timestamp").asLong(0);

                                    ZonedDateTime creationTime = creationTimestampMs != 0
                                            ? Instant.ofEpochMilli(creationTimestampMs).atZone(ZoneId.of("Asia/Kolkata"))
                                            : null;

                                    ZonedDateTime updateTime = updateTimestampMs != 0
                                            ? Instant.ofEpochMilli(updateTimestampMs).atZone(ZoneId.of("Asia/Kolkata"))
                                            : null;

                                    mlModelDetailResponse.setCreationTimestamp(creationTime);
                                    mlModelDetailResponse.setLastUpdateTimestamp(updateTime);
                                }
                            }
                        }
                    }

                    LOGGER.debug("Exiting getAvailableMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameters type get Model details");
                    activityLogService.addActivity(loggedInUser,
                            "Model details accessed successfully");
                    return ResponseEntity.ok(mlModelDetailResponse);
                }
                else{
                    LOGGER.debug("Exiting getAvailableMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameters type get Model details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access Model details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No pending Model entries found"),
                            HttpStatus.BAD_REQUEST);
                }
            }
        } catch (Exception e) {
            LOGGER.error("Error in getAvailableMlModel: " + e + "\nParams: " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Failed to get Model details", e.toString());
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    @Override
    public ResponseEntity<?> getListOfTrainedMlModels(Authentication pr){
        LOGGER.debug("entered in class " + MlModelControllerServiceImpl.class + " in method getListOfTrainedMlModels");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isView()) {
            activityLogService.addActivity(loggedInUser,
                    "unauthorized to access available Models list");
            LOGGER.debug("Exiting getListOfTrainedMlModels Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : Unauthorized to access list of trained Models");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Unauthorized to access list of Trained Models"),
                    HttpStatus.FORBIDDEN);
        }

        MlModelTrainedListView mlModelTrainedListView = new MlModelTrainedListView();
        mlModelTrainedListView.setAdd(mp.isAdd());
        mlModelTrainedListView.setApprove(mp.isApprove());
        mlModelTrainedListView.setDelete(mp.isDelete());
        mlModelTrainedListView.setEdit(mp.isEdit());
        mlModelTrainedListView.setView(mp.isView());

        try {
            List<Integer> tenantIds = loggedUser.getUserTenant();

            // Step 1: Get MLFlow trained models
            ResponseEntity<String> mlflowResponse;
            try{
                mlflowResponse = mlModelApiService.getTrainedModels(tenantIds);
                if (!mlflowResponse.getStatusCode().is2xxSuccessful()) {
                    LOGGER.error("Failed to fetch models from ML Flow API : " + mlflowResponse);
                    activityLogService.addActivity(loggedInUser, "failed to get trained Model details",
                            mlflowResponse.toString());
                    return new ResponseEntity<>(new ApiResponse(false,
                            "Failed to fetch models from ML Flow"), mlflowResponse.getStatusCode());
                }
            } catch (Exception e) {
                LOGGER.error("Exception occurred while fetching trained models from ML Flow" + e);
                activityLogService.addActivity(loggedInUser, "failed to get trained Model details",
                        e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // Step 2: Get existing models and audits
            List<MlModel> mlModelsList = mlModelService.findAllNonDeletedTenants(tenantIds);
            mlModelsList = mlModelsList.stream().filter(c -> c.getIrecordStatus() == 0)
                    .collect(Collectors.toList());
            List<MlModelAudit> mlModelAudits = mlModelAuditService.findPendingEntriesTenant(tenantIds);

            // Build set of (modelName|tenantId) from mlModelsList and mlModelAudits
            Set<String> existingProductionKeys = new HashSet<>();
            for (MlModel model : mlModelsList) {
                JsonNode detail = model.getVcModelDetail();
                String modelName = null;
                if (detail != null && detail.isObject()) {
                    JsonNode modelNameNode = detail.path("registered_model").path("name");
                    if (modelNameNode != null && modelNameNode.isTextual()) {
                        modelName = modelNameNode.asText();
                    } else {
                        LOGGER.info("modelName not found or not textual in vcModelDetail for modelId={}, falling back to default version", model.getImodelId());
                    }
                } else {
                    LOGGER.info("vcModelDetail is null or not an object for modelId={}, falling back to default version", model.getImodelId());
                }
                if (modelName != null) {
                    existingProductionKeys.add(modelName + "|" + model.getItenantId());
                } else {
                    LOGGER.info("Model name not found in vcModelDetail for modelId={}, skipping from key set", model.getImodelId());
                }
            }

            for (MlModelAudit audit : mlModelAudits) {
                JsonNode detail = audit.getVcModelDetail();
                String modelName = null;
                if (detail != null && detail.isObject()) {
                    JsonNode modelNameNode = detail.path("registered_model").path("name");
                    if (modelNameNode != null && modelNameNode.isTextual()) {
                        modelName = modelNameNode.asText();
                    } else {
                        LOGGER.info("modelName not found or not textual in vcModelDetail for auditId={}, falling back to default version", audit.getImodelAuditId());
                    }
                } else {
                    LOGGER.info("vcModelDetail is null or not an object for auditId={}, falling back to default version", audit.getImodelAuditId());
                }
                if (modelName != null) {
                    existingProductionKeys.add(modelName + "|" + audit.getItenantId());
                } else {
                    LOGGER.info("Model name not found in vcModelDetail for auditId={}, skipping from key set", audit.getImodelAuditId());
                }
            }

            // Step 3: Parse ML Flow API response
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(mlflowResponse.getBody());
            JsonNode models = root.path("registered_models");

            List<MlModelTrainedResponse> trainedModels = new ArrayList<>();

            for (JsonNode modelNode : models) {

                JsonNode latestVersions = modelNode.path("latest_versions");
                if (latestVersions == null || !latestVersions.isArray() || latestVersions.isEmpty()) {
                    continue;
                }

                String modelName = modelNode.path("name").asText();

                JsonNode tags = modelNode.path("tags");
                Integer tenantId = null;

                for (JsonNode tag : tags) {
                    if ("tenant".equals(tag.path("key").asText())) {
                        tenantId = Integer.valueOf(tag.path("value").asText());
                        break;
                    }
                }

                if (tenantId == null || !tenantIds.contains(tenantId)) continue;

                String tenantName = tenantRepositoryService.findByItenantId(tenantId).getTenantName();

                ZonedDateTime createdDate = null;
                ZonedDateTime lastUpdate = null;
                long createdTs = modelNode.path("creation_timestamp").asLong(0);
                long updatedTs = modelNode.path("last_updated_timestamp").asLong(0);

                if (createdTs > 0) {
                    createdDate = Instant.ofEpochMilli(createdTs).atZone(ZoneId.of("Asia/Kolkata"));
                }
                if (updatedTs > 0) {
                    lastUpdate = Instant.ofEpochMilli(updatedTs).atZone(ZoneId.of("Asia/Kolkata"));
                }

                for (JsonNode version : latestVersions) {
                    long createdTimestamp = version.path("creation_timestamp").asLong(0);
                    long updatedTimestamp = version.path("last_updated_timestamp").asLong(0);

                    if (createdTimestamp > 0) {
                        createdDate = Instant.ofEpochMilli(createdTimestamp).atZone(ZoneId.of("Asia/Kolkata"));
                    }
                    if (updatedTimestamp > 0) {
                        lastUpdate = Instant.ofEpochMilli(updatedTimestamp).atZone(ZoneId.of("Asia/Kolkata"));
                    }

                    String stage = version.path("current_stage").asText();
                    String versionStr = version.path("version").asText();
                    Double latestVersion = null;
                    try {
                        latestVersion = versionStr != null ? Double.parseDouble(versionStr) : null;
                    } catch (NumberFormatException e) {
                        LOGGER.debug("Invalid version format for model: {}", version.path("version").asText(), e);
                    }

                    String key = modelName + "|" + tenantId;

                    // Skip only if Production version already exists in local model or audit
                    if (MlModelStatus.Production.name().equalsIgnoreCase(stage) && existingProductionKeys.contains(key)) {
                        continue;
                    }

                    MlModelTrainedResponse response = MlModelTrainedResponse.builder()
                            .modelName(modelName)
                            .description(version.path("description").asText(null))
                            .latestVersion(latestVersion)
                            .modelStatus(stage)
                            .createdDate(createdDate)
                            .lastUpdate(lastUpdate)
                            .itenantId(tenantId)
                            .tenantName(tenantName)
                            .build();

                    trainedModels.add(response);
                }
            }

            mlModelTrainedListView.setMlModelTrainedList(trainedModels);

            LOGGER.debug("Exiting getListOfTrainedMlModels Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : with parameters type dropdown");
            activityLogService.addActivity(loggedInUser, "Trained Models list accessed");
            return ResponseEntity.ok(mlModelTrainedListView);

        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Failed to get Trained Models List", e.toString());
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }

    }

    @Override
    public ResponseEntity<?> getTrainedMlModel(GetTrainedMlModelRequest getTrainedMlModelRequest, Authentication pr) {
        LOGGER.debug("Entered getTrainedMlModel in class " + MlModelControllerServiceImpl.class);

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isView()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to view Model");
            LOGGER.debug("Exiting getTrainedMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : unauthorized to view Model");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to view Model"), HttpStatus.FORBIDDEN);
        }

        String modelNameReq = getTrainedMlModelRequest.getModelName();
        Integer tenantIdReq = getTrainedMlModelRequest.getItenantId();
        String desiredStage = getTrainedMlModelRequest.getModelStatus();

        try {

            ResponseEntity<String> response = mlModelApiService.getTrainedModels(Collections.singletonList(tenantIdReq));

            if (!response.getStatusCode().is2xxSuccessful()) {
                LOGGER.error("Failed to fetch models from ML Flow API : " + response);
                activityLogService.addActivity(loggedInUser, "failed to get trained Model details",
                        response.toString());
                return new ResponseEntity<>(new ApiResponse(false,
                        "Failed to fetch models from ML Flow"), response.getStatusCode());
            }

            String body = response.getBody();
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(body);

            JsonNode models = root.path("registered_models");
            if (!models.isArray() || models.isEmpty()) {
                return new ResponseEntity<>(new ApiResponse(false, "No models found"), HttpStatus.NOT_FOUND);
            }

            JsonNode matchedModel = null;
            for (JsonNode model : models) {
                if (!model.path("name").asText().equals(modelNameReq)) continue;

                JsonNode tags = model.path("tags");
                if (tags.isArray() && !tags.isEmpty()) {
                    for (JsonNode tag : tags) {
                        if ("tenant".equals(tag.path("key").asText()) &&
                                tenantIdReq.toString().equals(tag.path("value").asText())) {
                            matchedModel = model;
                            break;
                        }
                    }
                }
                if (matchedModel != null) break;
            }

            if (matchedModel == null) {
                return new ResponseEntity<>(new ApiResponse(false, "Requested model not found"), HttpStatus.NOT_FOUND);
            }

            MlModelDetailResponse mlModelDetailResponse = new MlModelDetailResponse();
            mlModelDetailResponse.setModelName(modelNameReq);
            mlModelDetailResponse.setItenantId(tenantIdReq);
            mlModelDetailResponse.setTenantName(tenantRepositoryService.findByItenantId(tenantIdReq).getTenantName());
            mlModelDetailResponse.setDescription(matchedModel.path("description").asText(null));

            long creationTimestampMs = matchedModel.path("creation_timestamp").asLong(0);
            long updateTimestampMs = matchedModel.path("last_updated_timestamp").asLong(0);

            ZonedDateTime creationTime = creationTimestampMs != 0
                    ? Instant.ofEpochMilli(creationTimestampMs).atZone(ZoneId.of("Asia/Kolkata"))
                    : null;
            ZonedDateTime updateTime = updateTimestampMs != 0
                    ? Instant.ofEpochMilli(updateTimestampMs).atZone(ZoneId.of("Asia/Kolkata"))
                    : null;

            mlModelDetailResponse.setCreationTimestamp(creationTime);
            mlModelDetailResponse.setLastUpdateTimestamp(updateTime);

            JsonNode selectedVersion = null;

            JsonNode latestVersions = matchedModel.path("latest_versions");
            if (latestVersions != null && latestVersions.isArray() && !latestVersions.isEmpty()) {

                for (JsonNode versionNode : latestVersions) {
                    String currentStage = versionNode.path("current_stage").asText();
                    String name = versionNode.path("name").asText();
                    if (desiredStage.equalsIgnoreCase(currentStage)
                            && name.equals(modelNameReq)) {
                        selectedVersion = versionNode;
                        break;
                    }
                }

                if (selectedVersion != null) {
                    mlModelDetailResponse.setModelStatus(selectedVersion.path("current_stage").asText(null));
                    if (selectedVersion.hasNonNull("description")) {
                        mlModelDetailResponse.setDescription(selectedVersion.get("description").asText());
                    }

                    String versionStr = selectedVersion.path("version").asText(null);
                    Double version = null;
                    if (versionStr != null) {
                        try {
                            version = Double.parseDouble(versionStr);
                        } catch (NumberFormatException ex) {
                            LOGGER.debug("Invalid version format for model: {}", versionStr, ex);
                        }
                    }
                    mlModelDetailResponse.setVersion(version);

                    if(selectedVersion.hasNonNull("creation_timestamp")){
                        long selectedUpdateTs = selectedVersion.path("creation_timestamp").asLong(0);
                        mlModelDetailResponse.setLastUpdateTimestamp(
                                selectedUpdateTs != 0 ? Instant.ofEpochMilli(selectedUpdateTs).atZone(ZoneId.of("Asia/Kolkata")) : null
                        );
                    }
                    if(selectedVersion.hasNonNull("last_updated_timestamp")){
                        long selectedCreationTs = selectedVersion.path("last_updated_timestamp").asLong(0);
                        mlModelDetailResponse.setCreationTimestamp(
                                selectedCreationTs != 0 ? Instant.ofEpochMilli(selectedCreationTs).atZone(ZoneId.of("Asia/Kolkata")) : null
                        );
                    }

                } else {
                    mlModelDetailResponse.setModelStatus(null);
                    mlModelDetailResponse.setVersion(null);
                }
            } else {
                mlModelDetailResponse.setModelStatus(null);
                mlModelDetailResponse.setVersion(null);
            }

            // Create a trimmed version of the matched model with only relevant version
            ObjectNode registeredModelNode = mapper.createObjectNode();

            registeredModelNode.put("name", matchedModel.path("name").asText(null));

            String description = (selectedVersion != null && selectedVersion.has("description"))
                    ? selectedVersion.path("description").asText(null)
                    : matchedModel.path("description").asText(null);
            registeredModelNode.put("description", description);

            long creationTs = (selectedVersion != null && selectedVersion.has("creation_timestamp"))
                    ? selectedVersion.path("creation_timestamp").asLong(0)
                    : matchedModel.path("creation_timestamp").asLong(0);

            long updateTs = (selectedVersion != null && selectedVersion.has("last_updated_timestamp"))
                    ? selectedVersion.path("last_updated_timestamp").asLong(0)
                    : matchedModel.path("last_updated_timestamp").asLong(0);

            registeredModelNode.put("creation_timestamp", creationTs);
            registeredModelNode.put("last_updated_timestamp", updateTs);

            // Set relevant version into latest_versions array
            ArrayNode trimmedVersions = mapper.createArrayNode();
            if (selectedVersion != null) {
                trimmedVersions.add(selectedVersion); // Only 1 version added
            }
            registeredModelNode.set("latest_versions", trimmedVersions);

            // Set relevant tag(s)
            ArrayNode trimmedTags = mapper.createArrayNode();
            JsonNode tags = matchedModel.path("tags");
            if (tags.isArray() && !tags.isEmpty()) {
                for (JsonNode tag : tags) {
                    if ("tenant".equals(tag.path("key").asText()) &&
                            tenantIdReq.toString().equals(tag.path("value").asText())) {
                        trimmedTags.add(tag);
                        break;
                    }
                }
            }
            registeredModelNode.set("tags", trimmedTags);

            // Wrap under "registered_model"
            ObjectNode finalDetail = mapper.createObjectNode();
            finalDetail.set("registered_model", registeredModelNode);

            // Set in response
            mlModelDetailResponse.setDetail(finalDetail);

            LOGGER.debug("Exiting getTrainedMlModel Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : with parameters type get Model details");
            activityLogService.addActivity(loggedInUser,
                    "Model details accessed successfully");
            return ResponseEntity.ok(mlModelDetailResponse);

        } catch (Exception e) {
            LOGGER.error("Error in getAvailableMlModel: " + e + "\nParams: " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Failed to get Model details", e.toString());
            return new ResponseEntity<>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    @Override
    public ResponseEntity<?> addMlModel(AddMlModelRequest addMlModelRequest, Authentication pr) {
        LOGGER.debug("Entered in addMlModel method in class {}", MlModelControllerServiceImpl.class);

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isAdd()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to add Model");
            LOGGER.debug("Exiting addMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : unauthorized to add Model");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to add Model"), HttpStatus.FORBIDDEN);
        }

        if (!MlModelStatus.Production.name().equalsIgnoreCase(addMlModelRequest.getModelStatus())) {
            LOGGER.debug("Exiting  addMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : with parameter add Model request");
            activityLogService.addActivity(loggedInUser, "failed to save new Model with invalid status: " + addMlModelRequest.getModelStatus());
            return new ResponseEntity<>(
                    new ApiResponse(false, "Only models in 'Production' stage can be added"),
                    HttpStatus.BAD_REQUEST
            );
        }

        if (addMlModelRequest.getModelDetail() == null || addMlModelRequest.getModelDetail().isEmpty()){
            LOGGER.debug("Exiting addMlModel Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : Model Detail cannot be Blank");
            activityLogService.addActivity(loggedInUser,
                    "Failed to add Model");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Model Detail cannot be Blank"),
                    HttpStatus.BAD_REQUEST);
        }

        MlModel existName = null;

        try {
            existName = mlModelService.findByModelName(addMlModelRequest.getMlModelName(), addMlModelRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Exiting  addMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : with parameter add Model request");
            activityLogService.addActivity(loggedInUser, "failed to save new Model",
                    addMlModelRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (existName != null) {
            LOGGER.debug("Exiting  addMlModel Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : with parameter add Model request");
            activityLogService.addActivity(loggedInUser, "failed to save new Model",
                    addMlModelRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Model name already exists"),
                    HttpStatus.CONFLICT);
        }

        MlModelAudit existAuditName = null;

        try {
            existAuditName = mlModelAuditService
                    .findByModelName(addMlModelRequest.getMlModelName(), addMlModelRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Exiting addMlModel Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : with parameter add Model request");
            activityLogService.addActivity(loggedInUser, "failed to save new Model",
                    addMlModelRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (existAuditName != null) {
            LOGGER.debug("Exiting addMlModel Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : with parameter add Model request");
            activityLogService.addActivity(loggedInUser, "failed to save new Model",
                    addMlModelRequest.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false,
                            "Model name already exists in audit"),
                    HttpStatus.CONFLICT);
        }

        MlModelAudit audit = new MlModelAudit();
        audit.setVcMlFlowModelName(addMlModelRequest.getMlModelName());
        audit.setVcMlFlowModelDescription(addMlModelRequest.getMlModelDescription());
        audit.setIMlVersion(addMlModelRequest.getMlVersion());
        audit.setVcType(addMlModelRequest.getModelType());
        audit.setVcModelDetail(addMlModelRequest.getModelDetail());
        audit.setItenantId(addMlModelRequest.getItenantId());
        audit.setIrecordStatus(0);
        audit.setBclosed(false);
        audit.setVcAction("A");
        audit.setVcRemark(addMlModelRequest.getMakerRemark());
        audit.setIEntryUserID(loggedInUser.getIuserID());
        audit.setIorgId(loggedInUser.getIorgId());
        audit.setDtEntryStamp(ZonedDateTime.now());

        try {
            audit = mlModelAuditService.saveMlModelAudit(audit);
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "Failed to save Model audit entry", e.toString());
            return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        activityLogService.addActivity(loggedInUser, "Model addition sent for approval");
        return new ResponseEntity<>(new ApiResponse(true, "Model addition sent for approval"), HttpStatus.ACCEPTED);
    }

    @Override
    public ResponseEntity<?> editMlModel(EditMlModelRequest editMlModelRequest, Authentication pr){
        LOGGER.debug("entered in class " + MlModelControllerServiceImpl.class + " in method editMlModel");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isEdit()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to edit Model");
            LOGGER.debug("Exiting editMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : unauthorized to edit Model");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to edit Model"),
                    HttpStatus.FORBIDDEN);
        }

        if (!MlModelStatus.Production.name().equalsIgnoreCase(editMlModelRequest.getModelStatus())) {
            LOGGER.debug("Exiting  editMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : with parameter edit Model request");
            activityLogService.addActivity(loggedInUser, "failed to edit Model with invalid status: " + editMlModelRequest.getModelStatus());
            return new ResponseEntity<>(
                    new ApiResponse(false, "Only models in 'Production' stage can be edited"),
                    HttpStatus.BAD_REQUEST
            );
        }

        if (editMlModelRequest.getAudit()) {
            if(editMlModelRequest.getIsVersionUpdate()){
                LOGGER.debug("Exiting editMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : with parameters type edit Model details");
                activityLogService.addActivity(loggedInUser,
                        "Failed to access Model details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Version update is not allowed for entries in audit"),
                        HttpStatus.BAD_REQUEST);
            } else{
                MlModelAudit audit = null;
                try {
                    audit = mlModelAuditService.findPendingMlModelAuditByAuditIDAndTenant(
                            editMlModelRequest.getImodelId(), editMlModelRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to get pending Model",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (audit != null) {
                    MlModel existName = null;

                    try {
                        existName = mlModelService.findByModelName(editMlModelRequest.getMlModelName(), editMlModelRequest.getItenantId());
                    } catch (Exception e) {
                        LOGGER.error("Exiting  editMlModel Method in " + MlModelControllerServiceImpl.class
                                + " class with response  : with parameter edit Model request");
                        activityLogService.addActivity(loggedInUser, "failed to edit Model",
                                editMlModelRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (existName != null && !Objects.equals(audit.getImodelId(), existName.getImodelId())) {
                        LOGGER.debug("Exiting  editMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : with parameter add Model request");
                        activityLogService.addActivity(loggedInUser, "failed to edit Model",
                                editMlModelRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Model name already exists"),
                                HttpStatus.CONFLICT);
                    }

                    MlModelAudit existAuditName = null;

                    try {
                        existAuditName = mlModelAuditService
                                .findByModelName(editMlModelRequest.getMlModelName(), editMlModelRequest.getItenantId());
                    } catch (Exception e) {
                        LOGGER.error("Exiting editMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : with parameter add Model request");
                        activityLogService.addActivity(loggedInUser, "failed to edit Model",
                                editMlModelRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (existAuditName != null && !Objects.equals(audit.getImodelAuditId(), existAuditName.getImodelAuditId())) {
                        LOGGER.debug("Exiting editMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : with parameter add Model request");
                        activityLogService.addActivity(loggedInUser, "failed to edit Model",
                                editMlModelRequest.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Model name already exists in audit"),
                                HttpStatus.CONFLICT);
                    }

                    if (!Objects.equals(audit.getIEntryUserID(), loggedInUser.getIuserID())) {
                        LOGGER.debug("Exiting editMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : Only Maker can edit this entry");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to edit Model");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Only Maker can edit this entry"),
                                HttpStatus.BAD_REQUEST);
                    }

                    if(!Objects.equals(audit.getItenantId(), editMlModelRequest.getItenantId())){
                        LOGGER.debug("Exiting editMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : Tenant cannot be modified");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to edit Model");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Tenant cannot be modified"),
                                HttpStatus.BAD_REQUEST);
                    }

                    if(!Objects.equals(audit.getIMlVersion(), editMlModelRequest.getMlVersion())){
                        LOGGER.debug("Exiting editMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : Version cannot be modified");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to edit Model");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Version cannot be modified"),
                                HttpStatus.BAD_REQUEST);
                    }

                    if (editMlModelRequest.getModelDetail() == null || editMlModelRequest.getModelDetail().isEmpty()){
                        LOGGER.debug("Exiting editMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : Model Detail cannot be Blank");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to edit Model");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        "Model Detail cannot be Blank"),
                                HttpStatus.BAD_REQUEST);
                    }

                    audit.setVcMlFlowModelName(editMlModelRequest.getMlModelName());
                    audit.setVcMlFlowModelDescription(editMlModelRequest.getMlModelDescription());
                    audit.setVcType(editMlModelRequest.getModelType());
                    audit.setVcRemark(editMlModelRequest.getMakerRemark());

                    JsonNode originalDetail = audit.getVcModelDetail();
                    if (originalDetail != null && originalDetail.isObject()) {
                        ObjectNode updatedDetail = originalDetail.deepCopy();
                        JsonNode registeredModel = updatedDetail.path("registered_model");

                        if (registeredModel.isObject()) {

                            if (registeredModel.has("description")) {
                                ((ObjectNode) registeredModel).put("description", editMlModelRequest.getMlModelDescription());
                            }

                            JsonNode versions = registeredModel.path("latest_versions");
                            if (versions.isArray() && !versions.isEmpty()) {
                                JsonNode versionNode = versions.get(0);
                                if (versionNode.isObject() && versionNode.has("description")) {
                                    ((ObjectNode) versionNode).put("description", editMlModelRequest.getMlModelDescription());
                                }
                            }
                        }

                        audit.setVcModelDetail(updatedDetail);
                    } else {
                        audit.setVcModelDetail(editMlModelRequest.getModelDetail());
                    }

                    try {
                        mlModelAuditService.saveMlModelAudit(audit);
                    } catch (Exception e){
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to edit Model audit entry", e.toString());
                        return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    LOGGER.debug("Exiting editMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : Model edition sent for approval");
                    activityLogService.addActivity(loggedInUser,
                            "Model edition sent for approval");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(true, "Model edition sent for approval"),
                            HttpStatus.OK);
                } else {

                    LOGGER.debug("Exiting editMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameters type edit Model details");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to access Model details");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "No pending entries found"),
                            HttpStatus.BAD_REQUEST);
                }
            }

        } else{

            MlModelAudit exist = null;
            try {
                exist = mlModelAuditService.findPendingMlModelAuditByModelIDAndTenant(
                        editMlModelRequest.getImodelId(), editMlModelRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : "
                        + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to fetch pending Model entries",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (exist != null) {
                LOGGER.debug("Exiting editMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : with parameters type edit Model details");
                activityLogService.addActivity(loggedInUser,
                        "Failed to access Model details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Entry is already pending for action"),
                        HttpStatus.BAD_REQUEST);
            }


            MlModel mlModel = null;
            try {
                mlModel = mlModelService.findByModelIdAndTenant(
                        editMlModelRequest.getImodelId(), editMlModelRequest.getItenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : "
                        + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (mlModel == null) {
                LOGGER.debug("Exiting editMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : with parameters type edit Model details");
                activityLogService.addActivity(loggedInUser,
                        "Failed to access Model details");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "Unable to find Model"),
                        HttpStatus.BAD_REQUEST);
            }

            if(!editMlModelRequest.getIsVersionUpdate()){
                MlModel existName = null;

                try {
                    existName = mlModelService.findByModelName(editMlModelRequest.getMlModelName(), editMlModelRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Exiting  editMlModel Method in " + MlModelControllerServiceImpl.class
                            + " class with response  : with parameter edit Model request");
                    activityLogService.addActivity(loggedInUser, "failed to edit Model",
                            editMlModelRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (existName != null && !Objects.equals(mlModel.getImodelId(), existName.getImodelId())) {
                    LOGGER.debug("Exiting  editMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameter add Model request");
                    activityLogService.addActivity(loggedInUser, "failed to edit Model",
                            editMlModelRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Model name already exists"),
                            HttpStatus.CONFLICT);
                }

                MlModelAudit existAuditName = null;

                try {
                    existAuditName = mlModelAuditService
                            .findByModelName(editMlModelRequest.getMlModelName(), editMlModelRequest.getItenantId());
                } catch (Exception e) {
                    LOGGER.error("Exiting editMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameter edit Model request");
                    activityLogService.addActivity(loggedInUser, "failed to edit Model",
                            editMlModelRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (existAuditName != null) {
                    LOGGER.debug("Exiting editMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameter edit Model request");
                    activityLogService.addActivity(loggedInUser, "failed to edit Model",
                            editMlModelRequest.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Model name already exists in audit"),
                            HttpStatus.CONFLICT);
                }
            }

            if(!Objects.equals(mlModel.getItenantId(), editMlModelRequest.getItenantId())){
                LOGGER.debug("Exiting editMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : Tenant cannot be modified");
                activityLogService.addActivity(loggedInUser,
                        "Tenant cannot be modified");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Tenant cannot be modified"),
                        HttpStatus.BAD_REQUEST);
            }

            if (editMlModelRequest.getModelDetail() == null || editMlModelRequest.getModelDetail().isEmpty()){
                LOGGER.debug("Exiting editMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : Model Detail cannot be Blank");
                activityLogService.addActivity(loggedInUser,
                        "Failed to edit Model");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false,
                                "Model Detail cannot be Blank"),
                        HttpStatus.BAD_REQUEST);
            }

            MlModelAudit audit = new MlModelAudit();

            audit.setImodelId(editMlModelRequest.getImodelId());
            audit.setVcMlFlowModelName(editMlModelRequest.getMlModelName());
            audit.setItenantId(mlModel.getItenantId());
            audit.setIrecordStatus(mlModel.getIrecordStatus());
            audit.setBclosed(false);
            audit.setVcAction("M");
            audit.setVcRemark(editMlModelRequest.getMakerRemark());
            audit.setIEntryUserID(loggedInUser.getIuserID());
            audit.setIorgId(loggedInUser.getIorgId());
            audit.setDtEntryStamp(ZonedDateTime.now());

            String msg = "";
            JsonNode originalDetail = mlModel.getVcModelDetail();

            if(editMlModelRequest.getIsVersionUpdate()){
                if(!Objects.equals(mlModel.getVcMlFlowModelDescription(), editMlModelRequest.getMlModelDescription())){
                    LOGGER.debug("Exiting editMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : Model Description cannot be modified");
                    activityLogService.addActivity(loggedInUser,
                            "Model Description cannot be modified");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Model Description cannot be modified while updating Model Version"),
                            HttpStatus.BAD_REQUEST);
                }

                if(!Objects.equals(mlModel.getVcType(), editMlModelRequest.getModelType())){
                    LOGGER.debug("Exiting editMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : Model Type cannot be modified");
                    activityLogService.addActivity(loggedInUser,
                            "Model Type cannot be modified");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Model Type cannot be modified while updating Model Version"),
                            HttpStatus.BAD_REQUEST);
                }
                audit.setVcMlFlowModelDescription(mlModel.getVcMlFlowModelDescription());
                audit.setVcType(mlModel.getVcType());
                audit.setIMlVersion(editMlModelRequest.getMlVersion());

                if (originalDetail != null && originalDetail.isObject()) {
                    ObjectNode updatedDetail = originalDetail.deepCopy();
                    JsonNode registeredModel = updatedDetail.path("registered_model");

                    if (registeredModel.isObject()) {
                        JsonNode versions = registeredModel.path("latest_versions");
                        if (versions.isArray() && !versions.isEmpty()) {
                            JsonNode versionNode = versions.get(0);
                            if (versionNode.isObject()) {
                                ((ObjectNode) versionNode).put("version", String.valueOf(editMlModelRequest.getMlVersion()));
                            }
                        }
                    }

                    audit.setVcModelDetail(updatedDetail);
                } else {
                    audit.setVcModelDetail(editMlModelRequest.getModelDetail());
                }

                msg = "Model Version updation sent for approval";
            }else{
                if(!Objects.equals(mlModel.getIMlVersion(), editMlModelRequest.getMlVersion())){
                    LOGGER.debug("Exiting editMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : Model Version cannot be modified while editing");
                    activityLogService.addActivity(loggedInUser,
                            "Model Version cannot be modified while editing");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    "Model Version cannot be modified while editing"),
                            HttpStatus.BAD_REQUEST);
                }
                audit.setIMlVersion(mlModel.getIMlVersion());
                audit.setVcMlFlowModelDescription(editMlModelRequest.getMlModelDescription());
                audit.setVcType(editMlModelRequest.getModelType());

                if (originalDetail != null && originalDetail.isObject()) {
                    ObjectNode updatedDetail = originalDetail.deepCopy();
                    JsonNode registeredModel = updatedDetail.path("registered_model");

                    if (registeredModel.isObject()) {

                        if (registeredModel.has("description")) {
                            ((ObjectNode) registeredModel).put("description", editMlModelRequest.getMlModelDescription());
                        }

                        JsonNode versions = registeredModel.path("latest_versions");
                        if (versions.isArray() && !versions.isEmpty()) {
                            JsonNode versionNode = versions.get(0);
                            if (versionNode.isObject() && versionNode.has("description")) {
                                ((ObjectNode) versionNode).put("description", editMlModelRequest.getMlModelDescription());
                            }
                        }
                    }

                    audit.setVcModelDetail(updatedDetail);
                } else {
                    audit.setVcModelDetail(editMlModelRequest.getModelDetail());
                }

                msg = "Model edition sent for approval";
            }

            try {
                audit = mlModelAuditService.saveMlModelAudit(audit);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to save Model audit entry", e.toString());
                return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
            }

            LOGGER.debug("Exiting editMlModel Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : with parameters edit Model");
            activityLogService.addActivity(loggedInUser, msg);
            return new ResponseEntity<>(new ApiResponse(true, msg), HttpStatus.OK);

        }
    }

    @Override
    public ResponseEntity<?> deleteMlModel(DeleteMlModelRequest deleteMlModelRequest, Authentication pr){
        LOGGER.debug("entering  class " + MlModelControllerServiceImpl.class + " and method deleteMlModel");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (mp == null || !mp.isDelete()) {
            activityLogService.addActivity(loggedInUser, "Unauthorized to delete Model");
            LOGGER.debug("Exiting deleteMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : unauthorized to delete Model");
            return new ResponseEntity<>(new ApiResponse(false, "Unauthorized to delete Model"),
                    HttpStatus.FORBIDDEN);
        }

        MlModelAudit exist = null;
        try {
            exist = mlModelAuditService.findPendingMlModelAuditByModelIDAndTenant(
                    deleteMlModelRequest.getImodelId(), deleteMlModelRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (exist != null) {
            LOGGER.debug("Exiting deleteMlModel Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : Entry is already pending for action");
            activityLogService.addActivity(loggedInUser, "Entry is already pending for action");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Entry is already pending for action"),
                    HttpStatus.BAD_REQUEST);
        }

        MlModel mlModel = null;

        try {
            mlModel = mlModelService.findByModelIdAndTenant(deleteMlModelRequest.getImodelId(), deleteMlModelRequest.getItenantId());
        } catch (Exception e) {
            LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
            activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }

        MlModelAudit newAudit = new MlModelAudit();
        if (mlModel != null) {
            newAudit = newAudit.parseToAudit(mlModel);
            newAudit.setDtEntryStamp(ZonedDateTime.now());
            newAudit.setIEntryUserID(loggedInUser.getIuserID());
            newAudit.setIorgId(loggedInUser.getIorgId());
            newAudit.setVcAction("X");
            newAudit.setIrecordStatus(1);
            newAudit.setIstatus(null);
            newAudit.setVcRemark(deleteMlModelRequest.getMakerRemark());
            try {
                newAudit = mlModelAuditService.saveMlModelAudit(newAudit);
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to save Model audit entry", e.toString());
                return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
            }
            LOGGER.debug("Exiting deleteMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response  : with parameters delete Model");
            activityLogService.addActivity(loggedInUser, "Model deletion sent for approval");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(true, "Model deletion sent for approval"),
                    HttpStatus.OK);
        } else {
            LOGGER.debug("Exiting deleteMlModel Method in "
                    + MlModelControllerServiceImpl.class
                    + " class with response  : No entry found for model id : " + deleteMlModelRequest.getImodelId());
            activityLogService.addActivity(loggedInUser, "Failed to delete Model ");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Model not found"),
                    HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public ResponseEntity<?> approveMlModel(ApproveMlModelRequest approveMlModelRequest, Authentication pr){
        LOGGER.debug("entering  class " + MlModelControllerServiceImpl.class + " and method approveMlModel");

        LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = loggedUser.getWebUser();
        MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

        if (!mp.isApprove()){
            activityLogService.addActivity(loggedInUser, "Unauthorized to approve Model");
            LOGGER.debug("Exiting approveMlModel Method in " + MlModelControllerServiceImpl.class
                    + " class with response : Unauthorized to approve Model");
            return new ResponseEntity<ApiResponse>(
                    new ApiResponse(false, "Unauthorized to approve Model"),
                    HttpStatus.FORBIDDEN);
        }

        if (approveMlModelRequest.getApprove()) {
            MlModelAudit audit = null;
            try {
                audit = mlModelAuditService.findPendingMlModelAuditByAuditIDAndTenant(
                        approveMlModelRequest.getImodelAuditId(), approveMlModelRequest.getTenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (audit != null) {
                if (Objects.equals(audit.getIEntryUserID(), loggedInUser.getIuserID())) {
                    LOGGER.debug("Exiting approveMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameters type approve Model");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to approve Model");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker cannot be checker"),
                            HttpStatus.BAD_REQUEST);
                }

                audit.setBclosed(true);
                audit.setVcRemark("{ " + audit.getVcRemark() + " }" + "{ "
                        + approveMlModelRequest.getCheckerRemark() + " }");
                switch (audit.getVcAction()) {
                    case "A" -> audit.setIstatus(statusCodeService.findByIStatusId(2));
                    case "M" -> audit.setIstatus(statusCodeService.findByIStatusId(3));
                    case "X" -> audit.setIstatus(statusCodeService.findByIStatusId(4));
                }
                audit.setDtApproverStamp(ZonedDateTime.now());
                audit.setIApproverUserID(loggedInUser.getIuserID());
                audit.setIorgId(loggedInUser.getIorgId());
                try{
                    audit = mlModelAuditService.saveMlModelAudit(audit);
                }catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to save approve Model audit entry", e.toString());
                    return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                }

                boolean isVersionUpdate = false;

                if ("M".equalsIgnoreCase(audit.getVcAction())) {
                    MlModel currentModel = null;
                    try {
                        currentModel = mlModelService.findByModelIdAndTenant(audit.getImodelId(), audit.getItenantId());
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                    if (currentModel == null) {
                        LOGGER.debug("Exiting approveMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : with parameters type approve Model");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to access Model details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Unable to find Model"),
                                HttpStatus.BAD_REQUEST);
                    } else {
                        Double currentVersion = currentModel.getIMlVersion();
                        Double newVersion = audit.getIMlVersion();

                        if (!Objects.equals(currentVersion, newVersion)) {
                            isVersionUpdate = true;
                        }
                    }
                }

                MlModel approvedAudit = null;
                ObjectMapper mapper = new ObjectMapper();

                try {
                    approvedAudit = audit.parseAudit(audit);

                    if(isVersionUpdate){
                        JsonNode existingDetail = audit.getVcModelDetail();
                        JsonNode registeredModel = existingDetail.path("registered_model");

                        String modelName = registeredModel.path("name").asText(null);
                        Integer tenantId = audit.getItenantId();
                        String desiredStage = MlModelStatus.Production.name();

                        if (modelName == null || tenantId == null) {
                            LOGGER.info("Missing modelName or tenantId in audit record");
                            return new ResponseEntity<>(new ApiResponse(false,
                                    ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        ResponseEntity<String> response = mlModelApiService.getTrainedModels(Collections.singletonList(tenantId));
                        if (!response.getStatusCode().is2xxSuccessful()) {
                            LOGGER.error("Failed to fetch models from ML Flow API during approval : " + response);
                            activityLogService.addActivity(loggedInUser, "failed to get trained Model details during approval",
                                    response.toString());
                            return new ResponseEntity<>(new ApiResponse(false,
                                    "Failed to fetch models from ML Flow during approval"), response.getStatusCode());
                        }

                        String body = response.getBody();
                        JsonNode root = mapper.readTree(body);

                        JsonNode models = root.path("registered_models");
                        if (!models.isArray() || models.isEmpty()) {
                            LOGGER.info("No registered_models found in MLflow response");
                            activityLogService.addActivity(loggedInUser, "No registered_models found in MLflow response",
                                    response.toString());
                            return new ResponseEntity<>(new ApiResponse(false,
                                    ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        JsonNode matchedModel = null;
                        for (JsonNode model : models) {
                            if (!model.path("name").asText().equals(modelName)) continue;

                            JsonNode tags = model.path("tags");
                            if (tags.isArray()) {
                                for (JsonNode tag : tags) {
                                    if ("tenant".equals(tag.path("key").asText()) &&
                                            tenantId.toString().equals(tag.path("value").asText())) {
                                        matchedModel = model;
                                        break;
                                    }
                                }
                            }
                            if (matchedModel != null) break;
                        }

                        if (matchedModel == null) {
                            LOGGER.info("Approved model not found in MLflow for name=" + modelName + ", tenantId=" + tenantId);
                            activityLogService.addActivity(loggedInUser, "Approved model not found in MLflow for name=" + modelName + ", tenantId=" + tenantId,
                                    response.toString());
                            return new ResponseEntity<>(new ApiResponse(false,
                                    ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                        }

                        JsonNode selectedVersion = null;
                        JsonNode latestVersions = matchedModel.path("latest_versions");
                        if (latestVersions != null && latestVersions.isArray()) {
                            for (JsonNode versionNode : latestVersions) {
                                if (modelName.equals(versionNode.path("name").asText())
                                        && desiredStage.equalsIgnoreCase(versionNode.path("current_stage").asText())) {
                                    selectedVersion = versionNode;
                                    break;
                                }
                            }
                        }

                        ObjectNode registeredModelNode = mapper.createObjectNode();
                        registeredModelNode.put("name", matchedModel.path("name").asText(null));

                        String description = (selectedVersion != null && selectedVersion.has("description"))
                                ? selectedVersion.path("description").asText(null)
                                : matchedModel.path("description").asText(null);
                        registeredModelNode.put("description", description);

                        long creationTs = (selectedVersion != null && selectedVersion.has("creation_timestamp"))
                                ? selectedVersion.path("creation_timestamp").asLong(0)
                                : matchedModel.path("creation_timestamp").asLong(0);

                        long updateTs = (selectedVersion != null && selectedVersion.has("last_updated_timestamp"))
                                ? selectedVersion.path("last_updated_timestamp").asLong(0)
                                : matchedModel.path("last_updated_timestamp").asLong(0);

                        registeredModelNode.put("creation_timestamp", creationTs);
                        registeredModelNode.put("last_updated_timestamp", updateTs);

                        ArrayNode trimmedVersions = mapper.createArrayNode();
                        if (selectedVersion != null) {
                            trimmedVersions.add(selectedVersion);
                        }
                        registeredModelNode.set("latest_versions", trimmedVersions);

                        ArrayNode trimmedTags = mapper.createArrayNode();
                        JsonNode tags = matchedModel.path("tags");
                        if (tags.isArray()) {
                            for (JsonNode tag : tags) {
                                if ("tenant".equals(tag.path("key").asText()) &&
                                        tenantId.toString().equals(tag.path("value").asText())) {
                                    trimmedTags.add(tag);
                                    break;
                                }
                            }
                        }
                        registeredModelNode.set("tags", trimmedTags);

                        ObjectNode finalModelDetail = mapper.createObjectNode();
                        finalModelDetail.set("registered_model", registeredModelNode);

                        approvedAudit.setVcModelDetail(finalModelDetail);
                    } else{
                        approvedAudit.setVcModelDetail(audit.getVcModelDetail());
                    }

                    approvedAudit.setLastStatus("Approved");
                    approvedAudit.setVcRemark(approveMlModelRequest.getCheckerRemark());
                    approvedAudit.setDtApproverStamp(ZonedDateTime.now());
                    approvedAudit = mlModelService.saveMlModel(approvedAudit);
                } catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : "
                            + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to save Model",
                            e.toString());
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false,
                                    ResponseMessages.GenericErrorMessage),
                            HttpStatus.INTERNAL_SERVER_ERROR);
                }

                String msg = "";
                if (audit.getVcAction().equalsIgnoreCase("A")) {
                    msg = "Model addition approved successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("M")) {
                    if(isVersionUpdate){
                        msg = "Model Version updation approved successfully";
                    }else{
                        msg = "Model edition approved successfully";
                    }
                } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                    msg = "Model deletion approved successfully";
                }
                LOGGER.debug("Exiting approveMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : with parameters approve Model");
                activityLogService.addActivity(loggedInUser, msg);
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                        HttpStatus.OK);

            } else {
                LOGGER.debug("Exiting approveMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : with parameters type approve Model");
                activityLogService.addActivity(loggedInUser,
                        "Failed to approve Model");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No pending entries found"),
                        HttpStatus.BAD_REQUEST);
            }
        } else {
            MlModelAudit audit = null;
            try {
                audit = mlModelAuditService.findPendingMlModelAuditByAuditIDAndTenant(
                        approveMlModelRequest.getImodelAuditId(), approveMlModelRequest.getTenantId());
            } catch (Exception e) {
                LOGGER.error("Error : " + e + "\nParam : "
                        + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                        e.toString());
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

            if (audit != null) {
                if (Objects.equals(audit.getIEntryUserID(), loggedInUser.getIuserID())) {
                    LOGGER.debug("Exiting approveMlModel Method in "
                            + MlModelControllerServiceImpl.class
                            + " class with response  : with parameters type approve Model");
                    activityLogService.addActivity(loggedInUser,
                            "Failed to approve Model");
                    return new ResponseEntity<ApiResponse>(
                            new ApiResponse(false, "Maker cannot be checker"),
                            HttpStatus.BAD_REQUEST);
                }

                audit.setBclosed(true);
                audit.setVcRemark("{ " + audit.getVcRemark() + " }" + "{ "
                        + approveMlModelRequest.getCheckerRemark() + " }");
                audit.setIstatus(statusCodeService.findByIStatusId(5));
                audit.setDtApproverStamp(ZonedDateTime.now());
                audit.setIApproverUserID(loggedInUser.getIuserID());
                audit.setIorgId(loggedInUser.getIorgId());
                try{
                    audit = mlModelAuditService.saveMlModelAudit(audit);
                }catch (Exception e) {
                    LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                    activityLogService.addActivity(loggedInUser, "failed to save approve Model audit entry", e.toString());
                    return new ResponseEntity<>(new ApiResponse(false, ResponseMessages.GenericErrorMessage), HttpStatus.INTERNAL_SERVER_ERROR);
                }

                boolean isVersionUpdate = false;

                if (audit.getImodelId() != null) {
                    MlModel mlModel = null;
                    try {
                        mlModel = mlModelService.findByModelIdAndTenant(audit.getImodelId(), audit.getItenantId());
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }

                    if (mlModel == null) {
                        LOGGER.debug("Exiting approveMlModel Method in "
                                + MlModelControllerServiceImpl.class
                                + " class with response  : with parameters type approve Model");
                        activityLogService.addActivity(loggedInUser,
                                "Failed to access Model details");
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false, "Unable to find Model"),
                                HttpStatus.BAD_REQUEST);
                    }

                    Double currentVersion = mlModel.getIMlVersion();
                    Double newVersion = audit.getIMlVersion();

                    if (!Objects.equals(currentVersion, newVersion)) {
                        isVersionUpdate = true;
                    }

                    mlModel.setLastStatus("Rejected");
                    mlModel.setVcRemark(approveMlModelRequest.getCheckerRemark());
                    mlModel.setDtApproverStamp(ZonedDateTime.now());
                    mlModel.setIApproverUserID(loggedInUser.getIuserID());
                    mlModel.setIorgId(loggedInUser.getIorgId());
                    try {
                        mlModelService.saveMlModel(mlModel);
                    } catch (Exception e) {
                        LOGGER.error("Error : " + e + "\nParam : "
                                + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser,
                                "failed to get user and permissions",
                                e.toString());
                        return new ResponseEntity<ApiResponse>(
                                new ApiResponse(false,
                                        ResponseMessages.GenericErrorMessage),
                                HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                }

                String msg = "";
                if (audit.getVcAction().equalsIgnoreCase("A")) {
                    msg = "Model addition rejected successfully";
                } else if (audit.getVcAction().equalsIgnoreCase("M")) {
                    if(isVersionUpdate){
                        msg = "Model Version updation rejected successfully";
                    }else{
                        msg = "Model edition rejected successfully";
                    }

                } else if (audit.getVcAction().equalsIgnoreCase("X")) {
                    msg = "Model deletion rejected successfully";
                }

                LOGGER.debug("Exiting approveMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : with parameters approve Model");
                activityLogService.addActivity(loggedInUser, msg);
                return new ResponseEntity<ApiResponse>(new ApiResponse(true, msg),
                        HttpStatus.OK);

            } else {
                LOGGER.debug("Exiting approveMlModel Method in "
                        + MlModelControllerServiceImpl.class
                        + " class with response  : with parameters type approve Model");
                activityLogService.addActivity(loggedInUser,
                        "Failed to approve Model");
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, "No pending entries found"),
                        HttpStatus.BAD_REQUEST);
            }
        }
    }

}