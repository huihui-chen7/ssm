package com.java.controller.expt;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * description：
 * author：丁鹏
 * date：09:16
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handExpt(Exception ex){
        return "redirect/pages/error/error.jsp";
    }

}
