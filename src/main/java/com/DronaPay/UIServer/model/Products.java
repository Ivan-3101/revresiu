package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;

@Data
@Entity
@Table(name = "products", schema = "masters")
public class Products {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iproductid")
    private Integer iProductID;

    @Column(name = "vcproductname")
    private String vcProductName;

    @Column(name = "vcproductdetail")
    private String vcProductDetail;

    @Column(name = "bactive")
    private boolean bActive;

//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

    @Column(name = "dtentrydatetime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryDateTime;

    //@OneToOne(fetch = FetchType.EAGER)
    @Column(name = "iuserid")
    private Integer iUserID;

    @Column(name = "irecordstatus")
    private Integer iRecordStatus;

}
