package com.kedu.controllers;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    private ServletContext servletContext;

    @RequestMapping(value="/uploadImageFile", produces="application/json; charset=utf8")
    @ResponseBody
    public String uploadImageFile(
            @RequestParam("file") MultipartFile multipartFile) {

        System.out.println("이미지 업로드 요청 들어옴");

        JsonObject jsonObject = new JsonObject();

        // 프로젝트의 resources/uploads 폴더
        String fileRoot = servletContext.getRealPath("/resources/uploads/");

        File uploadFolder = new File(fileRoot);

        // 폴더가 없으면 생성
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String originalFileName = multipartFile.getOriginalFilename();
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

        String savedFileName = UUID.randomUUID() + extension;

        File targetFile = new File(uploadFolder, savedFileName);

        try {
            InputStream fileStream = multipartFile.getInputStream();

            FileUtils.copyInputStreamToFile(fileStream, targetFile);

            // DB에는 이 주소가 저장됨
            jsonObject.addProperty(
                "url",
                "/uploads/" + savedFileName
            );

            jsonObject.addProperty("responseCode", "success");

        } catch (IOException e) {

            FileUtils.deleteQuietly(targetFile);

            jsonObject.addProperty("responseCode", "error");

            e.printStackTrace();
        }

        return jsonObject.toString();
    }
}