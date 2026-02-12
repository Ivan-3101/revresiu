package com.DronaPay.UIServer.model;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.databind.JsonNode;

import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="tenantsaudit", schema = "ui")
public class TenantAudit extends MakerModel<TenantAudit, Tenant> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "itenantauditid")
    private Integer tenantAuditId;

    @Column(name = "vctenantid")
    private String vcTenantId;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iorgid")
    private Organization iorgId;

    @Column(name = "attribs", columnDefinition = "jsonb")
    @Type(JsonType.class)
    private JsonNode attribs;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;
    @Override
    public Tenant parseAudit(TenantAudit audit) {
        Tenant tenant = new Tenant();
        tenant.setVcTenantId(audit.getVcTenantId());
        tenant.setIorgId(audit.getIorgId());
        tenant.setIrecordStatus(audit.getIrecordStatus());
        tenant.setAttribs(audit.getAttribs());
        return tenant;
    }
    
}
