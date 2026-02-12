package com.DronaPay.UIServer.response;

import java.util.List;

import com.DronaPay.UIServer.ResponseVO.UserEntryVO;
import lombok.Data;

@Data
public class UserMappingResponse {
    List<UserEntryVO> mappedUsers;
    List<UserEntryVO> unmappedUsers;
}