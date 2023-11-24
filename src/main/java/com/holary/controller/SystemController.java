package com.holary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author: Holary
 * @Date: 2023/10/10 20:31
 * @Description: SystemController
 */
@Controller
@RequestMapping("/sys")
public class SystemController {
    /**
     * description: 跳转登录页面
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goLogin")
    public String goLogin() {
        return "login";
    }

    /**
     * description: 跳转注册页面
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goRegister")
    public String goRegister() {
        return "register";
    }

    /**
     * description: 跳转主页
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goIndex")
    public String goIndex() {
        return "index";
    }

    /**
     * description: 跳转用户列表
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goUserList")
    public String goUserList() {
        return "admin/user-list";
    }

    /**
     * description:跳转分类列表
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goCategoryList")
    public String goCategoryList() {
        return "admin/category-list";
    }

    /**
     * description: 跳转添加分类
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goCategoryAdd")
    public String goCategoryAdd() {
        return "admin/category-add";
    }
}