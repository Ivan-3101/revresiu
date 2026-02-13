package com.DronaPay.UIServer.controller.Minio;

import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.requests.MinioDownloadRequest;
import com.DronaPay.UIServer.service.ControllerService.Minio.MinioService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/minio")
@Slf4j
public class MinioController {

    @Autowired
    private MinioService minioService;

    /**
     * Download a file from MinIO
     * POST /api/v1/minio/download
     * Body: { "filePath": "1/HealthClaim/2026000403/DocTypeSplitter/discharge_summary.pdf" }
     *
     * @param request - Contains the file path
     * @param pr - Authentication principal
     * @return File as downloadable resource
     */
    @PostMapping("/download")
    public ResponseEntity<?> downloadFile(
            @RequestBody MinioDownloadRequest request,
            Authentication pr) {

        String filePath = null;

        try {
            filePath = request.getFilePath();

            log.info("Download request received from user. File path: {}", filePath);

            // Validate path
            if (filePath == null || filePath.trim().isEmpty()) {
                log.warn("Download request failed: filePath is missing or empty");
                return new ResponseEntity<>(
                        new ApiResponse(false, "File path is required"),
                        HttpStatus.BAD_REQUEST);
            }

            // Trim whitespace
            filePath = filePath.trim();

            // Security check: prevent path traversal attacks
            if (filePath.contains("..")) {
                log.warn("Download request rejected: potential path traversal attack detected. Path: {}", filePath);
                return new ResponseEntity<>(
                        new ApiResponse(false, "Invalid file path: path traversal not allowed"),
                        HttpStatus.BAD_REQUEST);
            }

            // Remove leading slash if present
            if (filePath.startsWith("/")) {
                filePath = filePath.substring(1);
            }

            // Download file from MinIO
            ResponseEntity<InputStreamResource> response = minioService.downloadFile(filePath);

            log.info("File downloaded successfully from MinIO: {}", filePath);
            return response;

        } catch (Exception e) {
            log.error("Error downloading file from MinIO. Path: {}, Error: {}", filePath, e.getMessage(), e);

            String errorMessage = "Failed to download file from MinIO";
            HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;

            // Handle specific MinIO exceptions
            String exceptionMsg = e.getMessage() != null ? e.getMessage().toLowerCase() : "";

            if (exceptionMsg.contains("nosuchkey") || exceptionMsg.contains("no such key") ||
                    exceptionMsg.contains("does not exist")) {
                errorMessage = "File not found in MinIO storage";
                status = HttpStatus.NOT_FOUND;
            } else if (exceptionMsg.contains("access denied") || exceptionMsg.contains("forbidden")) {
                errorMessage = "Access denied to the requested file";
                status = HttpStatus.FORBIDDEN;
            } else if (exceptionMsg.contains("bucket") && exceptionMsg.contains("not found")) {
                errorMessage = "MinIO bucket not found";
                status = HttpStatus.NOT_FOUND;
            }

            return new ResponseEntity<>(
                    new ApiResponse(false, errorMessage + ": " + filePath),
                    status);
        }
    }
}