package com.holary.controller;

import com.holary.service.LoginService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/10/3 23:03
 * @Description: LoginController
 */
@Controller
public class LoginController {
    @Autowired
    private LoginService loginService;

    /**
     * description: 通用跳转方法
     *
     * @param page:
     * @return: java.lang.String
     */
    @RequestMapping("{page}")
    public String toPage(@PathVariable() String page) {
        return page;
    }

    /**
     * description: 用户登录
     *
     * @param username: 用户名
     * @param password: 密码
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> login(String username, String password) {
        return loginService.selectUserByUsername(username, password);
    }

    /**
     * description: 用户注册
     *
     * @param username:   用户名
     * @param password:   密码
     * @param rePassword: 确认密码
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/register")
    @ResponseBody
    public Map<String, Object> register(String username, String password, String rePassword) {
        return loginService.register(username, password, rePassword);
    }

    /**
     * description: 用户登出
     *
     * @return: java.lang.String
     */
    @GetMapping("/logout")
    public String logout() {
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            subject.logout();
            return "login";
        }
        return null;
    }
}
