package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.ZonedDateTime;

@Entity
@Table(name = "passwordhistory", schema = "ui")
@Data
public class PasswordHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ipasswordid")
    private Integer ipasswordId;

    @Column(name = "iuserid")
    private Integer iuserId;

    @Column(name = "iorgid")
    private Integer iorgId;

    @Column(name = "vcpassword", length = 255)
    private String vcPassword;

    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryStamp;

    @Column(name = "bdelete")
    private Boolean bDelete;
}
