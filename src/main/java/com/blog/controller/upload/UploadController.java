package com.blog.controller.upload;

import com.blog.dto.FileDTO;
import com.blog.provider.AliyunProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
public class UploadController {

    private final AliyunProvider aliyunProvider;

    public UploadController(AliyunProvider aliyunProvider) {
        this.aliyunProvider = aliyunProvider;
    }

    @RequestMapping(value = "/upload/image")
    @ResponseBody
    public FileDTO images(HttpServletRequest request) throws IOException {
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
        MultipartFile file = multipartHttpServletRequest.getFile("editormd-image-file");
        try {
            if (file != null) {
                String url = aliyunProvider.upload(file.getInputStream(), file.getOriginalFilename());
                FileDTO fileDTO = new FileDTO();
                fileDTO.setSuccess(1);
                fileDTO.setUrl(url);
                return fileDTO;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
