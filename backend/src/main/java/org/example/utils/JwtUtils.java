package org.example.utils;

import io.jsonwebtoken.*;
import java.util.Date;
import java.util.Map;

/**
 * JWT工具类
 */
public class JwtUtils {

    // 秘钥，和测试类保持一致
    private static final String SECRET_KEY = "bmlra2k=";
    // 过期时间：36小时，单位毫秒
    private static final long EXPIRATION_TIME = 36L * 60 * 60 * 1000;


    /**
     * 生成JWT令牌
     * @param claims 自定义载荷数据
     * @return jwt token字符串
     */
    public static String generateToken(Map<String, Object> claims) {
        return Jwts.builder()
                // 设置签名算法和秘钥
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                // 存入自定义载荷
                .addClaims(claims)
                // 设置过期时间：当前时间 + 36小时
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .compact();
    }


    /**
     * 解析JWT令牌，获取载荷Claims
     * @param token jwt令牌
     * @return Claims 载荷信息
     * @throws ExpiredJwtException token过期
     * @throws SignatureException 签名错误（秘钥不对/令牌篡改）
     * @throws MalformedJwtException token格式错误
     */
    public static Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody();
    }

}
