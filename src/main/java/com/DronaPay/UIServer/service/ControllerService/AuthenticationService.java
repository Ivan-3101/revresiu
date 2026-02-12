package com.DronaPay.UIServer.service.ControllerService;

import com.DronaPay.UIServer.requests.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

public interface AuthenticationService {

    public ResponseEntity<?> logAuth(AuthenticationRequest authenticationRequest, HttpServletRequest request)
            throws InvalidKeySpecException, NoSuchAlgorithmException;

    public ResponseEntity<?> getUserInfo(Authentication user);

    public ResponseEntity<?> getSideBar(Authentication authentication);

    public ResponseEntity<?> addActivity(ActivityLogRequest alr, Authentication pr);

    public ResponseEntity<?> uploadFile(MultipartFile file, Authentication pr);

    public ResponseEntity<?> downloadFile(String fileName, HttpServletRequest request) throws IOException;

    public ResponseEntity<?> downloadLogo(String fileName, HttpServletRequest request) throws IOException;

    public ResponseEntity<?> forgotPassword(String emailId, String vcorgid);

    public ResponseEntity<?> validateToken(String token);

    public ResponseEntity<?> resetPassword(ResetPasswordRequest resetPassword);

    public ResponseEntity<?> logOut(Authentication user, HttpServletRequest request);

    public ResponseEntity<?> token(CodeBody user);

    public ResponseEntity<?> getSSO(String orgId);


    public ResponseEntity<?> refreshToken(RefreshToken request);

    public ResponseEntity<?> getapikey(int tenantid);
}
