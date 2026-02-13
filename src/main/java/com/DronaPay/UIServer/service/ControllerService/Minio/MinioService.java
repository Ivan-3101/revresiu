package com.DronaPay.UIServer.service.ControllerService.Minio;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;

public interface MinioService {
    ResponseEntity<InputStreamResource> downloadFile(String filePath) throws Exception;
}