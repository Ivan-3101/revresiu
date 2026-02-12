package com.DronaPay.UIServer.service;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface FileStorageService {

	public String storeFile(MultipartFile file) throws Exception;

	public Resource loadFileAsResource(String fileName) throws IOException;

}