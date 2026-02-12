package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "validationfieldslist", schema = "ui")
@Data
public class ValidationFieldsList {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ifieldid")
    private Integer iFieldID;

    @Column(name = "vcfielddisplayname")
    private String vcFieldDisplayName;

    @Column(name = "vcdatatype")
    private String vcDataType;

    @Column(name= "itenantid")
    private Integer itenantId;

//    @Column(name = "vctranstablenfieldname")
//    private String vcTransTableNFieldName;

//    @Column(name = "vcupifieldname")
//    private String vcUPIFieldName;

    @Column(name = "vcvalidation")
    private String vcValidation;

    @Column(name = "vcinternalfield")
    private String vcInternalField;

    @Column(name = "vcscoreapipath")
    private String vcScoreApiPath;

    @Column(name = "bfirst")
    private Boolean bFirst;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

//    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
//    @JoinColumn(name = "iuserid")
//    private WebUser iUserID;

//    @Column(name = "irecordstatus")
//    private Integer iRecordStatus;
}
