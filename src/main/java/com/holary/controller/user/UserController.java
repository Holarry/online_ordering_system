package com.holary.controller.user;

import com.holary.entity.User;
import com.holary.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/12/14 22:23
 * @Description: UserController
 */
@Controller("userUserController")
@RequestMapping("user/user")
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * description: 根据用户id查询个人信息
     *
     * @param model: Model
     * @return: java.lang.String
     */
    @GetMapping("/getDetailInfo")
    public String getDetailInfo(Model model) {
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        User userInfo = userService.getDetailInfo(userId);
        model.addAttribute("user", userInfo);
        return "user/personal-center";
    }

    /**
     * description: 用户修改个人基本信息
     *
     * @param user: user对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PutMapping("/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody User user) {
        return userService.updatePersonalInfo(user);
    }

    /**
     * description: 用户修改密码
     *
     * @param requestBody: requestBody
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PutMapping("/updatePassword")
    @ResponseBody
    public Map<String, Object> updatePassword(@RequestBody Map<String, Object> requestBody) {
        String oldPassword = String.valueOf(requestBody.get("oldPassword")); // 旧密码
        String newPassword = String.valueOf(requestBody.get("newPassword")); // 新密码
        String rePassword = String.valueOf(requestBody.get("rePassword")); // 确认密码
        return userService.updatePassword(oldPassword, newPassword, rePassword);
    }
}
