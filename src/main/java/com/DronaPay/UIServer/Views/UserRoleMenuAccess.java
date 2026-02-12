package com.DronaPay.UIServer.Views;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.ToString;
import org.hibernate.annotations.Immutable;

@Entity
@Table(name = "userrolemenuaccess", schema = "ui")
@Getter
@ToString
@Immutable
public class UserRoleMenuAccess {

    @Id
    @Column(name = "userrolemenuviewid")
    private Integer userRoleMenuViewID;

    @Column(name = "iuserid")
    private Integer iUserID;

    @Column(name = "iroleid")
    private Integer iRoleID;

    @Column(name = "imenuid")
    private Integer iMenuID;

    @Column(name = "iparentmenu")
    private Integer iParentMenu;

    @Column(name = "vcicon")
    private String vcIcon;

    @Column(name = "vcmenuname")
    private String vcMenuName;

    @Column(name = "vcmini")
    private String vcMini;

    @Column(name = "vcpath")
    private String vcPath;

    @Column(name = "vcrtlmini")
    private String vcRtlMini;

    @Column(name = "vcrtlname")
    private String vcRtlName;

    @Column(name = "vcstate")
    private String vcState;

    @Column(name = "bcollapse")
    private Boolean bCollapse;

    @Column(name = "vclayout")
    private String vcLayout;

    @Column(name = "badd")
    private Boolean bAdd;

    @Column(name = "bedit")
    private Boolean bedit;

    @Column(name = "bapprove")
    private Boolean bApprove;

    @Column(name = "bdelete")
    private Boolean bDelete;

    @Column(name = "bpublish")
    private Boolean bPublish;

    @Column(name = "bview")
    private Boolean bView;

    @Column(name = "isortorder")
    private Integer iSortOrder;

    @Column(name = "iorgid")
    private Integer iorgId;

    @Column(name = "itenantid")
    private Integer itenantId;
}


	






