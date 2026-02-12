package com.DronaPay.UIServer.service.ControllerService.TenantManagement;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.ResponseVO.TenantManagementVO;
import com.DronaPay.UIServer.VOMapper.DropdownWithObjectMapper;
import com.DronaPay.UIServer.VOMapper.TenantManagementVOMapper;
import com.DronaPay.UIServer.model.Organization;
import com.DronaPay.UIServer.model.Tenant;
import com.DronaPay.UIServer.model.TenantAudit;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.AddTenantRequest;
import com.DronaPay.UIServer.requests.ApproveTenantRequest;
import com.DronaPay.UIServer.requests.DeleteTenantRequest;
import com.DronaPay.UIServer.requests.EditTenantRequest;
import com.DronaPay.UIServer.requests.TenantRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.response.TenantManagementResponse;
import com.DronaPay.UIServer.service.HelperServices.CheckerMakerHelperService;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.github.fge.jsonpatch.JsonPatch;
import com.github.fge.jsonpatch.JsonPatchException;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
public class TenantManagementServiceImpl implements TenantManagementService {

        final String menu_name = MenuNames.tenantMangement;
        @Autowired
        private WebUserService webUserService;
        @Autowired
        private ActivityLogService activityLogService;
        @Autowired
        private LoggerEncoderUtil loggerEncoderUtil;
        @Autowired
        private TenantRepositoryService tenantRepositoryService;
        @Autowired
        private TenantAuditRepositoryService tenantAuditRepositoryService;
        @Autowired
        private OrganizationRepositoryService organizationRepositoryService;
        @Autowired
        private CheckerMakerHelperService<TenantAuditRepositoryService, TenantAudit, TenantRepositoryService, Tenant> checkerMakerHelperService;

        @Override
        public ResponseEntity<?> getAllTenants(Authentication pr) {
                log.debug("entered in class " + TenantManagementServiceImpl.class + " in method getAllTenants");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (!mp.isView()) {
                        activityLogService.addActivity(loggedInUser, "unauthorized to view tenant");
                        log.debug("Exiting addTenant Method in " + TenantManagementServiceImpl.class
                                        + " class with response  : unauthorized to view tenant item");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to view tenant"),
                                        HttpStatus.FORBIDDEN);
                }

                List<Tenant> tenant = null;
                List<TenantAudit> tenantAudits = null;
                try {
                        tenant = tenantRepositoryService.findNonDeletedTenants();
                        tenantAudits = tenantAuditRepositoryService.findPendingEntries();
                } catch (Exception e) {
                        log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                        e.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
                List<TenantManagementVO> tenantManagementVOs = TenantManagementVOMapper.parseTenant(tenant);

                List<TenantManagementVO> tenantManagementVOAudits = TenantManagementVOMapper.parseTenantAudit(
                                tenantAudits,
                                mp, loggedInUser);

                for (int i = 0; i < tenantManagementVOs.size(); i++) {

                        for (int j = 0; j < tenantManagementVOAudits.size(); j++) {
                                if (tenantManagementVOs.get(i).getTenantExternalId()
                                                .equals(tenantManagementVOAudits.get(j).getTenantExternalId())) {
                                        tenantManagementVOs.get(i).setAuditExist(true);
                                }
                        }
                }
                tenantManagementVOs.addAll(tenantManagementVOAudits);

                TenantManagementResponse response = new TenantManagementResponse();
                response.setAdd(mp.isAdd());
                response.setApprove(mp.isApprove());
                response.setView(mp.isView());
                response.setDelete(mp.isDelete());
                response.setEdit(mp.isEdit());
                response.setTenantManagementVO(tenantManagementVOs);

                return ResponseEntity.ok(response);
        }

