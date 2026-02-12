package com.DronaPay.UIServer.service;

import com.DronaPay.UIServer.configuration.FileStorageProperties;
import com.DronaPay.UIServer.exception.FileStorageException;
import com.DronaPay.UIServer.exception.MyFileNotFoundException;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.TasksServiceImpl;
import com.DronaPay.UIServer.util.FilePathChecker;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import java.io.IOException;

@Service
public class FileStorageServiceImpl implements FileStorageService {

	private static final Logger LOGGER = LoggerFactory.getLogger(FileStorageServiceImpl.class);

	private final Path fileStorageLocation;

	@Autowired
	private LoggerEncoderUtil loggerEncoderUtil;

	@Autowired
	private FilePathChecker filePathChecker;

	@Autowired
	public FileStorageServiceImpl(FileStorageProperties fileStorageProperties) throws Exception {
		LOGGER.debug("entered in class " + FileStorageServiceImpl.class + " in method FileStorageServiceImpl");

		this.fileStorageLocation = Paths.get(fileStorageProperties.getUploadDir()).toAbsolutePath().normalize();

		try {
			Files.createDirectories(this.fileStorageLocation);
		} catch (Exception e) {
			LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(fileStorageProperties.toString()));
			throw new FileStorageException("Could not create the directory where the uploaded files will be stored.",
					e);
		}
		FilePathChecker pathCheckerUtil = new FilePathChecker();
		pathCheckerUtil.setPermissions(fileStorageLocation);
	}

	public String storeFile(MultipartFile file) throws Exception {

		LOGGER.debug("entered in class " + FileStorageServiceImpl.class + " in method storeFile");

		// Normalize file name
		String fileName = System.currentTimeMillis() + "";
		// Check if the file's name contains invalid characters
		if (fileName.contains("..")) {
			LOGGER.debug("Exiting storeFile Method in " + TasksServiceImpl.class
					+ " class with response  : Sorry! Filename contains invalid path sequence");
			throw new FileStorageException("Sorry! Filename contains invalid path sequence " + fileName);
		}

		// Copy file to the target location (Replacing existing file with the same name)
		Path targetLocation = this.fileStorageLocation.resolve(fileName).toAbsolutePath().normalize();
		Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);
		filePathChecker.setPermissions(targetLocation);
		LOGGER.debug("Exiting storeFile Method in " + TasksServiceImpl.class
				+ " class with response  : file name of stored file");
		return fileName;
	}

	public Resource loadFileAsResource(String fileName) throws IOException {
		LOGGER.debug("entered in class " + FileStorageServiceImpl.class + " in method loadFileAsResource");

		try {
			Path filePath = this.fileStorageLocation.resolve(fileName);

			if (filePathChecker.isValidPath(filePath.toString())) {
				Resource resource = new UrlResource(filePath.toUri());
				if (resource.exists()) {
					return resource;
				}
			}
			LOGGER.debug("Exiting storeFile Method in " + TasksServiceImpl.class
							+ " class with response  : File not found " + fileName);
					throw new MyFileNotFoundException("File not found " + fileName);
		} catch (MalformedURLException e) {
			LOGGER.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(fileName));
			throw new MyFileNotFoundException("File not found " + fileName, e);
		}
	}
}
