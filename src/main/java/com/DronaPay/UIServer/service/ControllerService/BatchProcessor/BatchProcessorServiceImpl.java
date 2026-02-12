
package com.DronaPay.UIServer.service.ControllerService.BatchProcessor;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.repository.JobDataRepository;
import com.DronaPay.UIServer.repository.WebUserRepository;
import com.DronaPay.UIServer.requests.CreateBatchJob;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.BatchJobResponseWithUsername;
import com.DronaPay.UIServer.service.ApiServices.ListApiService;
import com.DronaPay.UIServer.service.ApiServices.MastersApiService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.ListValidationUtil;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;

@Slf4j
@Service
public class BatchProcessorServiceImpl implements BatchProcessorService {

  private static final Logger LOGGER =
      LoggerFactory.getLogger(BatchProcessorServiceImpl.class);
  @Autowired StatusCodeService statusCodeService;
  @Autowired private BatchTypeService batchTypeService;
  @Autowired private BatchJobService batchJobService;
  @Autowired private JobDataService jobDataService;
  @Autowired private ActivityLogService activityLogService;
  @Autowired private WebUserService webUserService;
  @Autowired private LoggerEncoderUtil loggerEncoderUtil;
  @Autowired private ListApiService listApiService;
  @Autowired private ListMasterService listMasterService;
  @Autowired private ListReplicaServiceImpl listReplicaService;
  @Autowired private MastersApiService mastersApiService;
  @Autowired private JobDataRepository jobDataRepository;
  @Autowired private WebUserRepository webUserRepository;

  @Override
  public ResponseEntity<?> getBatchTypes(Authentication pr) {
    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();
    WebUser loggedInUser = loggedUser.getWebUser();
    activityLogService.addActivity(loggedInUser,
                                   "Requested access for batch type");
    List<DropdownWithObject> batchType = new ArrayList<>();
    batchType = batchTypeService.findAll()
                    .stream()
                    .map(type
                         -> DropdownWithObject.builder()
                                .label(type.getJobType())
                                .value(type.getJobTypeId())
                                .build())
                    .collect(Collectors.toList());
    return ResponseEntity.ok(batchType);
  }

