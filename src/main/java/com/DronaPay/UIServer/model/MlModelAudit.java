package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "mlmodelsaudit", schema = "ui")
@Data
public class MlModelAudit extends MakerModel<MlModelAudit, MlModel> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "imodelauditid", nullable = false)
    private Integer imodelAuditId;

    @Column(name = "imodelid")
    private Integer imodelId;

    @Column(name = "vcmlflowmodelname")
    private String vcMlFlowModelName;

    @Column(name = "vcmlflowmodeldescription", columnDefinition = "TEXT")
    private String vcMlFlowModelDescription;

    @Column(name = "imlversion")
    private Double iMlVersion;

    @Type(JsonType.class)
    @Column(name = "vcmodeldetail", columnDefinition = "jsonb")
    private JsonNode vcModelDetail;

    @Column(name = "vctype")
    private String vcType;

    @Column(name = "vcremark", columnDefinition = "TEXT")
    private String vcRemark;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

    @Column(name = "vcaction")
    private String vcAction;

    @Column(name = "itenantid")
    private Integer itenantId;

    @Override
    public MlModel parseAudit(MlModelAudit t) {
        MlModel model = new MlModel();
        if (t.getImodelId() != null) {
            model.setImodelId(t.getImodelId());
        }
        model.setVcMlFlowModelName(t.getVcMlFlowModelName());
        model.setVcMlFlowModelDescription(t.getVcMlFlowModelDescription());
        model.setIMlVersion(t.getIMlVersion());
        model.setVcType(t.getVcType());
        model.setVcRemark(t.getVcRemark());
        model.setIrecordStatus(t.getIrecordStatus());
        model.setDtEntryStamp(t.getDtEntryStamp());
        model.setIEntryUserID(t.getIEntryUserID());
        model.setIApproverUserID(t.getIApproverUserID());
        model.setIorgId(t.getIorgId());
        model.setIstatus(t.getIstatus().getIStatusIDForMaster());
        model.setItenantId(t.getItenantId());
        return model;
    }

    public MlModelAudit parseToAudit(MlModel t) {
        MlModelAudit model = new MlModelAudit();
        model.setImodelId(t.getImodelId());
        model.setVcMlFlowModelName(t.getVcMlFlowModelName());
        model.setVcMlFlowModelDescription(t.getVcMlFlowModelDescription());
        model.setIMlVersion(t.getIMlVersion());
        model.setVcModelDetail(t.getVcModelDetail());
        model.setVcType(t.getVcType());
        model.setItenantId(t.getItenantId());
        return model;
    }

}