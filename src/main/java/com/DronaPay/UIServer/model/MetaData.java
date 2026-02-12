package com.DronaPay.UIServer.model;


import com.DronaPay.UIServer.CompositeKey.MetaDataKey;
import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "metadata", schema = "profiles")
@Data
// @IdClass(MetaDataKey.class)
public class MetaData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    // @Id
    @Column(name = "vcpath")
    private String vcpath;

    @Column(name = "vcdtype")
    private String vcdtype;


    @Column(name = "bscore")
    private Boolean bscore;


    @Column(name = "bml")
    private Boolean bml;


    @Column(name = "bui")
    private Boolean bui;


    @Column(name = "vccolumnname")
    private String vccolumnname;


    @Column(name = "vcdescription")
    private String vcdescription;


    // @Id
    @Column(name = "vcroot")
    private String vcroot;


    @Column(name = "irecordstatus")
    private Integer irecordStatus;

    @Column(name = "vcquery")
    private String vcquery;

    @Type(JsonType.class)
    @Column(name = "vcprefix", columnDefinition = "jsonb", length = 250)
    private JsonNode vcPrefix;

    @Type(JsonType.class)
    @Column(name = "config", columnDefinition = "jsonb", length = 250)
    private JsonNode config;

    @Column(name="itenantid")
    private Integer itenantId;
//    @Column(name = "vcpythonfunction")
//    private String vcpythonfunction;


//    @Column(name = "bpayer")
//    private Boolean bpayer;

//    @Column(name = "bpayee")
//    private Boolean bpayee;


    @Embeddable
    public class AccountLinkKey {
        @Column(name = "seg_account")
        private String segAccount;

        @Column(name = "sec_account")
        private String secAccount;
    }
}
