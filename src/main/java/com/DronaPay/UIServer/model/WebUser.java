package com.DronaPay.UIServer.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.ZonedDateTime;
import java.util.Collection;

@Entity
@Table(name = "webuser", schema = "ui")
@Getter
@Setter
public class WebUser implements UserDetails {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iuserid")
    private Integer iuserID;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "iorgid")
    private Organization iorgId;

    @Column(name = "vcusername", nullable = false, length = 64)
    private String vcUserName;
    @Column(name = "vcpassword")
    private String vcPassword;
    @Column(name = "vcemailid", nullable = false, length = 64)
    private String vcEmailID;
    @Column(name = "vccontact", length = 20)
    private String vcContact;
    @Column(name = "vcmobile", length = 20)
    private String vcMobile;
    @Column(name = "vcprofileimg", length = 255)
    private String vcProfileImg;

    // @OneToOne(fetch = FetchType.EAGER, mappedBy = "role1UserID", cascade =
    // CascadeType.MERGE)
    // private AllocationUsers allocationUser1ID;

    // @OneToMany(fetch = FetchType.EAGER, mappedBy = "role2UserID", cascade =
    // CascadeType.MERGE)
    // private List<AllocationUsers> allocationUser2ID;
    @Column(name = "timezones", length = 20)
    private String timeZone;
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "istatus")
    private StatusCode iStatus;


    @Column(name = "ientryuserid")
    private Integer iEntryUserID;

