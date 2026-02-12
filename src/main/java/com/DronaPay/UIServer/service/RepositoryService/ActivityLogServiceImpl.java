package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ActivityLog;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.repository.ActivityLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;

@Service
public class ActivityLogServiceImpl implements ActivityLogService {

    @Autowired
    private ActivityLogRepository activityLogRepository;

    public void save(ActivityLog al) throws Exception {
        activityLogRepository.save(al);
    }

    public void addActivity(WebUser webUser, String activity, String parameters) {
        ActivityLog al = new ActivityLog();

//				ActivityLog.builder().iUserID(webUser).vcActivity(activity).dtActivity(new Date())
//				.vcParameters(parameters).build();
        al.setIUserID(webUser.getIuserID());
        al.setVcActivity(activity);
        al.setDtActivity(ZonedDateTime.now());
        al.setVcParameters(parameters);
        al.setIorgId(webUser.getIorgId().getIorgid());
        activityLogRepository.save(al);
    }

    public void addActivity(Integer iuserid, Integer iorgid ,  String activity, String parameters) {
        ActivityLog al = new ActivityLog();

//				ActivityLog.builder().iUserID(webUser).vcActivity(activity).dtActivity(new Date())
//				.vcParameters(parameters).build();
        al.setIUserID(iuserid);
        al.setVcActivity(activity);
        al.setDtActivity(ZonedDateTime.now());
        al.setVcParameters(parameters);
        al.setIorgId(iorgid);
        activityLogRepository.save(al);
    }

// 	public void addActivity(String activity, String parameters) {
// 		ActivityLog al = new ActivityLog();
// //				ActivityLog.builder().vcActivity(activity).dtActivity(new Date()).vcParameters(parameters)
// //				.build();
//         al.setVcActivity(activity);
//         al.setDtActivity(new Date());
//         al.setVcParameters(parameters);
// 		activityLogRepository.save(al);
// 	}

    public void addActivity(WebUser webUser, String activity) {
        ActivityLog al = new ActivityLog();
//				ActivityLog.builder().iUserID(webUser).vcActivity(activity).dtActivity(new Date()).build();
        al.setIUserID(webUser.getIuserID());
        al.setVcActivity(activity);
        al.setDtActivity(ZonedDateTime.now());
        al.setIorgId(webUser.getIorgId().getIorgid());
        activityLogRepository.save(al);
    }

}
