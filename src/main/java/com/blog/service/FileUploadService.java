package com.blog.service;

import org.springframework.web.multipart.MultipartFile;
import com.blog.upload.ImageUploadMessage;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

public interface FileUploadService {


    ImageUploadMessage uploadEditorImage(List<MultipartFile> imgList, HttpServletRequest request) throws IOException;
}
