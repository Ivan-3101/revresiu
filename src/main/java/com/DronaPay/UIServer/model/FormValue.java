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
@Table(name = "formvalue", schema = "ui")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FormValue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ivalueid")
    private Integer ivalueID;

    @Type(JsonType.class)
    @Column(name = "valuesjson", columnDefinition = "jsonb")
    private JsonNode valuesJson;

    // @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    // @JoinColumn(name = "iformid")
    // private FormMaster iFormID;
    @Column(name = "iformid")
    private Integer iFormID;

    @Column(name="itenantid")
    private Integer itenantId;

}
