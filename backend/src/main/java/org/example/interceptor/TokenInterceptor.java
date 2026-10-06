package org.example.interceptor;

import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.example.utils.CurrentHolder;
import org.example.utils.JwtUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
//令牌校验拦截器
@Slf4j
@Component
public class TokenInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//        //1、获取请求路径
//        String path = request.getServletPath();
//        //2、判断请求路径是否包含/login，如果是则进行放行
//        if (path.contains("/login")) {
//            log.info("登录请求，放行");
//            return true;
//        }
        //3、获取请求头中的token
        String token = request.getHeader("token");

        //4、判断token是否存在，如果不存在，说明用户没有进行登录，则返回401
        if (token == null || token.isEmpty()) {
            log.info("token不存在，返回401");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }
        //5、如果token存在，校验token的合法性，如果失败，则返回401
        try {
            Claims claims = JwtUtils.parseToken(token);
            Integer empId=Integer.valueOf(claims.get("id").toString());
            CurrentHolder.setCurrentId(empId);
            log.info("当前员工ID：{}", empId);
        } catch (Exception e) {
            log.info("token非法，返回401");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }
        //6、如果token合法，则放行
        log.info("token合法，放行");
        return true;

    }
    // 移除当前线程的员工ID
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        CurrentHolder.remove();
    }
}
