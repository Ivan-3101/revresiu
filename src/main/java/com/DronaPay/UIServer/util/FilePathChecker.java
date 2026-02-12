package com.DronaPay.UIServer.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFileAttributes;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;


import com.DronaPay.UIServer.service.CamundaServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class FilePathChecker {

    private static final Logger LOGGER = LoggerFactory.getLogger(FilePathChecker.class);

    public File sanitizePath(File baseDir, String filename) throws Exception {
        // Basic validation
        if (filename == null || filename.isEmpty()) {
            LOGGER.error("Empty filename received");
            throw new Exception("Empty filename");
        }

        // Block directory traversal patterns
        if (filename.contains("..") || filename.contains("/") || filename.contains("\\")) {
            LOGGER.error("Directory traversal attempt detected");
            throw new Exception("Invalid filename");
        }

        // Canonical path containment check
        File target = new File(baseDir, filename).getCanonicalFile();
        String canonicalBase = baseDir.getCanonicalPath() + File.separator;

        if (!target.getCanonicalPath().startsWith(canonicalBase)) {
            LOGGER.error("Path containment violation");
            throw new Exception("Path traversal attempt blocked");
        }

        return target;
    }

    public static boolean isValidUUID(String input) {
        try {
            UUID.fromString(input);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public Boolean isValidPath(String inputPath) throws IOException {
        File file = new File(inputPath).getCanonicalFile();
        String pathUsingCanonical;
        String pathUsingAbsolute;
        pathUsingCanonical = file.getCanonicalPath();
        pathUsingAbsolute = file.getAbsolutePath();
        if(pathUsingAbsolute.equals(pathUsingCanonical)) {
            return true;
        } else {
            return false;
        }
    }

    public void setPermissions(Path path) throws IOException {
        
        File file = path.toFile();
        
        //disallow read,write,execute permission for everyone
        file.setExecutable(false, false);
        file.setWritable(false, false);
        file.setReadable(false, false);

        //allow read and write only for owner
        file.setWritable(true,true);
        file.setReadable(true, true);

        // Boolean isPosix = FileSystems.getDefault().supportedFileAttributeViews().contains("posix");
        // if(!isPosix) {
        //     return;
        // }
        // Set<PosixFilePermission> perms = Files.readAttributes(path,PosixFileAttributes.class).permissions();
        // System.out.format("Permissions before: %s%n",  PosixFilePermissions.toString(perms));
        
        // Set<PosixFilePermission> newPerms = new HashSet<PosixFilePermission>();
        // newPerms.add(PosixFilePermission.OWNER_READ);
        // newPerms.add(PosixFilePermission.OWNER_WRITE);

        // Files.setPosixFilePermissions(path, newPerms);

        // perms = Files.readAttributes(path,PosixFileAttributes.class).permissions();
        // System.out.format("Permissions after:  %s%n",  PosixFilePermissions.toString(perms));
    }
}
