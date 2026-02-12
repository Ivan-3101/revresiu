package com.DronaPay.UIServer.model;

import com.DronaPay.UIServer.CompositeKey.AiAgentsKey;
import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "aiagents", schema = "ui")
@IdClass(AiAgentsKey.class)
@Data
public class AiAgent extends CheckerModel {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "agent_seq")
    @SequenceGenerator(name = "agent_seq", sequenceName = "ui.aiagents_iagentid_seq", allocationSize = 1)
    @Column(name = "iagentid", insertable = false, updatable = false)
    private Integer iagentId;

    @Column(name = "vcagentname")
    private String vcAgentName;

    @Column(name = "vcagentdescription", columnDefinition = "TEXT")
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

    @Column(name = "laststatus")
    private String lastStatus;

    @Column(name = "vcremark", columnDefinition = "TEXT")
    private String vcRemark;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

    @Column(name = "iversion")
    private Integer iVersion;

    @Id
    @Column(name = "itenantid")
    private Integer itenantId;
}
