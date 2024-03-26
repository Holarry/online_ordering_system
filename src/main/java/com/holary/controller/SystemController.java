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

    /**
     * description: 跳转菜品列表
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goDishList")
    public String goDishList() {
        return "admin/dish-list";
    }

    /**
     * description: 跳转添加菜品
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goDishAdd")
    public String goDishAdd() {
        return "admin/dish-add";
    }

    /**
     * description: 跳转订单列表
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goOrderList")
    public String goOrderList() {
        return "admin/order-list";
    }

    /**
     * description: 跳转订单详情
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goOrderDetail")
    public String goOrderDetail() {
        return "admin/orderDetail";
    }

    /**
     * description: 跳转留言管理
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goCommentList")
    public String goCommentList() {
        return "admin/comment-list";
    }

    /**
     * description: 跳转菜单列表
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goUserDishList")
    public String goUserDishList() {
        return "user/dish-list";
    }

    /**
     * description: 跳转购物车列表
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goShoppingCartList")
    public String goShoppingCartList() {
        return "user/shoppingCart-list";
    }

    /**
     * description: 跳转提交订单页面
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goSubmitOrder")
    public String goSubmitOrder() {
        return "user/submit-order";
    }

    /**
     * description: 跳转我的订单列表
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goUserOrderList")
    public String goUserOrderList() {
        return "user/order-list";
    }

    /**
     * description: 跳转留言广场
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goUserCommentList")
    public String goUserCommentList() {
        return "user/comment-list";
    }

    /**
     * description: 跳转添加留言
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goCommentAdd")
    public String goCommentAdd() {
        return "user/comment-add";
    }

    /**
     * description: 跳转修改密码页面
     *
     * @return: java.lang.String
     */
    @RequestMapping("/goUpdatePassword")
    public String goUpdatePassword() {
        return "user/updatePassword";
    }
}
