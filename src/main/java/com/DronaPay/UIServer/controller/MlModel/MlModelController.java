package com.DronaPay.UIServer.controller.MlModel;

import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.service.ControllerService.MlModel.MlModelControllerService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/testing/ai-ml/ml-models")
public class MlModelController {

    @Autowired
    private MlModelControllerService mlModelControllerService;

    @GetMapping("/get-available-mlmodels-list")
    public ResponseEntity<?> getAvailableMlModels(Authentication pr) {
        return mlModelControllerService.getListOfAvailableMlModels(pr);
    }

    @PostMapping("/get-available-mlmodel")
    public ResponseEntity<?> getAvailableMlModel(@RequestBody @Valid GetMlModelRequest getMlModelRequest, Authentication pr) {
        return mlModelControllerService.getAvailableMlModel(getMlModelRequest, pr);
    }

    @GetMapping("/get-trained-mlmodels-list")
    public ResponseEntity<?> getTrainedMlModels(Authentication pr) {
        return mlModelControllerService.getListOfTrainedMlModels(pr);
    }

    @PostMapping("/get-trained-mlmodel")
    public ResponseEntity<?> getTrainedMlModel(@RequestBody @Valid GetTrainedMlModelRequest getTrainedMlModelRequest, Authentication pr) {
        return mlModelControllerService.getTrainedMlModel(getTrainedMlModelRequest, pr);
    }

    @PostMapping("/add-mlmodel")
    public ResponseEntity<?> addMlModel(@RequestBody @Valid AddMlModelRequest addMlModelRequest, Authentication pr) {
        return mlModelControllerService.addMlModel(addMlModelRequest, pr);
    }

    @PostMapping("/edit-mlmodel")
    public ResponseEntity<?> editMlModel(@RequestBody @Valid EditMlModelRequest editMlModelRequest, Authentication pr) {
        return mlModelControllerService.editMlModel(editMlModelRequest, pr);
    }

    @PostMapping("/delete-mlmodel")
    public ResponseEntity<?> deleteMlModel(@RequestBody @Valid DeleteMlModelRequest deleteMlModelRequest, Authentication pr) {
        return mlModelControllerService.deleteMlModel(deleteMlModelRequest, pr);
    }

    @PostMapping("/approve-mlmodel")
    public ResponseEntity<?> approveMlModel(@RequestBody @Valid ApproveMlModelRequest approveMlModelRequest, Authentication pr) {
        return mlModelControllerService.approveMlModel(approveMlModelRequest, pr);
    }
}