  @Override
  public ResponseEntity<?> getAllJobs(Integer itenantId, int page, int size,
                                      List<Integer> jobtype,
                                      Authentication pr) {
    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();
    WebUser loggedInUser = loggedUser.getWebUser();
    activityLogService.addActivity(loggedInUser,
                                   "Requested access for batch jobs");
    try {
      List<BatchJob> jobs = batchJobService.findAll(itenantId, jobtype);
      Set<Integer> distinctUserIds = jobs.stream()
              .map(BatchJob::getIentryuserid)
              .filter(Objects::nonNull)
              .collect(Collectors.toSet());

      List<WebUser> webUsers = webUserRepository.findAllByIuserIDInAndIorgId_Iorgid(new ArrayList<>(distinctUserIds), loggedInUser.getIorgId().getIorgid());

      Map<Integer, String> userMap = webUsers.stream()
              .collect(Collectors.toMap(WebUser::getIuserID, WebUser::getVcUserName));

      List<BatchJobResponseWithUsername> jobWithUsernames = new ArrayList<>();
      for (BatchJob job : jobs) {
        String username = userMap.get(job.getIentryuserid());
        jobWithUsernames.add(new BatchJobResponseWithUsername(job, username));
      }

      return ResponseEntity.ok(jobWithUsernames);

    } catch (Exception e) {
      log.error("Error : " + e +
                "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
      activityLogService.addActivity(loggedInUser, "failed to get batch jobs",
                                     e.toString());
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, ResponseMessages.GenericErrorMessage),
          HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Transactional
  @Override
  public ResponseEntity<?> createJob(CreateBatchJob createBatchJob,
                                     Authentication pr) {
    LoggedUser loggedUser = (LoggedUser)pr.getPrincipal();
    WebUser loggedInUser = loggedUser.getWebUser();
    activityLogService.addActivity(loggedInUser,
                                   "Requested to create batch job",
                                   createBatchJob.toString());
    if (batchJobService.findPendingJob(createBatchJob.getItenantId()).size() >
        0) {
      activityLogService.addActivity(loggedInUser,
                                     "batch job submission denied",
                                     createBatchJob.toString());
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(
              false,
              "Bulk job submission denied, another job already in progress"),
          HttpStatus.BAD_REQUEST);
    }
    BatchJob job = new BatchJob();
    job.setCreatedTimeStamp(new Date());
    job.setJobParams(createBatchJob.getJobParameters());
    job.setJobStatus("PENDING");
    job.setItenantId(createBatchJob.getItenantId());

    job.setVcRemark(createBatchJob.getVcRemark());
    job.setIentryuserid(loggedInUser.getIuserID());
    job.setIorgid(loggedInUser.getIorgId().getIorgid());

    try {
      job.setJobTypeId(batchTypeService.findById(createBatchJob.getTypeId()));
    } catch (Exception e) {
      log.error("Error : failed to find job type " + e +
                "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
      activityLogService.addActivity(loggedInUser, "failed to find job type ",
                                     e.toString());
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, ResponseMessages.GenericErrorMessage),
          HttpStatus.INTERNAL_SERVER_ERROR);
    }

    BatchJob savedJob;
    System.out.println("T0 " + System.currentTimeMillis());
    try {
      savedJob = batchJobService.createJob(job);
    } catch (Exception e) {
      log.error("Error : failed to create job " + e +
                "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
      activityLogService.addActivity(loggedInUser, "failed to create job ",
                                     e.toString());
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, ResponseMessages.GenericErrorMessage),
          HttpStatus.INTERNAL_SERVER_ERROR);
    }

    Integer jobid = savedJob.getJobId();
    // new Thread(() -> {
    System.out.println(" T1 " + System.currentTimeMillis());
    List<JobData> jobDatas = new ArrayList<>();
    jobDatas = createBatchJob.getDatas()
                   .stream()
                   .map(data -> {
                     JobData jobData = new JobData();
                     jobData.setJobData(data);
                     jobData.setJobid(jobid);
                     return jobData;
                   })
                   .collect(Collectors.toList());

    System.out.println("T2 " + System.currentTimeMillis());
    try {
      jobDataService.saveAll(jobDatas);
    } catch (Exception e) {
      log.error("Error : failed to save job data " + e +
                "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
      activityLogService.addActivity(loggedInUser, "failed to save job data",
                                     e.toString());
    }
    System.out.println("T3 " + System.currentTimeMillis());

    // }).start();

    log.info("Batch job created successfully with job id " +
             savedJob.getJobId());
    activityLogService.addActivity(
        loggedInUser,
        "Batch job created successfully with job id" + savedJob.getJobId());
    return new ResponseEntity<ApiResponse>(
        new ApiResponse(true, "Batch job created successfully with job id " +
                                  savedJob.getJobId()),
        HttpStatus.CREATED);
  }

