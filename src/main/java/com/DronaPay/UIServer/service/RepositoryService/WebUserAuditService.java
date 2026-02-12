package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.ResponseVO.AppUser;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.WebUserAudit;
import com.DronaPay.UIServer.model.WebuserMappingAudit;
import com.DronaPay.UIServer.response.MenuPermissions;

public interface WebUserAuditService {

	public WebUserAudit findPendingAddEntryByUserName(String username, String vcorgid) throws Exception;

	public WebUserAudit findPendingAddEntryByIUserID(int iUserID) throws Exception;

	public void save(WebUserAudit wua, List<WebuserMappingAudit> mappinList) throws Exception;

	public void save(WebUserAudit wua) throws Exception;

	public List<WebUserAudit> getAllPendingEntry() throws Exception;

	public List<WebUserAudit> getAllPendingEntry(String org, LoggedUser loggedUser) throws Exception;

	public List<WebUserAudit> getAllPendingEntryCreatedByIUserID(int iUserID) throws Exception;

	public void update(WebUserAudit wua) throws Exception;

	public WebUserAudit findByWebUserAuditId(int id, String vcorgid) throws Exception;

	public Integer getLastWebUserIdfromAudit() throws Exception;

	public Integer getIUserIdForAudit() throws Exception;

	public Boolean getWebUserAuditExist(int WebUserID) throws Exception;

	public List<AppUser> getListOfWebUsers(List<WebUser> wus, MenuPermissions mp, WebUser user) throws Exception;

	public WebUserAudit findByEmail(String email, String vcorgid) throws Exception;

	public WebUserAudit findByUserName(String name, String orgid) throws Exception;

	public WebUserAudit findByUserId(Integer id) throws Exception;


}
