package com.holary.controller.admin;

import com.holary.entity.User;
import com.holary.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/11/20 15:40
 * @Description: UserController
 */
@Controller("adminUserController")
@RequestMapping("/admin/user")
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * description: 分页查询和条件查询用户
     *
     * @param pageNum:  页码
     * @param pageSize: 条数
     * @param username: 用户名
     * @param gender:   性别
     * @param status:   状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @GetMapping("/list")
    @ResponseBody
    public Map<String, Object> list(int pageNum, int pageSize, String username, String gender, Integer status) {
        return userService.list(pageNum, pageSize, username, gender, status);
    }

    /**
     * description: 根据用户id查询用户信息
     *
     * @param id:    用户id
     * @param model: Model
     * @return: java.lang.String
     */
    @GetMapping("/getDetailInfo")
    public String getDetailInfo(Integer id, Model model) {
        User user = userService.getDetailInfo(id);
        model.addAttribute("user", user);
        return "admin/user-edit";
    }

    /**
     * description: 根据用户id修改用户信息
     *
     * @param user: user对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PutMapping("/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody User user) {
        return userService.update(user);
    }

    /**
     * description: 根据用户id删除用户
     *
     * @param id: 用户id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @DeleteMapping("/delete")
    @ResponseBody
    public Map<String, Object> delete(Integer id) {
        return userService.delete(id);
    }
}
