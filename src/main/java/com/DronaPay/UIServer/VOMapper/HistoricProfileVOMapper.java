package com.DronaPay.UIServer.VOMapper;

import java.util.ArrayList;
import java.util.List;

import com.DronaPay.UIServer.ResponseVO.HistoricProfileVO;
import com.DronaPay.UIServer.model.MetadataUi;
import com.DronaPay.UIServer.model.MetadataUiAudit;
import com.DronaPay.UIServer.model.Tenant;
import com.DronaPay.UIServer.model.WebUser;

public class HistoricProfileVOMapper {
    public static List<HistoricProfileVO> parseMetadataUi(List<MetadataUi> listMetadata,List<Tenant> tenants) {
        List<HistoricProfileVO> res = new ArrayList<>();
        for(MetadataUi meta: listMetadata) {
            String tenantName=null;
            Tenant tenant= tenants.stream().filter(t->t.getItenantid().equals(meta.getItenantId())).findFirst().orElse(null);
            if(tenant!=null){
                tenantName=tenant.getTenantName();
            }
            HistoricProfileVO temp = HistoricProfileVO.builder().vcpath(meta.getVcpath())
            .vcdtype(meta.getVcdtype())
            .bscore(meta.getBscore())
            .bml(meta.getBml())
            .bui(meta.getBui())
            .vccolumnname(meta.getVccolumnname())
            .vcdescription(meta.getVcdescription())
            .vcroot(meta.getVcroot())
            .vcquery(meta.getVcquery())
            .params(meta.getConfig())
            .auditExist(false)
            .auditEntry(false)
            .makerChecker("M")
            .itenantId(meta.getItenantId())
            .tenantName(tenantName)
            .id(meta.getIMetadataId())
            .vcprefix(meta.getVcPrefix())
            .build();
            res.add(temp);
        }
        return res;
    }

    public static List<HistoricProfileVO> parseMetadataAudit(List<MetadataUiAudit> listAudit, WebUser loggedInUser,List<Tenant> tenants) {
        List<HistoricProfileVO> res = new ArrayList<>();
        for(MetadataUiAudit audit: listAudit) {
            String tenantName=null;
            Tenant tenant= tenants.stream().filter(t->t.getItenantid().equals(audit.getItenantId())).findFirst().orElse(null);
            if(tenant!=null){
                tenantName=tenant.getTenantName();
            }
            HistoricProfileVO temp = HistoricProfileVO.builder().vcpath(audit.getVcpath())
            .vcdtype(audit.getVcdtype())
            .bscore(audit.getBscore())
            .bml(audit.getBml())
            .bui(audit.getBui())
            .vccolumnname(audit.getVccolumnname())
            .vcdescription(audit.getVcdescription())
            .vcroot(audit.getVcroot())
            .vcquery(audit.getVcquery())
            .params(audit.getConfig())
            .vcprefix(audit.getVcPrefix())
            .auditExist(false)
            .auditEntry(true)
            .itenantId(audit.getItenantId())
            .tenantName(tenantName)
            .makerChecker(audit.getIEntryUserID().equals(loggedInUser.getIuserID()) ? "M" : "C")
            .latestRemark(audit.getVcRemark())
            .id(audit.getIMetadataId()!=null?audit.getIMetadataId():null)
            .auditId(audit.getIMetadataAuditId())
            .build();
            res.add(temp);
        }
        return res;
    }
}
