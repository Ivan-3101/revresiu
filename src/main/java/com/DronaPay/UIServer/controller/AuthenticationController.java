package com.DronaPay.UIServer.controller;

import com.DronaPay.UIServer.requests.*;
import com.DronaPay.UIServer.service.ControllerService.AuthenticationService;
import io.trino.jdbc.$internal.jakarta.annotation.PreDestroy;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.multipart.MultipartFile;
import reactor.core.publisher.Mono;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.time.Duration;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/api/v1")
@Slf4j
public class AuthenticationController {

    @Autowired
    private AuthenticationService authenticationControllerService;


    @PostMapping("/auth/login")
    public ResponseEntity<?> login(@RequestBody AuthenticationRequest authenticationRequest,
                                   HttpServletRequest request)
            throws InvalidKeySpecException, NoSuchAlgorithmException {


        return authenticationControllerService.logAuth(authenticationRequest, request);
    }

    @GetMapping("/auth/sso-config/{orgid}")
    public ResponseEntity<?> getSSO(@PathVariable("orgid") String orgId) {
        return authenticationControllerService.getSSO(orgId);
    }

    @GetMapping("/auth/sso-config")
    public ResponseEntity<?> getSSO() {
        return authenticationControllerService.getSSO("dronapay");
    }

    @GetMapping("/auth/userinfo")
    public ResponseEntity<?> getUserInfo(Authentication user) {

        System.out.println(user.getName());
        return authenticationControllerService.getUserInfo(user);
    }

// start get sidebar part

    @GetMapping("/auth/get-sidebar")
    public ResponseEntity<?> getDashboard(Authentication authentication) {


        return authenticationControllerService.getSideBar(authentication);
    }

// ends get sidebar part

    @PostMapping("/auth/add-activity")
    public ResponseEntity<?> addActivityLog(@RequestBody ActivityLogRequest alr, Authentication pr) {
        return authenticationControllerService.addActivity(alr, pr);
    }

    @PostMapping("/uploadFile")
    public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file, Authentication pr) {
        return authenticationControllerService.uploadFile(file, pr);
    }

    @GetMapping("/downloadFile/{fileName:.+}")
    public ResponseEntity<?> downloadFile(@PathVariable String fileName, HttpServletRequest request) throws IOException {
        return authenticationControllerService.downloadFile(fileName, request);
    }

    @GetMapping("/download-logo/{fileName:.+}")
    public ResponseEntity<?> downloadLogo(@PathVariable String fileName, HttpServletRequest request) throws IOException {
        return authenticationControllerService.downloadLogo(fileName, request);
    }

    @PostMapping("/forgot-password/{vcorgid}")
    public ResponseEntity<?> forgotPassword(@RequestBody String emailId, @PathVariable("vcorgid") String vcorgid) {
        return authenticationControllerService.forgotPassword(emailId, vcorgid);
    }

    @PostMapping("/validate-token")
    public ResponseEntity<?> downloadFile(@RequestBody String token) {
        return authenticationControllerService.validateToken(token);
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody ResetPasswordRequest requestPasswrodRequest) {
        return authenticationControllerService.resetPassword(requestPasswrodRequest);
    }

    @GetMapping("/auth/logout")
    public ResponseEntity<?> logOut(Authentication user, HttpServletRequest request) {
        return authenticationControllerService.logOut(user, request);
    }

    @PostMapping("/auth/token")
    public ResponseEntity<?> token(@RequestBody CodeBody request) {
        return authenticationControllerService.token(request);

    }

    @RequestMapping("/csrf")
    public CsrfToken csrf(CsrfToken token) {
        System.out.println(token.getToken());
        return token;
    }

    @PostMapping(value = "/auth/refreshtoken")
    public ResponseEntity<?> refreshtoken(@RequestBody RefreshToken request) throws Exception {
        return authenticationControllerService.refreshToken(request);
    }

    @GetMapping(value = "/auth/get-api-key/{tenantid}")
    public ResponseEntity<?> getapikey(@PathVariable("tenantid") int tenantid) throws Exception {
        return authenticationControllerService.getapikey(tenantid);
    }

    @GetMapping("/timeout-check/{timeout}")
    public ResponseEntity<String> timeoutCheck(@PathVariable("timeout") int timeout) {

        log.info("request received with timeout: {}", timeout);
        try {
            Thread.sleep(timeout * 1000L);
            return ResponseEntity.ok("Waited for " + timeout + " seconds");
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return ResponseEntity.status(500).body("Interrupted");
        }
    }

}