        @Override
        public ResponseEntity<?> patchTenant(TenantRequest request, String vctenantid) {
                log.debug("entered in class " + TenantManagementServiceImpl.class + " in method patchTenant");

              
                Tenant targetTenant = tenantRepositoryService.findByTenantId(vctenantid);
                if (request.getConfig() != null) {
                        try {
                                JsonPatch configPatch = JsonPatch.fromJson(request.getConfig());
                                JsonNode config;
                                if (targetTenant.getConfig() == null) {
                                        ObjectMapper mapper = new ObjectMapper();
                                        config = configPatch.apply(mapper.createObjectNode());
                                } else {
                                        config = configPatch.apply(targetTenant.getConfig());
                                }
                                targetTenant.setConfig(config);
                                
                        } catch (IOException e) {
                                log.error("Config patch is invaid.", e);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, "Invalid config json path request"),
                                                HttpStatus.BAD_REQUEST);
                        } catch (JsonPatchException jpe) {
                                log.error("Error in applying Config patch", jpe);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, "Error in applying config json"),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                }
                
                if (request.getAttribs() != null) {
                        try {
                                JsonPatch attribPatch = JsonPatch.fromJson(request.getAttribs());
                                JsonNode attrib;
                                if (targetTenant.getAttribs() == null) {
                                        ObjectMapper mapper = new ObjectMapper();
                                        attrib = attribPatch.apply(mapper.createObjectNode());
                                } else {
                                        attrib = attribPatch.apply(targetTenant.getAttribs());
                                }
                                targetTenant.setAttribs(attrib);
                                
                        } catch (IOException e) {
                                log.error("Attrib patch is invaid.", e);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, "Invalid attrib json path request"),
                                                HttpStatus.BAD_REQUEST);
                        } catch (JsonPatchException jpe) {
                                log.error("Error in applying Attrib patch", jpe);
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, "Error in applying attrib json"),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                }
                
                tenantRepositoryService.update(targetTenant, targetTenant.getItenantid());
                
                log.debug("Exiting patchTenant Method in " + TenantManagementServiceImpl.class
                                + " class with response  : Tenant patched");
                return ResponseEntity.ok("Updated");
        }

        @Override
        public ResponseEntity<?> addTenant(AddTenantRequest request, Authentication pr) {
                log.debug("entered in class " + TenantManagementServiceImpl.class + " in method addTenant");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (!mp.isAdd()) {
                        activityLogService.addActivity(loggedInUser, "unauthorized to add tenant");
                        log.debug("Exiting addTenant Method in " + TenantManagementServiceImpl.class
                                        + " class with response  : unauthorized to add tenant item");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to add tenant"),
                                        HttpStatus.FORBIDDEN);
                }

                Organization org = null;
                try {
                        org = organizationRepositoryService.findOrg(request.getOrgId());
                } catch (Exception e) {
                        activityLogService.addActivity(loggedInUser,
                                        "Failed to get organization ", e.toString());
                        log.error("Exiting addTenant Method in "
                                        + TenantManagementServiceImpl.class
                                        + " class with response  : failed to get organization " + e);
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Failed to add tenant"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
                TenantAudit newTen = new TenantAudit();
                newTen.setVcTenantId(UUID.randomUUID().toString());
                ObjectMapper mapper = new ObjectMapper();
                ObjectNode attribs = mapper.createObjectNode();
                attribs.put("tenantName", request.getTenantName());
                attribs.set("inboundEmailSettings", request.getInboundEmailSettings());
                attribs.set("outboundEmailSettings", request.getOutboundEmailSettings());
                newTen.setIorgId(org);
                newTen.setAttribs(attribs);
                newTen.setVcRemark(request.getMakerRemark());
                newTen.setIrecordStatus(0);
                newTen.setVcAction("A");
                newTen = checkerMakerHelperService.saveWithObj(tenantAuditRepositoryService, newTen, loggedInUser);
                if (newTen != null) {

                        activityLogService.addActivity(loggedInUser,
                                        "Tenant added successfully");
                        log.debug("Exiting addObservation Method in "
                                        + TenantManagementServiceImpl.class
                                        + " class with response  : Tenant addition sent for approval");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true, "Tenant addition sent for approval"),
                                        HttpStatus.ACCEPTED);
                } else {
                        activityLogService.addActivity(loggedInUser,
                                        "Failed to add Tenant ");
                        log.debug("Exiting addTenant Method in "
                                        + TenantManagementServiceImpl.class
                                        + " class with response  : failed to add tenant");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Failed to add tenant"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

        }

        @Override
        public ResponseEntity<?> editTenant(EditTenantRequest request, Authentication pr) {
                log.debug("entered in class " + TenantManagementServiceImpl.class + " in method editTenant");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (!mp.isEdit()) {
                        activityLogService.addActivity(loggedInUser, "unauthorized to edit tenant");
                        log.debug("Exiting editTenant Method in " + TenantManagementServiceImpl.class
                                        + " class with response  : unauthorized to edit tenant item");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to edit tenant"),
                                        HttpStatus.FORBIDDEN);
                }

                TenantAudit audit = null;
                if (request.getAudit()) {
                        try {
                                audit = tenantAuditRepositoryService.findByTenantId(request.getTenantExternalId());
                        } catch (Exception e) {
                                log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                                e.toString());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                } else {
                        audit = new TenantAudit();
                        try {
                                Tenant tenant = null;
                                tenant = tenantRepositoryService.findByTenantId(request.getTenantExternalId());
                                audit.setVcTenantId(tenant.getTenantName());
                                audit.setIorgId(tenant.getIorgId());
                                audit.setIrecordStatus(0);
                        } catch (Exception e) {
                                log.error("Error getting existing tenant entry for edit operation " + e + "\nParam : "
                                                + loggerEncoderUtil.encode(pr.toString()));
                                activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                                e.toString());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                                HttpStatus.INTERNAL_SERVER_ERROR);
                        }
                }
                ObjectMapper mapper = new ObjectMapper();
                ObjectNode attribs = mapper.createObjectNode();
                attribs.put("tenantName", request.getTenantName());
                attribs.set("inboundEmailSettings", request.getInboundEmailSettings());
                attribs.set("outboundEmailSettings", request.getOutboundEmailSettings());
                audit.setAttribs(attribs);
                audit.setVcAction("M");
                audit.setBclosed(false);
                audit.setVcRemark(request.getMakerRemark());
                audit = checkerMakerHelperService.saveWithObj(tenantAuditRepositoryService, audit, loggedInUser);
                if (audit != null) {
                        activityLogService.addActivity(loggedInUser,
                                        "Tenant edited successfully");
                        log.debug("Exiting addObservation Method in "
                                        + TenantManagementServiceImpl.class
                                        + " class with response  : Tenant edition sent for approval");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true, "Tenant edition sent for approval"),
                                        HttpStatus.OK);
                } else {
                        activityLogService.addActivity(loggedInUser,
                                        "Failed to edit Tenant ");
                        log.debug("Exiting editTenant Method in "
                                        + TenantManagementServiceImpl.class
                                        + " class with response  : failed to add tenant");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Failed to edit tenant"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

        }

        @Override
        public ResponseEntity<?> deleteTenant(DeleteTenantRequest request, Authentication pr) {
                log.debug("entered in class " + TenantManagementServiceImpl.class + " in method deleteTenant");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (!mp.isDelete()) {
                        activityLogService.addActivity(loggedInUser, "unauthorized to delete tenant");
                        log.debug("Exiting editTenant Method in " + TenantManagementServiceImpl.class
                                        + " class with response  : unauthorized to delete tenant item");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to delete tenant"),
                                        HttpStatus.FORBIDDEN);
                }

                Tenant tenant = null;
                try {
                        TenantAudit pending = null;
                        pending = tenantAuditRepositoryService.findByTenantId(request.getTenantExternalId());
                        if (pending != null) {
                                activityLogService.addActivity(loggedInUser, "failed to delete tenant",
                                                request.getTenantExternalId());
                                return new ResponseEntity<ApiResponse>(
                                                new ApiResponse(false, "Tenant is already pending for approval"),
                                                HttpStatus.BAD_REQUEST);
                        }
                        tenant = tenantRepositoryService.findByTenantId(request.getTenantExternalId());
                } catch (Exception e) {
                        log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                        e.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

                TenantAudit audit = new TenantAudit();
                audit.setVcTenantId(tenant.getTenantName());
                audit.setAttribs(tenant.getAttribs());
                audit.setIorgId(tenant.getIorgId());
                audit.setIrecordStatus(1);
                audit.setVcAction("X");
                audit.setVcRemark(request.getMakerRemark());
                audit = checkerMakerHelperService.saveWithObj(tenantAuditRepositoryService, audit, loggedInUser);
                if (audit != null) {
                        activityLogService.addActivity(loggedInUser,
                                        "Tenant deleted successfully");
                        log.debug("Exiting deleteTenant Method in "
                                        + TenantManagementServiceImpl.class
                                        + " class with response  : Tenant deletion sent for approval");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true, "Tenant deletion sent for approval"),
                                        HttpStatus.ACCEPTED);
                } else {
                        activityLogService.addActivity(loggedInUser,
                                        "Failed to delete Tenant ");
                        log.debug("Exiting deleteTenant Method in "
                                        + TenantManagementServiceImpl.class
                                        + " class with response  : failed to delete tenant");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Failed to delete tenant"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
        }

        @Override
        @Transactional(rollbackFor = Throwable.class)
        public ResponseEntity<?> approveTenant(ApproveTenantRequest request, Authentication pr) {
                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (!mp.isApprove()) {
                        activityLogService.addActivity(loggedInUser, "unauthorized to approve tenant");
                        log.debug("Exiting editTenant Method in " + TenantManagementServiceImpl.class
                                        + " class with response  : unauthorized to approve tenant item");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to approve tenant"),
                                        HttpStatus.FORBIDDEN);
                }

                TenantAudit audit = null;
                try {
                        audit = tenantAuditRepositoryService.findByTenantId(request.getTenantExternalId());
                } catch (Exception e) {
                        log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions",
                                        e.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
                if (audit == null) {
                        activityLogService.addActivity(loggedInUser, "failed to approve/reject tenant",
                                        request.getTenantExternalId());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Tenant audit entry does not exist"),
                                        HttpStatus.BAD_REQUEST);
                }

                if (audit.getIEntryUserID() == loggedInUser.getIuserID()) {
                        log.debug(
                                        "Exiting approveTenant Method in " +
                                                        TenantManagementServiceImpl.class +
                                                        " class with response  : with parameter approve tenant");
                        activityLogService.addActivity(
                                        loggedInUser, "Failed to approve tenant",
                                        "Parameters : " + request.toString());
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Maker cannot be checker"),
                                        HttpStatus.BAD_REQUEST);
                }

                Tenant tenant = audit.parseAudit(audit);
                audit.setVcRemark("{" + audit.getVcRemark() + "}"
                                + "{" + request.getCheckerRemark() + "}");
                Boolean status = false;
                String action = "";
                if (audit.getVcAction().equals("A")) {
                        action = "addition";
                } else if (audit.getVcAction().equals("M")) {
                        action = "edition";
                } else {
                        action = "deletion";
                }
                String approve = "";
                try {
                        if (request.getApprove()) {
                                approve = "approved";
                                status = checkerMakerHelperService.save(tenantAuditRepositoryService, audit,
                                                tenantRepositoryService, tenant, loggedInUser, true, false);
                        } else {
                                approve = "rejected";
                                status = checkerMakerHelperService.save(tenantAuditRepositoryService, audit,
                                                tenantRepositoryService, tenant, loggedInUser, false, true);
                        }
                } catch (Exception e) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        log.error("Error : approving/rejecting entry\nParam : "
                                        + loggerEncoderUtil.encode(e.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

                if (status) {
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(true, "Tenant " + action + " " + approve + " successfully"),
                                        HttpStatus.OK);
                } else {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        log.error("Error : approving/rejecting entry\nParam : "
                                        + loggerEncoderUtil.encode(request.toString()));
                        activityLogService.addActivity(loggedInUser, "failed to get user and permissions");
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }
        }

        @Override
        public ResponseEntity<?> getAllOrgs(Authentication pr) {
                log.debug("entered in class " + TenantManagementServiceImpl.class + " in method getAllOrgs");

                LoggedUser loggedUser = (LoggedUser) pr.getPrincipal();

                WebUser loggedInUser = loggedUser.getWebUser();
                MenuPermissions mp = loggedUser.getPermissions().get(menu_name);

                if (!mp.isView()) {
                        activityLogService.addActivity(loggedInUser, "unauthorized to view organizations");
                        log.debug("Exiting addTenant Method in " + TenantManagementServiceImpl.class
                                        + " class with response  : unauthorized to view organizations");
                        return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to view tenant"),
                                        HttpStatus.FORBIDDEN);
                }

                List<Organization> orgs = null;

                try {
                        orgs = organizationRepositoryService.findAllOrgs();
                } catch (Exception e) {
                        activityLogService.addActivity(loggedInUser,
                                        "Failed to get organization ", e.toString());
                        log.error("Exiting getAllOrgs Method in "
                                        + TenantManagementServiceImpl.class
                                        + " class with response  : failed to get organization " + e);
                        return new ResponseEntity<ApiResponse>(
                                        new ApiResponse(false, "Failed to get organizations"),
                                        HttpStatus.INTERNAL_SERVER_ERROR);
                }

                List<DropdownWithObject> res = DropdownWithObjectMapper.parseFromOrganizations(orgs);
                return ResponseEntity.ok(res);
        }

}
