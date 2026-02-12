package com.DronaPay.UIServer.auditing;

import com.DronaPay.UIServer.Constants.Enum.WebuserMappingType;
import com.DronaPay.UIServer.controller.EmailServiceController.EmailController;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.requests.CamundaRequests.CamundaRequestVO.CamundaCredentials;
import com.DronaPay.UIServer.requests.CamundaRequests.CamundaRequestVO.CamundaProfile;
import com.DronaPay.UIServer.requests.CamundaRequests.NewCamundaUser;
import com.DronaPay.UIServer.requests.EmailRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.AllUsersMapping;
import com.DronaPay.UIServer.util.PasswordGenerator;
import com.DronaPay.UIServer.util.WebuserMappingUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.time.ZonedDateTime;
import java.util.*;
import java.util.stream.StreamSupport;

@Service
@Slf4j
public class Checker {

//    @Value("${drona.ui.url}")
//    private String drona_ui_url;

    @Autowired
    private WebUserService webUserService;

    @Autowired
    private WebUserAuditService webUserAuditService;

    @Autowired
    private CamundaService camundaService;

    @Autowired
    private Environment env;

    @Autowired
    private GroupDescService groupDescService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private WebuserMappingService webuserMappingService;

    @Autowired
    private WebuserMappingUtil webuserMappingUtil;

    @Autowired
    private PasswordGenerator passwordGenerator;

    @Autowired
    private EmailController emailController;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private WebuserMappingAuditService webuserMappingAuditService;


