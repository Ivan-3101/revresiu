package com.DronaPay.UIServer.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.math.BigInteger;

@Entity
@Table(name = "vpa", schema = "masters")
@Data
public class Vpa {
    @Id
    @Column(name = "ivpaid")
    private BigInteger iVpaID;

//    @Column(name="iaccountid")
//    private BigInteger iAccountID;

    @Column(name = "vcexternaladdressid")
    private String vcExternalAddressID;

    @Column(name = "vcaddress")
    private String vcAddress;
//
//    @Column(name = "iproductid")
//    private Integer iProductID;
//
//    @Column(name = "vcvpaname")
//    private String vcVpaName;
//
//    @Column(name = "bverified")
//    private String bVerified;
//
//    @Column(name = "imcc")
//    private Integer imcc;
//
//    @Column(name = "dtonboardingdate")
//    private Date dtOnboardingDate;
//
//    @Column(name = "dtexpirydate")
//    private Date dtExpiryDate;
//
//    @Column(name = "bmerchant")
//    private Boolean bMerchant;
//
//    @Column(name = "ivpaproviderid")
//    private Integer iVpaProviderID;
//
//    @Column(name = "bProfiled" )
//    private Boolean bProfiled;
//
//    @Column(name = "dtFirstTransaction")
//    private Date dtFirstTransaction;
//
//    @Column(name = "dtLastTransaction")
//    private Date dtLastTransaction;
//
//    @Lob
//    @Type(type = "jsonb")
//    @Column(name = "vcattribs", columnDefinition = "jsonb")
//    private String vcAttribs;
//
//    @Column(name = "irecordstatus")
//    private Integer iRecordStatus;
//
//    @Column(name = "dtentrydatetime")
//    private Date dtEntryDateTime;

}
