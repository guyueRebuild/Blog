package com.blog.provider;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.OSSException;
import com.blog.exception.CustomizeErrorCode;
import com.blog.exception.CustomizeException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.net.URL;
import java.util.Date;
import java.util.UUID;

@Service
public class AliyunProvider {

    @Value("${filecloud.endpoint}")
    String endpoint;
    @Value("${filecloud.accessKeyId}")
    String accessKeyId;
    @Value("${filecloud.accessKeySecret}")
    String accessKeySecret;
    @Value("${filecloud.bucketName}")
    String bucketName;
    @Value("${filecloud.expiration}")
    private Long expirationNum;

    public String upload(InputStream content, String fileName) {
        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        String[] filePaths = fileName.split("\\.");
        String generatedFileName = "";
        if (filePaths.length > 1) {
            generatedFileName = UUID.randomUUID().toString() + "." + filePaths[filePaths.length - 1];
        } else {
            throw new CustomizeException(CustomizeErrorCode.FILE_UPLOAD_FAIL);
        }

        // 上传内容到指定的存储空间（bucketName）并保存为指定的文件名称（objectName）。
        try {
            ossClient.putObject(bucketName, generatedFileName, content);
        } catch (OSSException | ClientException e) {
            e.printStackTrace();
            ossClient.shutdown();
            throw new CustomizeException(CustomizeErrorCode.FILE_UPLOAD_FAIL);
        }

        // 设置URL过期时间为10年。
        Date expiration = new Date(new Date().getTime() + expirationNum);
        // 生成以GET方法访问的签名URL，访客可以直接通过浏览器访问相关内容。
        URL url = ossClient.generatePresignedUrl(bucketName, generatedFileName, expiration);
        // 关闭OSSClient。
        ossClient.shutdown();

        return url.toString();
    }


}
