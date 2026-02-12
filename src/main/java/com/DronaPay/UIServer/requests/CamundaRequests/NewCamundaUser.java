package com.DronaPay.UIServer.requests.CamundaRequests;

import com.DronaPay.UIServer.requests.CamundaRequests.CamundaRequestVO.CamundaCredentials;
import com.DronaPay.UIServer.requests.CamundaRequests.CamundaRequestVO.CamundaProfile;
import lombok.Data;

@Data
public class NewCamundaUser {
    private CamundaProfile profile;
    private CamundaCredentials credentials;
}
