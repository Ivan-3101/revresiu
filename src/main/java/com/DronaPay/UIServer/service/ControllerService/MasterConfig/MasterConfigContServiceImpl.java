package com.DronaPay.UIServer.service.ControllerService.MasterConfig;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.MenuNames;
import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.MasterConfig;
import com.DronaPay.UIServer.model.MasterConfigCustom;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.requests.MasterConfigRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.MasterConfigResponse;
import com.DronaPay.UIServer.response.MenuPermissions;
import com.DronaPay.UIServer.service.RepositoryService.ActivityLogService;
import com.DronaPay.UIServer.service.RepositoryService.MasterConfigCustomService;
import com.DronaPay.UIServer.service.RepositoryService.MasterConfigService;
import com.DronaPay.UIServer.service.RepositoryService.WebUserService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class MasterConfigContServiceImpl implements MasterConfigContService {
    final String menu_name = MenuNames.masters;
    @Autowired
    private ActivityLogService activityLogService;
    @Autowired
    private MasterConfigService masterConfigService;
    @Autowired
    private MasterConfigCustomService masterConfigCustomService;
    @Autowired
    private WebUserService webUserService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Override
    public ResponseEntity<?> getMasterConfig(MasterConfigRequest req, String menuname, Authentication pr) {

        log.debug("entered in class " + MasterConfigContServiceImpl.class + " in method getMasterConfig");

        LoggedUser temp = (LoggedUser) pr.getPrincipal();
        WebUser loggedInUser = temp.getWebUser();

        if (menuname.isBlank()) {
            log.error("Error : " + loggerEncoderUtil.encode(menuname) + "\nParam : " + loggerEncoderUtil.encode(menuname));
             activityLogService.addActivity(  loggedInUser , "menu name is not valid ",
             menuname.toString());
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please provide valid menu name"),
                    HttpStatus.BAD_REQUEST);
        }

        activityLogService.addActivity(loggedInUser, "Master config access for menuname ?  " + menuname, req.toString());

        MenuPermissions mp = temp.getPermissions().get(menuname);

        if (mp.isView()) {
            List<MasterConfigResponse> response = new ArrayList<>();
            try {
                System.out.println("Request " + req);
                List<MasterConfig> masterConfigsOrig = masterConfigService.findAllByName(req.getNames());
                System.out.println("master config orig list " + masterConfigsOrig);
                List<Integer> origIds = masterConfigsOrig.stream().map(m -> m.getIconfigId()).collect(Collectors.toList());
                List<MasterConfigCustom> masterConfigCustoms = masterConfigCustomService.findAllByParentId(origIds);
                System.out.println("master config customs list " + masterConfigCustoms);
                //remove entries of masterconfig whose ids are present in masterconfigcustom
                Iterator<MasterConfig> it = masterConfigsOrig.iterator();
                while (it.hasNext()) {
                    MasterConfig master = it.next();
                    for (MasterConfigCustom msCus : masterConfigCustoms) {
                        if (msCus.getIparentId().getIconfigId().equals(master.getIconfigId())) {
                            it.remove();
                            break;
                        }
                    }
                }
                for (MasterConfig ms : masterConfigsOrig) {
                    MasterConfigResponse mRes = new MasterConfigResponse();
                    mRes.setName(ms.getConfigName());
                    mRes.setConfigJson(ms.getConfigJson());
                    response.add(mRes);
                }
                for (MasterConfigCustom msCus : masterConfigCustoms) {
                    MasterConfigResponse mRes = new MasterConfigResponse();
                    mRes.setName(msCus.getIparentId().getConfigName());
                    mRes.setConfigJson(msCus.getConfigJson());
                    response.add(mRes);
                }
                return ResponseEntity.ok(response);
            } catch (Exception e) {
                log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(pr.toString()));
                activityLogService.addActivity(loggedInUser, "failed to get user and permissions", e.toString());
                return new ResponseEntity<ApiResponse>(new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {
            activityLogService.addActivity(loggedInUser, "unauthorized to access master config");
            log.debug("Exiting getListManagement Method in " + MasterConfigContServiceImpl.class
                    + " class with response  : unauthorized to access master config");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "unauthorized to access master config"),
                    HttpStatus.FORBIDDEN);
        }

    }

}
