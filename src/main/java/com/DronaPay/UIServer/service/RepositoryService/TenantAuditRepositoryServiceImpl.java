package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;

import com.DronaPay.UIServer.model.TenantAudit;
import com.DronaPay.UIServer.repository.TenantAuditRepository;
import com.DronaPay.UIServer.service.CamundaService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TenantAuditRepositoryServiceImpl extends TenantAuditRepositoryService {

    @Autowired
    private CamundaService camundaService;

    @Autowired
    private TenantAuditRepository tenantAuditRepository;

    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Override
    public TenantAudit saveAudit(TenantAudit input) {

        if (input.getIstatus() != null) {
            String vcTenantName = input.getAttribs().at("/tenantName").asText();
            if (input.getIstatus().getIStatusID() == 2) {
                ResponseEntity<String> resp = camundaService.createTenant(input.getVcTenantId(), vcTenantName);
                if (resp.getStatusCode() == HttpStatus.NO_CONTENT) {
                    log.info("Tenant with id " + loggerEncoderUtil.encode(input.getVcTenantId()) + " successfully created in camunda");
                } else {
//                    log.error("Tenant creation request for entry " + loggerEncoderUtil.encode(input.toString()) + " failed with status code "
//                            + resp.statusCode() + resp.bodyToMono(String.class));
                    log.error("Tenant creation request for entry " + loggerEncoderUtil.encode(input.toString()) + " failed with status code "
                            + resp.getStatusCode() + resp.getBody());
                    return null;
                }
//                resp.releaseBody();

            } else if (input.getIstatus().getIStatusID() == 3) {
                ResponseEntity<String> resp = camundaService.editTenant(input.getVcTenantId(), vcTenantName);
                if (resp.getStatusCode() == HttpStatus.NO_CONTENT) {
                    log.info("Tenant with id " + loggerEncoderUtil.encode(input.getVcTenantId()) + " successfully edited in camunda");
                } else {
//                    log.error("Tenant edition request for entry " + loggerEncoderUtil.encode(input.toString()) + " failed with status code "
//                            + resp.statusCode() + resp.bodyToMono(String.class));
                    log.error("Tenant edition request for entry " + loggerEncoderUtil.encode(input.toString()) + " failed with status code "
                            + resp.getStatusCode() + resp.getBody());
                    return null;
                }
//                resp.releaseBody();
            } else if (input.getIstatus().getIStatusID() == 4) {
                ResponseEntity<String> resp = camundaService.deleteTenant(input.getVcTenantId());
                if (resp.getStatusCode() == HttpStatus.NO_CONTENT) {
                    log.info("Tenant with id " + loggerEncoderUtil.encode(input.getVcTenantId()) + " successfully deleted in camunda");
                } else {
//                    log.error("Tenant deletion request for entry " + loggerEncoderUtil.encode(input.toString()) + " failed with status code "
//                            + resp.statusCode() + resp.bodyToMono(String.class));
                    log.error("Tenant deletion request for entry " + loggerEncoderUtil.encode(input.toString()) + " failed with status code "
                            + resp.getStatusCode() + resp.getBody());
                    return null;
                }
//                resp.releaseBody();
            } else if (input.getIstatus().getIStatusID() == 5) {
                log.info("Entry was rejected, not invoking camunda API");
            }
        }
        return tenantAuditRepository.save(input);
    }

    @Override
    public List<TenantAudit> findPendingEntries() throws Exception {
        return tenantAuditRepository.findAllByIstatusIsNullAndBclosedFalse();
    }

    @Override
    public TenantAudit findByTenantId(String tenantid) throws Exception {
        return tenantAuditRepository.findByIstatusIsNullAndBclosedFalseAndVcTenantId(tenantid);
    }

}
