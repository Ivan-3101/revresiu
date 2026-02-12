package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.ZonedDateTime;

//@Data
@Table(name = "webuseraudit", schema = "ui")
@Entity
//@Builder
@Getter
@Setter
public class WebUserAudit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iuserauditid")
    private int iUserAuditID;

    @Column(name = "iuserid")
    private Integer iUserID;

    @Column(name = "tempiUserID")
    private int tempiUserID;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "iorgid")
    private Organization iorgId;

    @Column(name = "vcusername", nullable = false, length = 100)
    private String vcUserName;

//    @Column(name = "vcpassword", nullable = false)
//    private String vcPassword;

    @Column(name = "vcemailid", nullable = false, length = 64)
    private String vcEmailID;

    @Column(name = "vccontact", length = 20)
    private String vcContact;

    @Column(name = "vcmobile", length = 20)
    private String vcMobile;

    @Column(name = "vcprofileimg", length = 225)
    private String vcProfileImg;

    @Column(name = "bclosed", nullable = false)
    private boolean bclosed;

    @Column(name = "vcaction", nullable = false, length = 1)
    private String vcAction;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "istatus")
    private StatusCode istatus;


    @Column(name = "ientryuserid")
    private Integer iEntryUserID;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @CreationTimestamp
//    @Column(name = "dtentrystamp")
//    private Date dtEntryStamp;


    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    @CreationTimestamp
    private ZonedDateTime dtEntryStamp;

    @Column(name = "iapproveruserid")
    private Integer iApproverUserID;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtapproverstamp")
