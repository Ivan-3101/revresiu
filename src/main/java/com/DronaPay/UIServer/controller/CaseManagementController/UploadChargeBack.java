package com.DronaPay.UIServer.controller.CaseManagementController;

import com.DronaPay.UIServer.service.ControllerService.CaseManagement.UploadChargeBackService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


@RestController
@RequestMapping("/api/v1/case-management/upload-chargeback")
public class UploadChargeBack {

    @Autowired
    private UploadChargeBackService uploadChargeBack;

    @GetMapping("/")
    public ResponseEntity<?> getUploadChargeBacks(Authentication pr) throws Exception {
        return uploadChargeBack.getAllUploadChargeBacks(pr);
    }

    @PostMapping("/upload-file")
    public ResponseEntity<?> uploadChargeBackFile(@RequestParam(value = "file", required = true) MultipartFile file, Authentication pr) throws Exception {
        return uploadChargeBack.uploadChargeBack(file, pr);

    }

    @GetMapping("/download-template")
    public ResponseEntity<?> downloadTemplate(Authentication pr, HttpServletRequest request) throws Exception {
        return uploadChargeBack.downloadTemplate(pr, request);
    }

    @GetMapping("/download-error-log/{id}")
    public ResponseEntity<?> downloadErrorLog(@PathVariable(name = "id", required = true) int id, Authentication pr, HttpServletRequest request) throws Exception {
        return uploadChargeBack.downloadErrorLog(id, pr, request);
    }

}
