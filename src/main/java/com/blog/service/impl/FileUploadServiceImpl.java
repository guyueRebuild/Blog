package com.blog.service.impl;

import com.blog.service.FileUploadService;
import com.blog.util.DateUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.blog.upload.ImageUploadMessage;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * 博客图片上传
 */
@Service("fileUploadService")
public class FileUploadServiceImpl implements FileUploadService {

    @Override
    public ImageUploadMessage uploadEditorImage(List<MultipartFile> imgList, HttpServletRequest request) throws IOException {
        String realName;
        String realPath;
        if(imgList!=null&&imgList.size()!=0){
            ImageUploadMessage message = new ImageUploadMessage();
            List<String> urls = new ArrayList<>();
            for (MultipartFile img : imgList) {
                String fileName = img.getOriginalFilename();
                String fileNameExtension = fileName != null ? fileName.substring(fileName.indexOf(".")) : "";
                realName = UUID.randomUUID().toString() + fileNameExtension+ DateUtil.getCurrentDateStr();
                realPath = request.getSession().getServletContext().getRealPath("/uploadFile");

                File uploadFile = new File(realPath, realName);
                img.transferTo(uploadFile);
                urls.add(request.getContextPath() + "/uploadFile/" + realName);
            }
            message.setData(urls);
            message.setErrno(0);
            return message;
        }
        ImageUploadMessage message = new ImageUploadMessage();
        message.setErrno(1);
        return message;
    }
}
