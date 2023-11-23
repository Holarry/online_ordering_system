package com.holary.service;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/10/10 20:09
 * @Description: LoginService
 */
public interface LoginService {
    /**
     * description: 用户登录
     *
     * @param username: 用户名
     * @param password: 密码
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> selectUserByUsername(String username, String password);

    /**
     * description: 用户注册
     *
     * @param username:   用户名
     * @param password:   密码
     * @param rePassword: 确认密码
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> register(String username, String password, String rePassword);
}
