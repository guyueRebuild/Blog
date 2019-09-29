package com.blog.exception;

public enum  CustomizeErrorCode implements ICustomizeErrorCode {
    FILE_UPLOAD_FAIL(2001,"文件上传失败！"),
    SYSTEM_ERROR(2001,"系统错误"),
    ;

    private String message;
    private Integer code;

    CustomizeErrorCode(Integer code, String message) {
        this.message = message;
        this.code = code;
    }


    @Override
    public String getMessage() {
        return this.message;
    }

    @Override
    public Integer getCode() {
        return this.code;
    }
}
