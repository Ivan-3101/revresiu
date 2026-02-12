package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigInteger;
import java.time.ZonedDateTime;

@Entity
@Table(name = "livetrans", schema = "transactions")
@Data
public class LiveTrans {

    @Id
    @Column(name = "ilivemessageid")
    private BigInteger iLiveMessageID;

    @Column(name = "vcmsgid")
    private String vcMsgID;

//    @Column(name = "dttrxntime")
//    private Date dtTrxnTime;

    @Column(name = "dttrxntime", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtTrxnTime;


    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "ipayervpaid")
    private Vpa iPayerVpaID;

    //    @Column(name="ipayervpaproviderid")
//    private Integer iPayerVpaProviderID;
//
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "ipayeevpaid")
    private Vpa iPayeeVpaID;
//
//    @Column(name="ipayeevpaproviderid")
//    private Integer iPayeeVpaProviderID;
//
//    @Column(name="dsettledamount")
//    private BigDecimal dSettledamount;
//
//    @Column(name="dtransamount")
//    private BigDecimal dTransAmount;
//
//    @Column(name="dfailedamount")
//    private BigDecimal dFailedAmount;
//
//    @Column(name="bnewpayer")
//    private Boolean bNewPayer;
//
//    @Column(name="bnewpayeeforpayer")
//    private Boolean bNewPayeeForPayer;
//
//    @Column(name="bfrmpassed")
//    private Boolean bFRMPassed;
//
//    @Column(name="btransfailed")
//    private Boolean bTransFailed;
//
//    @Column(name="ilivemessageid")
//    private Date dtUpdatedTime;
//
//    @Column(name="observations")
//    private String observations;
//
//    @Column(name="ifailedruleid")
//    private Integer iFailedRuleID;
//
//    @Column(name="score")
//    private Integer score;

}
