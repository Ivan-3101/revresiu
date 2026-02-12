package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.ResponseVO.AppUser;
import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.model.GroupDesc;
import com.DronaPay.UIServer.model.RoleDesc;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WebUserAudit;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.RepositoryService.GroupDescService;
import com.DronaPay.UIServer.service.RepositoryService.RoleDescService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class AppUserMapper {

    @Autowired
    RoleDescService roleDescService;

    @Autowired
    GroupDescService groupDescService;


    public AppUser parse(WebUser wu, MenuPermissions mp, WebUser user) {
        AppUser au = AppUser.builder().id(wu.getIuserID()).audit(false)
                .fullName(wu.getVcFirstName() + " " + wu.getVcLastName()).designation(wu.getVcDesignation())
                .email(wu.getVcEmailID()).mobile(wu.getVcMobile()).username(wu.getUsername()).edit(mp.isEdit())
                .delete(mp.isDelete()).approve(mp.isApprove()).publish(mp.isPublish()).build();
        return au;
    }

    public List<AppUser> parseList(List<WebUser> wus, MenuPermissions mp, WebUser user) {
        List<AppUser> res = new ArrayList<>();
        // Map<Integer, RoleDesc> rolemaster = roleDescService.findAllMap();
        // Map<Integer, GroupDesc> groupmaster = groupDescService.findAllMap();

        for (WebUser wu : wus) {

            AppUser au = AppUser.builder().id(wu.getIuserID()).audit(false)
                    .fullName(wu.getVcFirstName() + " " + wu.getVcLastName()).designation(wu.getVcDesignation())
                    .email(wu.getVcEmailID()).mobile(wu.getVcMobile()).username(wu.getUsername())
                    .contact(wu.getVcContact()).password(wu.getPassword()).address(wu.getVcAddress())
                    // .userGroup(getGroup(wu.getUserGroup(), groupmaster))
                    // .userPermissions(getRole(wu.getUserPermissions(), rolemaster))
                    .lastname(wu.getVcLastName())
                    .firstname(wu.getVcFirstName()).profileimg(wu.getVcProfileImg()).edit(mp.isEdit())
                    .delete(mp.isDelete()).approve(false).publish(mp.isPublish()).build();
            res.add(au);
        }
        return res;
    }

    public AppUser parse(WebUserAudit wua, MenuPermissions mp, WebUser user) {
        AppUser au = AppUser.builder().id(wua.getIUserAuditID()).audit(true)
                .fullName(wua.getVcFirstName() + " " + wua.getVcLastName()).designation(wua.getVcDesignation())
                .email(wua.getVcEmailID()).mobile(wua.getVcMobile()).username(wua.getVcUserName())
                .action(wua.getVcAction()).remark(wua.getVcRemark()).build();
        if (wua.getIEntryUserID().equals( user.getIuserID())) {
            au.setEdit(true);
        } else {
            au.setEdit(false);
        }

        if (wua.getIEntryUserID().equals(user.getIuserID()) || mp.isDelete()) {
            au.setDelete(true);
        } else {
            au.setDelete(false);
        }

        if (wua.getIEntryUserID() != user.getIuserID() && mp.isApprove()) {
            au.setApprove(true);
        } else {
            au.setApprove(false);
        }
        au.setPublish(false);
        return au;
    }

    public List<AppUser> parseAuditList(List<WebUserAudit> wus, MenuPermissions mp, WebUser user) {

        // Map<Integer, RoleDesc> rolemaster = roleDescService.findAllMap();
        // Map<Integer, GroupDesc> groupmaster = groupDescService.findAllMap();

        return wus.stream()
                .map(wu -> {

                    AppUser au = AppUser.builder().id(wu.getIUserAuditID()).audit(true)
                            .fullName(wu.getVcFirstName() + " " + wu.getVcLastName()).designation(wu.getVcDesignation())
                            .email(wu.getVcEmailID()).mobile(wu.getVcMobile()).username(wu.getVcUserName())
                            .contact(wu.getVcContact()).address(wu.getVcAddress()).firstname(wu.getVcFirstName())
                            .lastname(wu.getVcLastName())
//                            .password(wu.getVcPassword())
                            // .userGroup(getGroup(wu.getUserGroup(), groupmaster))
                            // .userPermissions(getRole(wu.getUserPermissions(), rolemaster))
                            .profileimg(wu.getVcProfileImg())
                            .action(wu.getVcAction())
                            .remark(wu.getVcRemark())
                            .vcorgid(wu.getIorgId().getVcOrgId())
                            .action(wu.getVcAction()).build();
                    if (wu.getIEntryUserID().equals(user.getIuserID())) {
                        au.setEdit(true);
                    } else {
                        au.setEdit(false);
                    }

                    if (wu.getIEntryUserID().equals(user.getIuserID())) {
                        au.setDelete(true);
                    } else {
                        au.setDelete(false);
                    }

                    //System.out.println("wu entry user id " + wu.getIEntryUserID().getUsername() + " logged in user id " + user.getVcUserName() + " to add user id " + wu.getVcUserName());
                    if (!wu.getIEntryUserID().equals(user.getIuserID()) && mp.isApprove()) {
                        au.setApprove(true);
                    } else {
                        au.setApprove(false);
                    }
                    au.setPublish(false);
                    return au;
                })
                .collect(Collectors.toList());

    }

    private List<DropdownWithObject> getRole(List<Integer> rolelist, Map<Integer, RoleDesc> rolemaster) {
        return rolelist.stream().map(a -> rolemaster.get(a)).collect(Collectors.toList()).stream().map(a -> {
            return DropdownWithObject.builder().label(a.getVcRoleName()).value(a.getVcRoleName()).build();
        }).collect(Collectors.toList());
    }

    private List<DropdownWithObject> getGroup(List<Integer> groupList, Map<Integer, GroupDesc> groupmaster) {
        return groupList.stream().map(a -> groupmaster.get(a)).collect(Collectors.toList()).stream().map(a -> {
            return DropdownWithObject.builder().label(a.getVcGroupName()).value(a.getIgroupID()).build();
        }).collect(Collectors.toList());
    }

}
