package com.DronaPay.UIServer.model;

import com.fasterxml.jackson.databind.JsonNode;
import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.time.ZonedDateTime;
import java.util.stream.StreamSupport;

@Entity
@Table(name = "orgs", schema = "ui")
@Data
public class Organization {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iorgid")
    private Integer iorgid;

    @Column(name = "vcorgid")
    private String vcOrgId;

    @Column(name = "irecordstatus")
    private Integer irecordStatus;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrystamp")
//    protected Date dtEntryStamp;


    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryStamp;

    @Type(JsonType.class)
    @Column(name = "attribs", columnDefinition = "jsonb")
    private JsonNode attribs;

    public String geturl() {
        JsonNode front_end_urls = attribs.get("drona.ui.url");

        if (front_end_urls != null) {
            if (front_end_urls.isArray()) {
                return  StreamSupport.stream(front_end_urls.spliterator(), false)
                        .filter(JsonNode::isTextual)
                        .map(JsonNode::asText)
                        .findFirst()
                        .orElse(null);
            } else if (front_end_urls.isTextual()) {
                return front_end_urls.asText();
            }
        }
        return null;
    }

}
