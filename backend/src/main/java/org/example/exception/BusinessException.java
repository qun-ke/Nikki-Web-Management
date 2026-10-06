package org.example.exception;

//业务异常：用于在业务校验不通过时，向前端返回明确的提示信息
public class BusinessException extends RuntimeException {
    public BusinessException(String message) {
        super(message);
    }
}
