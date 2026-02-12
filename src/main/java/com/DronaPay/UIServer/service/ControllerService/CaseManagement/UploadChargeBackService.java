package com.DronaPay.UIServer.service.ControllerService.CaseManagement;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;


public interface UploadChargeBackService {

    public ResponseEntity<?> getAllUploadChargeBacks(Authentication pr) throws Exception;

    public ResponseEntity<?> uploadChargeBack(MultipartFile file, Authentication pr) throws Exception;

    public ResponseEntity<?> downloadTemplate(Authentication pr, HttpServletRequest request) throws Exception;

    public ResponseEntity<?> downloadErrorLog(int id, Authentication pr, HttpServletRequest request) throws Exception;
}