  @Override
  public ResponseEntity<?> createList(JsonNode createBatchJob) {

    ListAudit listNew = new ListAudit();
    org.json.JSONObject param =
        new org.json.JSONObject(createBatchJob.toString());

    listNew.setVcExternalListItemId(param.optString("externalId"));

    if (param.optString("source").isEmpty() ||
        param.optString("source").isBlank()) {
      if (param.optString("itemValue").isEmpty() ||
          param.optString("itemValue").isBlank()) {
        LOGGER.error("Exiting Add List  Method in " +
                     BatchProcessorServiceImpl.class +
                     " class with response  : failed to add list");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Please enter all "
                                       + "mandatory fields"),
            HttpStatus.BAD_REQUEST);
      }
    }

    if (param.optString("source").isEmpty() ||
        param.optString("source").isBlank()) {
      LOGGER.error("Exiting Add List  Method in " +
                   BatchProcessorServiceImpl.class +
                   " class with response  : failed to add list");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "Source cannot be blank"),
          HttpStatus.BAD_REQUEST);
    }

    if (param.optString("itemValue").isEmpty() ||
        param.optString("itemValue").isBlank()) {
      LOGGER.error("Exiting Add List  Method in " +
                   BatchProcessorServiceImpl.class +
                   " class with response  : failed to add list");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "Value cannot be blank"),
          HttpStatus.BAD_REQUEST);
    }

    if (param.optString("effectiveFrom").isEmpty() ||
        param.optString("effectiveFrom").isBlank()) {

      LOGGER.error("Exiting Add List  Method in " +
                   BatchProcessorServiceImpl.class +
                   " class with response  : failed to add list");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "Start date cannot be blank"),
          HttpStatus.BAD_REQUEST);
    }

    if (param.optString("expiresAt").isEmpty() ||
        param.optString("expiresAt").isBlank()) {
      LOGGER.error("Exiting Add List  Method in " +
                   BatchProcessorServiceImpl.class +
                   " class with response  : failed to add list");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "Expiry date cannot be blank"),
          HttpStatus.BAD_REQUEST);
    }

    Integer type = null;
    try {
      type = param.getInt("listType");
    } catch (Exception e) {

      LOGGER.error("Exiting Add List  Method in " +
                   BatchProcessorServiceImpl.class +
                   " class with response  : failed to add list");
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "Type cannot be blank"),
          HttpStatus.BAD_REQUEST);
    }

    if (type == -1) {
      if (param.optString("name").isEmpty() ||
          param.optString("name").isBlank()) {
        LOGGER.error("Exiting Add List  Method in " +
                     BatchProcessorServiceImpl.class +
                     " class with response  : failed to add list");
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, "Name cannot be blank"),
            HttpStatus.BAD_REQUEST);
      }
    }

    listNew.setVcValue(param.optString("itemValue"));
    listNew.setVcField(param.optString("itemField"));

    listNew.setVcAction("A");
    listNew.setVcRemark("Added Through Bulk");
    listNew.setVcSource("BLK_" + param.optString("source"));
    Integer itenantid = param.optInt("itenantid");
    ObjectMapper obj = new ObjectMapper();
    JsonNode attribs;
    try {
      if (!param.optString("attribs").isBlank()) {
        JSONObject tempattribs = new JSONObject(param.optString("attribs"));
        attribs = obj.readTree(tempattribs.toString());
        listNew.setAttribs(attribs);
      }
    } catch (JsonProcessingException e) {
      throw new RuntimeException(e);
    }

    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T"
                                                        + "'HH:mm:ss.SSS'Z'");
    inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

    try {

      ListMaster templistmaster = null;
      if (type == -1) {
        ListMaster lm = new ListMaster();
        lm.setVcName(param.optString("name"));
        templistmaster = listMasterService.save(lm);
      } else {
        templistmaster = listMasterService.findByID(type, itenantid);
      }

      if (templistmaster.getVcName().equalsIgnoreCase("grey") ||
          templistmaster.getVcName().equalsIgnoreCase("black")) {
        listNew.setVcNote("list_" + itenantid);
      } else if (templistmaster.getVcName().equalsIgnoreCase("white")) {
        listNew.setVcNote("whitelist_" + itenantid);
      } else {
        listNew.setVcNote("masterlist_" + itenantid);
      }
      listNew.setIlistType(templistmaster);
      if (!inputFormat.parse(param.optString("effectiveFrom"))
               .before(inputFormat.parse(param.optString("expiresAt")))) {
        if (!inputFormat.parse(param.optString("effectiveFrom"))
                 .equals(inputFormat.parse(param.optString("expiresAt")))) {

          LOGGER.error("Exiting editList  Method in " +
                       BatchProcessorServiceImpl.class +
                       " class with response  :  date overlap ");
          return new ResponseEntity<ApiResponse>(
              new ApiResponse(false, "Expiry date should be equal to or "
                                         + "greater than Start Date"),
              HttpStatus.BAD_REQUEST);
        }
      }

      if (templistmaster.getIForDays() != null) {
        Date start = inputFormat.parse(param.optString("effectiveFrom"));
        Date end = inputFormat.parse(param.optString("expiresAt"));
        long days = (end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24);
        if (days > templistmaster.getIForDays()) {
          LOGGER.info("Exiting addList  Method in " +
                       BatchProcessorServiceImpl.class +
                       " class with response  : failed to edit "
                       + "list");
          return new ResponseEntity<ApiResponse>(
              new ApiResponse(false, "Expiry date should be"
                                         + " within " +
                                         templistmaster.getIForDays() +
                                         " days from Start Date"),
              HttpStatus.BAD_REQUEST);
        }
      }
    } catch (Exception e) {
      LOGGER.error("Error : date range validation failed");

      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "date range validation failed"),
          HttpStatus.INTERNAL_SERVER_ERROR);
    }

    listNew.setDtEffectiveFrom(
        ZonedDateTime.parse(param.optString("effectiveFrom")));
    listNew.setDtExpiresAt(ZonedDateTime.parse(param.optString("expiresAt")));

    ListValidationUtil listValidationUtil =
        new ListValidationUtil(listReplicaService);
    listValidationUtil.DoValdiations(
        listNew.getVcField(), listNew.getVcValue(),
        listNew.getIlistType().getId().getIListMasterID(),
        listNew.getDtEffectiveFrom(), listNew.getDtExpiresAt(),
        listNew.getIlistType().getId().getItenantId().getItenantid(),
        param.optString("attribs"), false);
    if (listValidationUtil.getSuccess() == false) {

      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, listValidationUtil.getMessage()),
          HttpStatus.BAD_REQUEST);
    }

    listNew.setVcAction("A");

    ListReplica parsed = listNew.parseAudit(listNew);
    parsed.setIstatus(statusCodeService.findByIStatusId(1));

    ListReplica listreplica = listReplicaService.saveAudit(parsed);

    if (listreplica != null) {
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(true, "List Created Successfully"), HttpStatus.OK);
    } else {
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "Failed to create list"),
          HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Override
  public ResponseEntity<?> createCustomer(JsonNode createBatchJob) {
    System.out.println(createBatchJob);

    JSONObject jsonObject = new JSONObject(createBatchJob.toPrettyString());

//    ClientResponse clientResponse = mastersApiService.addSimpleCustomer(
//        jsonObject.toString(), jsonObject.optInt("itenantid"));
//    String res =  clientResponse.bodyToMono(String.class).block();
//    clientResponse.releaseBody();
    ResponseEntity<String> response = mastersApiService.addSimpleCustomer(
            jsonObject.toString(), jsonObject.optInt("itenantid"));
    if (response != null) {
//      if (clientResponse.statusCode() == HttpStatus.OK) {
      if (response.getStatusCode() == HttpStatus.OK) {
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(true, "Simple Customer Created Successfully"),
            HttpStatus.OK);
      } else {
        log.info("Response status code " + response.getStatusCode());
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(response.getBody(),
                            false,"Failed to Create Simple Customer",HttpStatus.valueOf(response.getStatusCode().value())),
            response.getStatusCode());
      }
    } else {
      return null;
    }
  }

  @Override
  public ResponseEntity<?> getErrorLogs(Integer jobid,
                                        HttpServletRequest request) {
    Logger logger = LoggerFactory.getLogger(BatchProcessorServiceImpl.class);

    List<BatchJob> byJobid = batchJobService.findByJobid(jobid);
    if (byJobid != null && !byJobid.isEmpty()) {
      List<JobData> failed;
      JobData jobdata;
      String filePath = "error_logs_.txt";
      // File file = new File(filePath);
      String finalResponse = "";

      try {
        failed = jobDataRepository.findByJobidAndStatus(jobid, "FAILED");
        if (failed.isEmpty()) {
          logger.info("No Errors: {}", jobid);

          // return new ResponseEntity<ApiResponse>(
          //     new ApiResponse(true, "No Errors Found"), HttpStatus.OK);
        }
        for (int i = 0; i < failed.size(); i++) {

          jobdata = failed.get(i);

          JsonNode jobDataNode = jobdata.getJobData();
          JsonNode processResponseNode = jobdata.getProcessResponse();

          logger.info("Writing error logs to file: {}", filePath);
          finalResponse += "Job Data:\n" + jobDataNode.toString() + "\n"
                           + "Process Response:\n" +
                           processResponseNode.toString() + "\n\n";
          // try (FileWriter fileWriter = new FileWriter(file, true)) {
          //   fileWriter.write("Job Data:\n" + jobDataNode.toString() + "\n");
          //   fileWriter.write("Process Response:\n" +
          //                    processResponseNode.toString() + "\n\n");
          //   logger.info("Successfully wrote error logs to file: {}",
          //   filePath);
          // } catch (IOException e) {
          //   logger.error("Error writing to file: {}", e.getMessage());
          //   return new ResponseEntity<>("Error writing to file: " +
          //                                   e.getMessage(),
          //                               HttpStatus.INTERNAL_SERVER_ERROR);
          // }
        }

        // if (!file.exists()) {
        //   logger.error("Error log file not found: {}", filePath);
        //   return new ResponseEntity<>("Error log file not found",
        //                               HttpStatus.INTERNAL_SERVER_ERROR);
        // }

        // HttpHeaders headers = new HttpHeaders();
        // headers.add(HttpHeaders.CONTENT_DISPOSITION,
        //             "attachment; filename=" + file.getName());

        logger.info("Returning file as response: {}", filePath);
        // InputStreamResource resource =
        // new InputStreamResource(new FileInputStream(file));

        // Return the response
        //

        return new ResponseEntity<ApiResponse>(
            new ApiResponse(true, finalResponse), HttpStatus.OK);
        // return ResponseEntity.ok()
        //     .headers(headers)
        //     .body(finalResponse);
        //.contentLength(file.length())
        //.body(resource);
        //.contentType(MediaType.APPLICATION_OCTET_STREAM)
      } catch (Exception e) {
        logger.error("Error processing jobid: {} - {}", jobid, e.getMessage());
        return new ResponseEntity<ApiResponse>(
            new ApiResponse(false, ResponseMessages.GenericErrorMessage),
            HttpStatus.INTERNAL_SERVER_ERROR);
      } finally {
        // if (file.exists()) {
        //   logger.info("File exists, attempting to delete: {}",
        //               file.getAbsolutePath());
        //   File file2 = new File(file.getAbsolutePath());
        //   if (!file2.delete()) {
        //     //                        try (FileWriter testWriter = new
        //     //                        FileWriter(file, true)) {
        //     //                            // If we can open the file for
        //     //                            writing, it is not locked.
        //     //                            logger.info("File is not locked,
        //     can
        //     //                            be deleted.");
        //     //                        } catch (IOException e) {
        //     //                            logger.error("File is locked or
        //     cannot
        //     //                            be accessed: {}", e.getMessage());
        //     //                        }
        //     logger.error("Failed to delete file: {}",
        //     file.getAbsolutePath());
        //   } else {
        //     logger.info("Successfully deleted file: {}",
        //                 file.getAbsolutePath());
        //   }
        // } else {
        //   logger.warn("File does not exist, cannot delete: {}",
        //               file.getAbsolutePath());
        // }
      }
    } else {
      logger.info("Job not found for jobid: {} ", jobid);
      return new ResponseEntity<ApiResponse>(
          new ApiResponse(false, "Job ID Not Found"), HttpStatus.NOT_FOUND);
    }
  }
}
