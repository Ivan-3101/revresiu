package com.DronaPay.UIServer.VOMapper;

import java.util.ArrayList;
import java.util.List;

import com.DronaPay.UIServer.ResponseVO.UserEntryVO;
import com.DronaPay.UIServer.model.WebUser;

public class UserEntryVOMapper {
    public static List<UserEntryVO> parseWebUser(List<WebUser> webUserList) {
        List<UserEntryVO> res = new ArrayList<>();
        for (WebUser wu : webUserList) {
            UserEntryVO uVo = UserEntryVO.builder().vcusername(wu.getVcUserName()).userid(wu.getIuserID()).build();
            res.add(uVo);
        }
        return res;
    }
}
