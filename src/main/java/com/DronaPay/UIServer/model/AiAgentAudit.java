package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "aiagentsaudit", schema = "ui")
@Data
public class AiAgentAudit extends MakerModel<AiAgentAudit, AiAgent> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iagentauditid", nullable = false)
    private Integer iagentAuditId;

    @Column(name = "iagentid")
    private Integer iagentId;

    @Column(name = "vcagentname")
    private String vcAgentName;

    @Column(name = "vcagentdescription")
    private String vcAgentDescription;

    @Column(name = "vcinitiation")
    private String vcInitiation;

    @Column(name = "vcpolicy", columnDefinition = "TEXT")
    private String vcPolicy;

    @Column(name = "vcprompt", columnDefinition = "TEXT")
    private String vcPrompt;

    @Type(JsonType.class)
    @Column(name = "vcconfig", columnDefinition = "jsonb")
    private JsonNode vcConfig;

    @Column(name = "iversion")
    private Integer iVersion;

    @Column(name = "vcremark", columnDefinition = "TEXT")
    private String vcRemark;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Override
    public AiAgent parseAudit(AiAgentAudit t) {
        AiAgent agent = new AiAgent();
        if (t.getIagentId() != null) {
            agent.setIagentId(t.getIagentId());
        }
        agent.setVcAgentName(t.getVcAgentName());
        agent.setVcAgentDescription(t.getVcAgentDescription());
        agent.setVcInitiation(t.getVcInitiation());
        agent.setVcPolicy(t.getVcPolicy());
        agent.setVcPrompt(t.getVcPrompt());
        agent.setVcConfig(t.getVcConfig());
        agent.setIVersion(t.getIVersion());
        agent.setIrecordStatus(t.getIrecordStatus());
        agent.setDtApproverStamp(t.getDtApproverStamp());
        agent.setDtEntryStamp(t.getDtEntryStamp());
        agent.setIEntryUserID(t.getIEntryUserID());
        agent.setIorgId(t.getIorgId());
        agent.setIstatus(t.getIstatus().getIStatusIDForMaster());
        agent.setIApproverUserID(t.getIApproverUserID());
        agent.setItenantId(t.getItenantId());
        return agent;
    }

    public AiAgentAudit parseToAudit(AiAgent t) {
        AiAgentAudit agent = new AiAgentAudit();
        agent.setIagentId(t.getIagentId());
        agent.setVcAgentName(t.getVcAgentName());
        agent.setVcAgentDescription(t.getVcAgentDescription());
        agent.setVcInitiation(t.getVcInitiation());
        agent.setVcPolicy(t.getVcPolicy());
        agent.setVcPrompt(t.getVcPrompt());
        agent.setVcConfig(t.getVcConfig());
        agent.setIVersion(t.getIVersion() + 1);
        agent.setItenantId(t.getItenantId());
        return agent;
    }
}
