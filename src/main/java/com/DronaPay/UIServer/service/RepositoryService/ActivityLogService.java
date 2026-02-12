package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.model.ActivityLog;

public interface ActivityLogService {

	public void save(ActivityLog al) throws Exception;

	public void addActivity(WebUser webUser, String activity, String parameters);

    public void addActivity(Integer iuserid, Integer iorgid ,  String activity, String parameters);
	// public void addActivity(String activity, String parameters);

	public void addActivity(WebUser webUser, String activity);

}