//    private Date dtApproverStamp;

    @Column(name = "dtapproverstamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtApproverStamp;

    @Column(name = "vcfirstname", nullable = false, length = 20)
    private String vcFirstName;

    @Column(name = "vclastname", nullable = false, length = 20)
    private String vcLastName;

    @Column(name = "vcaddress", length = 60)
    private String vcAddress;

    @Column(name = "vcdesignation", length = 35)
    private String vcDesignation;

    @Column(name = "vcremark", length = 255)
    private String vcRemark;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtlastlogindate")
//    private Date dtLastLoginDate;

    @Column(name = "dtlastlogindate", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtLastLoginDate;

    // @OneToMany(mappedBy = "webUserAuditID", cascade = CascadeType.ALL, orphanRemoval = true)
//    private List<WebuserMappingAudit> webuserMappingAuditList = new ArrayList<>();


    @Column(name = "loginattempts")
    private Integer loginAttempts;

//	@OneToMany(cascade = CascadeType.MERGE, fetch = FetchType.EAGER, mappedBy = "iUserID")
//	private List<UserRoleMapAudit> userPermissionsTemp;

//    @ManyToMany(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
//    @JoinTable(name = "Userrolemapaudit", schema = "ui", joinColumns = @JoinColumn(referencedColumnName = "iuserauditid"), inverseJoinColumns = @JoinColumn(referencedColumnName = "iroleid"))
//    private List<RoleDesc> userPermissions;
//
//    @ManyToMany(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
//    @JoinTable(name = "usergroupmapaudit", schema = "ui", joinColumns = @JoinColumn(referencedColumnName = "iuserauditid", name = "iuserauditid"), inverseJoinColumns = @JoinColumn(referencedColumnName = "igroupid", name = "igroupid"))
//    private List<GroupDesc> userGroup;

    public static WebUserAudit parseForAudit(WebUser wu) {

//		WebUserAudit wua = WebUserAudit.builder()
//				.iUserID(wu)
//				.vcUserName(wu.getVcUserName())
//				.vcPassword(wu.getVcPassword())
//				.vcEmailID(wu.getVcEmailID())
//				.vcContact(wu.getVcContact())
//				.vcMobile(wu.getVcMobile())
//				.vcProfileImg(wu.getVcProfileImg())
//				.vcFirstName(wu.getVcFirstName())
//				.vcLastName(wu.getVcLastName())
//				.vcAddress(wu.getVcAddress())
//				.vcDesignation(wu.getVcDesignation())
//				.userPermissions(wu.getUserPermissions() != null ? wu.getUserPermissions() : null)
//				.userGroup(wu.getUserGroup() != null ? wu.getUserGroup() : null)
//				.build();
//		return wua;
        WebUserAudit wua = new WebUserAudit();
        wua.setIUserID(wu.getIuserID());
        wua.setVcUserName(wu.getVcUserName());
//        wua.setVcPassword(wu.getPassword());
        wua.setVcEmailID(wu.getVcEmailID());
        wua.setVcContact(wu.getVcContact());
        wua.setVcMobile(wu.getVcMobile());
        wua.setVcProfileImg(wu.getVcProfileImg());
        wua.setVcFirstName(wu.getVcFirstName());
        wua.setVcLastName(wu.getVcLastName());
        wua.setVcAddress(wu.getVcAddress());
        wua.setVcDesignation(wu.getVcDesignation());
        wua.setIorgId(wu.getIorgId());

        // List<WebuserMappingAudit> usermapping = wu
        //         .getWebuserMappingList()
        //         .stream()
        //         .map(a -> {
        //                     WebuserMappingAudit res = new WebuserMappingAudit();
        //                     res.setMappingID(a.getMappingID());
        //                     res.setMappingType(a.getMappingType());
        //                     res.setWebUserAuditID(wua);
        //                     return res;
        //                 }
        //         )
        //         .collect(Collectors.toList());
        // wua.setWebuserMappingAuditList(usermapping);
        return wua;

    }

    @Override
    public boolean equals(Object user2) {
        return this.iUserAuditID == (((WebUserAudit) user2).getIUserAuditID());
    }

    @Override
    public String toString() {
        return "WebUserAudit{" +
                "iUserAuditID=" + iUserAuditID +
                ", tempiUserID=" + tempiUserID +
                ", vcUserName='" + vcUserName + '\'' +
//                ", vcPassword='" + vcPassword + '\'' +
                ", vcEmailID='" + vcEmailID + '\'' +
                ", vcContact='" + vcContact + '\'' +
                ", vcMobile='" + vcMobile + '\'' +
                ", vcProfileImg='" + vcProfileImg + '\'' +
                ", bClosed=" + bclosed +
                ", vcAction='" + vcAction + '\'' +
                ", iStatus=" + istatus +
                ", dtEntryStamp=" + dtEntryStamp +
                ", dtApproverStamp=" + dtApproverStamp +
                ", vcFirstName='" + vcFirstName + '\'' +
                ", vcLastName='" + vcLastName + '\'' +
                ", vcAddress='" + vcAddress + '\'' +
                ", vcDesignation='" + vcDesignation + '\'' +
                ", vcRemark='" + vcRemark + '\'' +
                ", dtLastLoginDate=" + dtLastLoginDate +
                '}';
    }

//    public List<Integer> getUserPermissions() {
//        return webuserMappingAuditList
//                .stream()
//                .filter(a -> a.getMappingType().equals(String.valueOf(WebuserMappingType.Role)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

//    public List<Integer> getUserGroup() {
//        return webuserMappingAuditList
//                .stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.Group)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

//    public List<Integer> getUserTenant() {
//        return webuserMappingAuditList
//                .stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.Tenant)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

//    public List<Integer> getUserWorkflow() {
//        return webuserMappingAuditList
//                .stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.Workflow)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

//    public List<Integer> getUserClass() {
//        return webuserMappingAuditList
//                .stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.TransactionClass)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

    // public void setWebuserMappingAuditList(List<WebuserMappingAudit> webuserMappingAuditList) {
    //     this.webuserMappingAuditList.clear();
    //     this.webuserMappingAuditList.addAll(webuserMappingAuditList.stream().map(a -> {
    //         a.setWebUserAuditID(this);
    //         return a;
    //     }).collect(Collectors.toList()));
    // }
}
