package org.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.example.utils.JwtUtils;

import java.io.IOException;
@Slf4j
//@WebFilter("/*")//拦截所有请求
public class TokenFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        //1、获取请求路径
        String path = request.getServletPath();
        //2、判断请求路径是否包含/login，如果是则进行放行
        if (path.contains("/login")) {
            log.info("登录请求，放行");
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        //3、获取请求头中的token
        String token = request.getHeader("token");

        //4、判断token是否存在，如果不存在，说明用户没有进行登录，则返回401
        if (token == null || token.isEmpty()) {
            log.info("token不存在，返回401");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        //5、如果token存在，校验token的合法性，如果失败，则返回401
       try {
           JwtUtils.parseToken(token);
       } catch (Exception e) {
           log.info("token非法，返回401");
           response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
           return;
       }
        //6、如果token合法，则放行
        log.info("token合法，放行");
        filterChain.doFilter(servletRequest, servletResponse);
    }
}
