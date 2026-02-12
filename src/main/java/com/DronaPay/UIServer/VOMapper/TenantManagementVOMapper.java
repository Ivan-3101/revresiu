package com.DronaPay.UIServer.VOMapper;

import static org.junit.Assert.fail;

import java.util.ArrayList;
import java.util.List;

import com.DronaPay.UIServer.ResponseVO.TenantManagementVO;
import com.DronaPay.UIServer.model.Tenant;
import com.DronaPay.UIServer.model.TenantAudit;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.response.MenuPermissions;

public class TenantManagementVOMapper {

    public static List<TenantManagementVO> parseTenant(List<Tenant> tenantList) {
        List<TenantManagementVO> response = new ArrayList<>();
        for (Tenant ten : tenantList) {
            TenantManagementVO temp = TenantManagementVO.builder()
                    .tenantExternalId(ten.getVcTenantId())
                    .tenantName(ten.getAttribs().at("/tenantName").asText())
                    .orgName(ten.getIorgId() != null ? ten.getIorgId().getVcOrgId(): "")
                    .inboundEmailSettings(ten.getAttribs().at("/inboundEmailSettings"))
                    .outboundEmailSettings(ten.getAttribs().at("/outboundEmailSettings"))
                    .auditEntry(false)
                    .auditExist(false)
                    .makerChecker("M")
                    .build();
            response.add(temp);
        }
        return response;
    }

    public static List<TenantManagementVO> parseTenantAudit(List<TenantAudit> tenantAuditList, MenuPermissions mp,
            WebUser loggedUser) {
        List<TenantManagementVO> response = new ArrayList<>();
        for (TenantAudit ten : tenantAuditList) {
            TenantManagementVO temp = TenantManagementVO.builder()
                    .tenantExternalId(ten.getVcTenantId())
                    .tenantName(ten.getAttribs().at("/tenantName").asText())
                    .orgName(ten.getIorgId() != null ? ten.getIorgId().getVcOrgId() : "")
                    .inboundEmailSettings(ten.getAttribs().at("/inboundEmailSettings"))
                    .outboundEmailSettings(ten.getAttribs().at("/outboundEmailSettings"))
                    .auditEntry(true)
                    .auditExist(false)
                    .makerChecker(ten.getIEntryUserID().equals( loggedUser.getIuserID()) ? "M" : "C")
                    .remarks(ten.getVcRemark())
                    .action(ten.getVcAction())
                    .build();
            response.add(temp);
        }
        return response;
    }
}
