package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.PasswordHistory;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.repository.PasswordHistoryRepository;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.util.LoginPasswordUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;
import java.util.List;

@Service
public class PasswordHistoryServiceImpl implements PasswordHistoryService {

    private static final Logger LOGGER = LoggerFactory.getLogger(PasswordHistoryServiceImpl.class);

    @Autowired
    private PasswordHistoryRepository passwordHistoryRepository;

    @Autowired
    private OrganizationRepositoryService organizationRepositoryService;

    @Autowired
    private LoginPasswordUtil loginPasswordUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ActivityLogService activityLogService;

    @Autowired
    private ObjectMapper objectMapper;

    @Value("${password.history.limit}")
    private Integer historyLimit;

    @Override
    public List<PasswordHistory> getPasswordHistoryByUserIdAndIorgId(Integer iuserId, Integer iorgId) {
        return passwordHistoryRepository.findBybDeleteAndIorgIdAndIuserIdOrderByDtEntryStampAsc(false, iorgId, iuserId);
    }

    public boolean isPasswordReused(Integer iuserId, String word,  List<PasswordHistory> passwordHistories) throws Exception {

        for (PasswordHistory history : passwordHistories) {
            if (passwordEncoder.matches(word, history.getVcPassword())) {
                return true;
            }
        }
        return false;
    }

    public void enforcePasswordHistoryLimit(Integer iuserId, Integer iorgId,  List<PasswordHistory> passwordHistories, Integer historyLimit) {

        if (passwordHistories.size() > historyLimit) {
            List<PasswordHistory> recordsToUpdate = passwordHistories.subList(0 ,passwordHistories.size() - historyLimit);
            recordsToUpdate.forEach(record -> record.setBDelete(true));
            passwordHistoryRepository.saveAll(recordsToUpdate);
        }
    }

//    public Integer getPasswordHistoryLimit(Integer iorgId) {
//        try {
//            Optional<Organization> optionalOrg = organizationRepositoryService.findByIorgId(iorgId);
//
//            if (optionalOrg.isEmpty() || optionalOrg.get().getAttribs() == null) {
//                return -1;
//            }
//
//            JsonNode attribsJson = optionalOrg.get().getAttribs();
//            JsonNode limitNode = attribsJson.path("passwordHistoryLimit");
//
//            if (limitNode.isInt()) {
//                return limitNode.asInt();
//            }
//            return -1;
//        } catch (Exception e) {
//            LOGGER.error("Error fetching password history limit for org {}", iorgId, e);
//            throw new RuntimeException(e);
//        }
//    }

    @Override
    public ApiResponse handlePasswordHistory(WebUser webUser, Boolean isNewUser, String word) throws Exception {
//        Integer historyLimit = getPasswordHistoryLimit(webUser.getIorgId().getIorgid());

//        // If password history is not enforced, exit early
//        if (historyLimit == -1) {
//            return new ApiResponse(true, "Password history enforcement is not enabled.", HttpStatus.OK);
//        }

        if (historyLimit == null || historyLimit <= 0) {
            LOGGER.error("Invalid or missing 'password.history.limit' in application.properties. Please configure it properly.");
            return new ApiResponse(false, "Password history limit configuration error", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        List<PasswordHistory> passwordHistoryList = List.of();
        if (!isNewUser){
            try {
                passwordHistoryList = getPasswordHistoryByUserIdAndIorgId(webUser.getIuserID(), webUser.getIorgId().getIorgid());
            }catch (Exception e){
                LOGGER.error("Error : " + e );
                activityLogService.addActivity(webUser, "Failed to get history list", e.toString());
                return new ApiResponse(false, ResponseMessages.GenericErrorMessage,
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
            if(isPasswordReused(webUser.getIuserID(), word, passwordHistoryList)) {
                String errorMessage = "The new password has already been used in the last " + historyLimit + " passwords. Please choose a different password.";
                LOGGER.info(errorMessage);
                return new ApiResponse(false, errorMessage, HttpStatus.BAD_REQUEST);
            }
        }

        PasswordHistory newHistory = new PasswordHistory();
        newHistory.setIuserId(webUser.getIuserID());
        newHistory.setIorgId(webUser.getIorgId().getIorgid());
        newHistory.setVcPassword(webUser.getVcPassword());
        newHistory.setDtEntryStamp(ZonedDateTime.now());
        newHistory.setBDelete(false);

        passwordHistoryRepository.save(newHistory);

        if (!isNewUser){
            passwordHistoryList.add(newHistory);
            enforcePasswordHistoryLimit(webUser.getIuserID(), webUser.getIorgId().getIorgid(), passwordHistoryList, historyLimit);
        }

        return new ApiResponse(true, "Password history updated successfully.");

    }

}
