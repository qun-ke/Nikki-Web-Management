package org.example.exception;

import lombok.extern.slf4j.Slf4j;
import org.example.pojo.Result;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    //业务异常：返回异常中携带的明确提示信息（如删除部门时部门下还有员工）
    @ExceptionHandler(BusinessException.class)
    public Result businessException(BusinessException e) {
        log.warn("业务异常：{}", e.getMessage());
        return Result.error(e.getMessage());
    }

    @ExceptionHandler
    public Result handleGlobalException(Exception e){
        log.error("程序出错了",e);
        return Result.error("出错了，请联系管理员");
    }

    @ExceptionHandler
    public  Result duplicateKeyException(DuplicateKeyException e){
        log.error("程序出错了",e);
        String message=e.getMessage();
        int i=message.indexOf("Duplicate entry");
        String errMsg=message.substring(i);
        String[] arr=errMsg.split(" ");
        return Result.error(arr[2]+"已存在");
    }
}
