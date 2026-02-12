package com.DronaPay.UIServer.model;


import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;


@Entity
@Table(name = "formmaster", schema = "ui")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FormMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ifromid")
    private Integer iformID;

    @Column(name = "vcformname", unique = true)
    private String vcFormName;


    @Column(name = "vcdisplayname", unique = true)
    private String vcDisplayName;

    @Type(JsonType.class)
    @Column(name = "inputjson", columnDefinition = "jsonb")
    private JsonNode inputJson;

    @Type(JsonType.class)
    @Column(name = "actioaftercreation", columnDefinition = "jsonb")
    private JsonNode actionAfterCreation;

    @Type(JsonType.class)
    @Column(name = "formattingjson", columnDefinition = "jsonb")
    private JsonNode formattingJson;

    @Column(name="itenantid")
    private Integer itenantId;

}
