package com.DronaPay.UIServer.service.ControllerService.MlModel;

import com.DronaPay.UIServer.requests.*;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface MlModelControllerService {

    ResponseEntity<?> getListOfAvailableMlModels(Authentication pr);

    ResponseEntity<?> getAvailableMlModel(GetMlModelRequest getMlModelRequest, Authentication pr);

    ResponseEntity<?> getListOfTrainedMlModels(Authentication pr);

    ResponseEntity<?> getTrainedMlModel(GetTrainedMlModelRequest getTrainedMlModelRequest, Authentication pr);

    ResponseEntity<?> addMlModel(AddMlModelRequest addMlModelRequest, Authentication pr);

    ResponseEntity<?> editMlModel(EditMlModelRequest editMlModelRequest, Authentication pr);

    ResponseEntity<?> deleteMlModel(DeleteMlModelRequest deleteMlModelRequest, Authentication pr);

    ResponseEntity<?> approveMlModel(ApproveMlModelRequest approveMlModelRequest, Authentication pr);
}