//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtentrystamp")
//    private Date dtEntryStamp;

    @Column(name = "dtentrystamp", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtEntryStamp;

    // @ManyToOne(fetch = FetchType.LAZY)
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
    @Column(name = "resetpasswordtoken", length = 60)
    private String resetPasswordToken;
//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtlastlogindate")
//    private Date dtLastLoginDate;

    @Column(name = "dtlastlogindate", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtLastLoginDate;

    @Column(name = "loginattempts")
    private Integer loginAttempts;
//    @Temporal(TemporalType.TIMESTAMP)
//    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
//    @Column(name = "dtlastpasswordupdate")
//    private Date dtLastPasswordUpdated;


    @Column(name = "dtlastpasswordupdate", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtLastPasswordUpdated;

    @Column(name = "dtlastpasswordemailsentat ", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private ZonedDateTime dtLastPasswordEmailSentAt;

    // @OneToMany(cascade = CascadeType.MERGE, fetch = FetchType.EAGER, mappedBy =
    // "iUserID")
    // private List<UserRoleMap> userPermissionsTemp;

    //    @ManyToMany(fetch = FetchType.EAGER)
//    @JoinTable(name = "userrolemap", schema = "ui", joinColumns = @JoinColumn(referencedColumnName = "iuserid", name = "iuserid"), inverseJoinColumns = @JoinColumn(referencedColumnName = "iroleid", name = "iroleid"))
//    private List<RoleDesc> userPermissions;
//
//    @ManyToMany(fetch = FetchType.EAGER)
//    @JoinTable(name = "usergroupmap", schema = "ui", joinColumns = @JoinColumn(referencedColumnName = "iuserid", name = "iuserid"), inverseJoinColumns = @JoinColumn(referencedColumnName = "igroupid", name = "igroupid"))
//    private List<GroupDesc> userGroup;
    // @OneToMany(mappedBy = "webuserID", cascade = CascadeType.ALL, orphanRemoval = true)
//    private List<WebuserMapping> webuserMappingList = new ArrayList<>();


    public static WebUser parse(WebUserAudit wua) {
        WebUser wu = new WebUser();
        wu.setIuserID(wua.getTempiUserID());
        wu.setVcUserName(wua.getVcUserName());
//        wu.setVcPassword(wua.getVcPassword());
        wu.setVcEmailID(wua.getVcEmailID());
        wu.setVcContact(wua.getVcContact());
        wu.setVcMobile(wua.getVcMobile());
        wu.setVcProfileImg(wua.getVcProfileImg());
        if (wua.getIstatus() != null) {
            wu.setIStatus(wua.getIstatus().getIStatusIDForMaster());
        }
        wu.setIEntryUserID(wua.getIEntryUserID());
        wu.setDtEntryStamp(wua.getDtEntryStamp());
        wu.setIApproverUserID(wua.getIApproverUserID());
        wu.setIorgId(wua.getIorgId());
        wu.setDtApproverStamp(wua.getDtApproverStamp());
        wu.setVcFirstName(wua.getVcFirstName());
        wu.setVcLastName(wua.getVcLastName());
        wu.setVcAddress(wua.getVcAddress());
        wu.setVcDesignation(wua.getVcDesignation());
        wu.setLoginAttempts(0);
        // List<WebuserMapping> webuser_mapping_list = wua.getWebuserMappingAuditList()
        //         .stream()
        //         .map(a ->
        //                 {
        //                     WebuserMapping res = new WebuserMapping();
        //                     res.setMappingID(a.getMappingID());
        //                     res.setMappingType(a.getMappingType());
        //                     res.setWebuserID(wu);
        //                     return res;
        //                 }
        //         ).collect(Collectors.toList());
        // wu.setWebuserMappingList(webuser_mapping_list);

        return wu;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String getPassword() {
        // TODO Auto-generated method stub
        return this.vcPassword;
    }

    @Override
    public String getUsername() {
        // TODO Auto-generated method stub
        return this.vcUserName;
    }

    @Override
    public boolean isAccountNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }

    @Override
    public boolean isEnabled() {
        if (iStatus.getIStatusID() == 1) {
            return true;
        } else {
            return false;
        }

    }

    @Override
    public boolean equals(Object user2) {
        return this.iuserID.equals(((WebUser) user2).getIuserID());
    }


    @Override
    public String toString() {
        return "WebUser{" +
                "iuserID=" + iuserID +
                ", vcUserName='" + vcUserName + '\'' +
//                ", vcPassword='" + vcPassword + '\'' +
                ", vcEmailID='" + vcEmailID + '\'' +
                ", vcContact='" + vcContact + '\'' +
                ", vcMobile='" + vcMobile + '\'' +
                ", vcProfileImg='" + vcProfileImg + '\'' +
                ", iStatus=" + iStatus +
                ", dtEntryStamp=" + dtEntryStamp +
                ", dtApproverStamp=" + dtApproverStamp +
                ", vcFirstName='" + vcFirstName + '\'' +
                ", vcLastName='" + vcLastName + '\'' +
                ", vcAddress='" + vcAddress + '\'' +
                ", vcDesignation='" + vcDesignation + '\'' +
                ", dtLastLoginDate=" + dtLastLoginDate +

                '}';
    }

//    public List<Integer> getUserPermissions() {
//
//        return getWebuserMappingList().stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.Role)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

//    public List<Integer> getUserGroup() {
//        return getWebuserMappingList()
//                .stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.Group)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

//    public List<Integer> getUserTenant() {
//        return getWebuserMappingList()
//                .stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.Tenant)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

//    public List<Integer> getUserWorkflow() {
//        return getWebuserMappingList()
//                .stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.Workflow)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

//    public List<Integer> getUserClass() {
//        return getWebuserMappingList()
//                .stream()
//                .filter(a -> a.getMappingType()
//                        .equals(String.valueOf(WebuserMappingType.TransactionClass)))
//                .map(a -> a.getMappingID())
//                .collect(Collectors.toList());
//    }

    // public void setWebuserMappingList(List<WebuserMapping> webuserMappingList) {
    //     this.webuserMappingList.clear();
    //     this.webuserMappingList.addAll(webuserMappingList.stream().map(a ->
    //     {
    //         a.setWebuserID(this.getIuserID());
    //         return a;
    //     }).collect(Collectors.toList()));
    // }
}
