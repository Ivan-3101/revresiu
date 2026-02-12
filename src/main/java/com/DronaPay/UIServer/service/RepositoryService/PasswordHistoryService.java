package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.PasswordHistory;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.response.ApiResponse;

import java.util.List;

public interface PasswordHistoryService {

    public List<PasswordHistory> getPasswordHistoryByUserIdAndIorgId(Integer iuserId, Integer IorgId);

    public ApiResponse handlePasswordHistory(WebUser webUser, Boolean isNewUser, String word) throws Exception;

}
