package com.rocket.common;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Iterator;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class FileUtil {
    private String filePath;

    public String updateImg(MultipartHttpServletRequest mpRequest, HttpServletRequest request) throws Exception {
        filePath = request.getServletContext().getRealPath("/resources/upload/profile/");
        Iterator<String> iterator = mpRequest.getFileNames();
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;
        String empFile = "";
        File file = new File(filePath);
        if(!file.exists()) {
            file.mkdirs();
        }
        while(iterator.hasNext()) {
            multipartFile = mpRequest.getFile(iterator.next());
            if(!multipartFile.isEmpty()) {
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = getRandomString() + originalFileExtension;
                file = new File(filePath + storedFileName);
                multipartFile.transferTo(file);
                empFile = storedFileName;
            }
        }
        return empFile;
    }

    private String getRandomString() {
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HH24mmssSSS");
    	int rnd=(int)(Math.random()*1000)+1;
        return "rocket"+sdf.format(System.currentTimeMillis())+"_"+rnd;
    }
}