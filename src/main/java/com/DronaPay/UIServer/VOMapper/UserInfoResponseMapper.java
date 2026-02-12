package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.response.UserInfoResponse;

public class UserInfoResponseMapper {
    public static UserInfoResponse parse(WebUser webUser) {
        UserInfoResponse temp = new UserInfoResponse();
        temp.setFirstName(webUser.getVcFirstName());
        temp.setLastName(webUser.getVcLastName());
        temp.setUserName(webUser.getVcUserName());
        temp.setEmail(webUser.getVcEmailID());
        temp.setContact(webUser.getVcContact());
        temp.setMobile(webUser.getVcMobile());
        temp.setProfileImg(webUser.getVcProfileImg());
        temp.setAddress(webUser.getVcAddress());
        temp.setDesignation(webUser.getVcDesignation());
        temp.setTimezone(webUser.getTimeZone());
        temp.setLastLoginTime(webUser.getDtLastLoginDate());
        temp.setVcOrgId(webUser.getIorgId().getVcOrgId());
        temp.setIuserid(webUser.getIuserID());
        return temp;
    }
}