    public <E> void checker(E obj) throws Exception {

        if (obj instanceof WebUserAudit) {

            WebUserAudit wua = (WebUserAudit) obj;
            if (((WebUserAudit) wua).isBclosed() && ((WebUserAudit) wua).getIstatus().isBUpdateMaster()) {
                if (wua.getVcAction().equalsIgnoreCase("A")) {
                    WebUser wu = WebUser.parse(wua);
                    // Generate random
                    String temporary = passwordGenerator.generateSecurePassword();

                    ZonedDateTime now = ZonedDateTime.now();
                    if (wu.getDtLastPasswordEmailSentAt() != null
                            && wu.getDtLastPasswordEmailSentAt().plusMinutes(15).isAfter(now)) {
                        log.error("Password email request limit exceeded for user: " + wu.getUsername());
                        throw new RuntimeException("Password email request limit exceeded for user: " + wu.getUsername());
                        }

                    // Update user details
                    wu.setDtLastPasswordEmailSentAt(now);
                    wu.setVcPassword(passwordEncoder.encode(temporary));

                    wu = webUserService.save(wu, wua.getIUserAuditID());
                    String drona_ui_url = wua.getIorgId().geturl();

                    // Send email
                    EmailRequest emailRequest = new EmailRequest();
                    emailRequest.setTemplateid(32);
                    emailRequest.setToEmail(Arrays.asList(wua.getVcEmailID()));
                    Map<String, Object> subjectParams = new HashMap<>();
                    subjectParams.put("temporaryPassword", temporary);
                    subjectParams.put("loginurl", drona_ui_url + "/dronaui/" +
                            wu.getIorgId().getVcOrgId() + "/auth/login");
                    emailRequest.setBodyParams(subjectParams);
                    emailRequest.setSensitiveVariables(Collections.singletonList("temporaryPassword"));
                    ObjectMapper mapper = new ObjectMapper();
                    String emailReqString = mapper.writeValueAsString(emailRequest);
                    AllUsersMapping allMappingInfo = webuserMappingUtil.getWebUserMappings(
                            Arrays.asList(wu.getIuserID()), wu.getIorgId().getIorgid());
                    ResponseEntity<?> emailResponse = emailController.sendEmail(emailReqString, allMappingInfo.getUserTenant().get(wu.getIuserID()).get(0));
                    if (!emailResponse.getStatusCode().equals(HttpStatus.OK)) {
                        log.error("Error while sending email, Body : " + emailResponse.getBody());
                    }

                    wua.setIUserID(wu.getIuserID());

                    NewCamundaUser ncu = new NewCamundaUser();
                    CamundaProfile user = new CamundaProfile();
                    user.setEmail(wu.getVcEmailID());
                    user.setFirstName(wu.getVcFirstName());
                    user.setId(wu.getIuserID().toString());
                    user.setLastName(wu.getVcLastName());

                    CamundaCredentials cred = new CamundaCredentials();
                    cred.setPassword(env.getProperty("camunda.webusers.password"));
                    ncu.setProfile(user);
                    ncu.setCredentials(cred);
                    WebUser approveUser = webUserService.findByUserOrgId(wu.getIApproverUserID(), wu.getIorgId().getIorgid());
                    ResponseEntity<String> useradded = camundaService.addNewUser(ncu, approveUser);

                    if (useradded.getStatusCode() != HttpStatus.NO_CONTENT) {
//                        log.error("failed to create user api status code : " + useradded.statusCode()
//                                + " response body :" + useradded.bodyToMono(String.class));
                        log.error("failed to create user api status code : " + useradded.getStatusCode()
                                + " response body :" + useradded.getBody());
                        throw new RuntimeException();
                    }
//                    useradded.releaseBody();

//                    List<GroupDesc> group_desc_list = groupDescService
//                            .findAllById(webuserMappingAuditService
//                                    .findByIDsWebuserIDandOrgID(
//                                            String.valueOf(WebuserMappingType.Group),
//                                            wua.getIUserAuditID(),
//                                            wua.getIorgId().getIorgid()
//                                    ));

                    List<GroupDesc> group_desc_list = groupDescService.findByWebuserMappingAudit(
                            webuserMappingAuditService.findByAuditIDAndOrgId(
                            String.valueOf(WebuserMappingType.Group),
                            wua.getIUserAuditID(),
                            wua.getIorgId().getIorgid()
                    ));

                    // System.out.println("Approve by using this user " + wu.getIApproverUserID().getVcUserName());
                    group_desc_list.stream().distinct().forEach(a -> {
                        try {
                            ResponseEntity<String> temp = camundaService.mapToGroup(wua, approveUser,
                                    a.getVcGroupID());
                            if (temp.getStatusCode() != HttpStatus.NO_CONTENT)
//                                log.error("failed to map  user to group api status code : " + temp.statusCode()
//                                        + " response body :" + temp.bodyToMono(String.class));
                            log.error("failed to map  user to group api status code : " + temp.getStatusCode()
                                    + " response body :" + temp.getBody());
//                            temp.releaseBody();
                        } catch (Exception e) {
                            throw new RuntimeException(e);
                        }
                    });

                    List<Tenant> tenant_list = tenantRepositoryService.findByTenantIds(
                            webuserMappingAuditService
                                    .findByIDsWebuserIDandOrgID(
                                            String.valueOf(WebuserMappingType.Tenant),
                                            wua.getIUserAuditID(),
                                            wua.getIorgId().getIorgid()
                                    ).getMappingIds()
                    );
                    tenant_list.forEach(a -> {
                        try {
                            ResponseEntity<String> temp = camundaService.mapToTenant(wua, approveUser,
                                    String.valueOf(a.getItenantid()));
                            if (temp.getStatusCode() != HttpStatus.NO_CONTENT)
//                                log.error("failed to map  user to tenant api status code : " + temp.statusCode()
//                                        + " response body :" + temp.bodyToMono(String.class));
                                log.error("failed to map  user to tenant api status code : " + temp.getStatusCode()
                                        + " response body :" + temp.getBody());
//                            temp.releaseBody();
                        } catch (Exception e) {
                            throw new RuntimeException(e);
                        }
                    });
                } else if (wua.getVcAction().equalsIgnoreCase("M")) {
                    WebUser wu = WebUser.parse(wua);
                    WebUser origUser = webUserService.findByUserOrgId(wua.getIUserID(), wua.getIorgId().getIorgid());
                    wu.setDtLastPasswordUpdated(origUser.getDtLastPasswordUpdated());
                    wu.setDtLastPasswordEmailSentAt(origUser.getDtLastPasswordEmailSentAt());
                    wu.setVcPassword(origUser.getVcPassword());
                    wu.setIuserID(wua.getIUserID());
                    CamundaProfile user = new CamundaProfile();
                    user.setEmail(wu.getVcEmailID());
                    user.setFirstName(wu.getVcFirstName());
                    // user.setId(wu.getUsername().replaceAll("[^a-zA-Z0-9]", ""));
                    user.setId(wu.getIuserID().toString());
                    user.setLastName(wu.getVcLastName());
                    ResponseEntity<String> updateduser = camundaService.updateUser(user, wu);

                    if (updateduser.getStatusCode() != HttpStatus.NO_CONTENT) {
//                        log.error("failed to update user api status code : " + updateduser.statusCode()
//                                + " response body :" + updateduser.bodyToMono(String.class));
                        log.error("failed to update user api status code : " + updateduser.getStatusCode()
                                + " response body :" + updateduser.getBody());
                        throw new RuntimeException();
                    }
                    WebUser approveUser = webUserService.findByUserOrgId(wu.getIApproverUserID(), wu.getIorgId().getIorgid());
//                    WebUser origUser = webUserService.findByUserOrgId(wua.getIUserID(), wua.getIorgId().getIorgid());

//                    updateduser.releaseBody();
//                    List<GroupDesc> originalGroups = groupDescService.findAllById(
//                            webuserMappingService
//                                    .findByIDsWebuserIDandOrgID(
//                                            String.valueOf(WebuserMappingType.Group),
//                                            origUser.getIuserID(),
//                                            origUser.getIorgId().getIorgid()
//                                    ));
//                    List<GroupDesc> updatedGroups = groupDescService.findAllById(
//
//                            webuserMappingAuditService
//                                    .findByIDsWebuserIDandOrgID(
//                                            String.valueOf(WebuserMappingType.Group),
//                                            wua.getIUserAuditID(),
//                                            wua.getIorgId().getIorgid()
//                                    ));

                    List<GroupDesc> originalGroups = groupDescService.findByWebuserMapping(
                            webuserMappingService.findByIDAndOrgId(
                                            String.valueOf(WebuserMappingType.Group),
                                            origUser.getIuserID(),
                                            origUser.getIorgId().getIorgid()
                                    )
                    );

                    List<GroupDesc> updatedGroups = groupDescService.findByWebuserMappingAudit(
                            webuserMappingAuditService.findByAuditIDAndOrgId(
                                    String.valueOf(WebuserMappingType.Group),
                                    wua.getIUserAuditID(),
                                    wua.getIorgId().getIorgid()
                            )
                    );

                    updatedGroups.stream().distinct()
                            .filter(updatedGroup -> originalGroups.stream().distinct()
                                    .noneMatch(
                                            originalGroup -> originalGroup.getVcGroupID().equals(updatedGroup.getVcGroupID())))
                            .forEach(a -> {
                                try {
                                    ResponseEntity<String> temp = camundaService.mapToGroup(wua, approveUser,
                                            a.getVcGroupID());
                                    if (temp.getStatusCode() != HttpStatus.NO_CONTENT)
//                                        log.error("failed to map  user to group api status code : " + temp.statusCode()
//                                                + " response body :" + temp.bodyToMono(String.class));
                                        log.error("failed to map  user to group api status code : " + temp.getStatusCode()
                                                + " response body :" + temp.getBody());
//                                    temp.releaseBody();
                                } catch (Exception e) {
                                    throw new RuntimeException(e);
                                }
                            });

                    originalGroups.stream().distinct()
                            .filter(originalGroup -> updatedGroups.stream().distinct()
                                    .noneMatch(
                                            updatedGroup -> originalGroup.getVcGroupID().equals(updatedGroup.getVcGroupID())))
                            .forEach(a -> {
                                try {
                                    ResponseEntity<String> temp = camundaService.deleteUserGroup(wua, approveUser,
                                            a.getVcGroupID());
                                    if (temp.getStatusCode() != HttpStatus.NO_CONTENT)
//                                        log.error(
//                                                "failed to delete user to group api status code : " + temp.statusCode()
//                                                        + " response body :" + temp.bodyToMono(String.class));
                                        log.error("failed to delete user to group api status code : " + temp.getStatusCode()
                                                        + " response body :" + temp.getBody());
//                                    temp.releaseBody();
                                } catch (Exception e) {
                                    throw new RuntimeException(e);
                                }
                            });

                    List<Tenant> originalTenants = tenantRepositoryService.findByTenantIds(
                            webuserMappingService
                                    .findByIDsWebuserIDandOrgID(
                                            String.valueOf(WebuserMappingType.Tenant),
                                            origUser.getIuserID(),
                                            origUser.getIorgId().getIorgid()
                                    ).getMappingIds());


                    List<Tenant> updatedTenants = tenantRepositoryService.findByTenantIds(
                            webuserMappingAuditService
                                    .findByIDsWebuserIDandOrgID(
                                            String.valueOf(WebuserMappingType.Tenant),
                                            wua.getIUserAuditID(),
                                            wua.getIorgId().getIorgid()
                                    ).getMappingIds());

                    updatedTenants.stream()
                            .filter(updatedTenant -> originalTenants.stream()
                                    .noneMatch(
                                            originalTenant -> originalTenant.getItenantid().equals( updatedTenant.getItenantid())))
                            .forEach(a -> {
                                try {
                                    ResponseEntity<String> temp = camundaService.mapToTenant(wua, approveUser,
                                            String.valueOf(a.getItenantid()));
                                    if (temp.getStatusCode() != HttpStatus.NO_CONTENT)
//                                        log.error("failed to map  user to tenant api status code : " + temp.statusCode()
//                                                + " response body :" + temp.bodyToMono(String.class));
                                        log.error("failed to map  user to tenant api status code : " + temp.getStatusCode()
                                                + " response body :" + temp.getBody());
//                                    temp.releaseBody();
                                } catch (Exception e) {
                                    throw new RuntimeException(e);
                                }
                            });

                    originalTenants.stream()
                            .filter(originalTenant -> updatedTenants.stream()
                                    .noneMatch(
                                            updatedTenant -> originalTenant.getItenantid().equals(updatedTenant.getItenantid())))
                            .forEach(a -> {
                                try {
                                    ResponseEntity<String> temp = camundaService.deleteUserTenant(wua, approveUser,
                                            String.valueOf(a.getItenantid()));
                                    if (temp.getStatusCode() != HttpStatus.NO_CONTENT)
//                                        log.error(
//                                                "failed to delete user to tenant api status code : " + temp.statusCode()
//                                                        + " response body :" + temp.bodyToMono(String.class));
                                        log.error("failed to delete user to tenant api status code : " + temp.getStatusCode()
                                                        + " response body :" + temp.getBody());
//                                    temp.releaseBody();
                                } catch (Exception e) {
                                    throw new RuntimeException(e);
                                }
                            });


                    webUserService.save(wu, wua.getIUserAuditID());
                } else if (wua.getVcAction().equalsIgnoreCase("X")) {
                    WebUser wu = WebUser.parse(wua);
                    WebUser approveUser = webUserService.findByUserOrgId(wu.getIApproverUserID(), wu.getIorgId().getIorgid());
                    WebUser origUser = webUserService.findByUserOrgId(wua.getIUserID(), wua.getIorgId().getIorgid());
                    wu.setDtLastPasswordUpdated(origUser.getDtLastPasswordUpdated());
                    wu.setDtLastPasswordEmailSentAt(origUser.getDtLastPasswordEmailSentAt());
                    wu.setVcPassword(origUser.getVcPassword());
                    wu.setIuserID(wua.getIUserID());
                    ResponseEntity<String> deteleuser = camundaService.deleteUser(wua, approveUser);
                    if (deteleuser.getStatusCode() != HttpStatus.NO_CONTENT) {
//                        log.error("failed to delete user api status code : " + deteleuser.statusCode()
//                                + " response body :" + deteleuser.bodyToMono(String.class));
                        log.error("failed to delete user api status code : " + deteleuser.getStatusCode()
                                + " response body :" + deteleuser.getBody());
                        throw new RuntimeException();
                    }
//                    deteleuser.releaseBody();
                    webUserService.save(wu, wua.getIUserAuditID());
                }
            }
            webUserAuditService.save(wua);
        }
    }

}
