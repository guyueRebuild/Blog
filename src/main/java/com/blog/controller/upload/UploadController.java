package com.blog.controller.upload;

import com.blog.service.FileUploadService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.blog.upload.ImageUploadMessage;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/com/blog/upload")
public class UploadController {

    private final FileUploadService fileUploadService;

    public UploadController(FileUploadService fileUploadService) {
        this.fileUploadService = fileUploadService;
    }

    @RequestMapping(value = "/images",method = RequestMethod.POST)
    @ResponseBody
    public ImageUploadMessage images(@RequestParam("myFileName") List<MultipartFile> imgList, HttpServletRequest request) throws IOException {
        return fileUploadService.uploadEditorImage(imgList, request);
    }
}
