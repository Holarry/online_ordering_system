package com.holary.service.impl;

import com.holary.entity.User;
import com.holary.mapper.UserMapper;
import com.holary.service.LoginService;
import com.holary.util.BaseContext;
import com.holary.util.MD5Util;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/10/10 20:10
 * @Description: LoginServiceImpl
 */
@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private UserMapper userMapper;

    /**
     * description: shiro登录
     *
     * @param username: 用户名
     * @param password: 密码
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> selectUserByUsername(String username, String password) {
        Map<String, Object> result = new HashMap<>();
        //获取主体,代表当前用户对象
        Subject subject = SecurityUtils.getSubject();
        //判断当前用户是否已经登录
        if (!subject.isAuthenticated()) {
            UsernamePasswordToken token = new UsernamePasswordToken(username, password);
            if (username.isEmpty() || password.isEmpty()) {
                result.put("code", -1);
                result.put("message", "用户名或密码为空!");
                return result;
            }
            try {
                subject.login(token);
            } catch (UnknownAccountException e) {
                result.put("code", -1);
                result.put("message", e.getMessage());
                return result;
            } catch (IncorrectCredentialsException e) {
                result.put("code", -2);
                result.put("message", "用户名或密码错误!");
                return result;
            } catch (AuthenticationException e) {
                result.put("code", -3);
                result.put("message", "认证失败!");
                return result;
            }
        }
        //从shiro提供的session对象中获取已经认证的用户
        User user = (User) subject.getSession().getAttribute("user");
        BaseContext.setCurrentId(user.getId()); // 将当前登录用户的id存入ThreadLocal
        result.put("code", 200);
        result.put("message", username + "认证成功!");
        result.put("loginUser", user);
        return result;
    }

    /**
     * description: 用户注册
     *
     * @param username:   用户名
     * @param password:   密码
     * @param rePassword: 确认密码
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    @Transactional
    public Map<String, Object> register(String username, String password, String rePassword) {
        HashMap<String, Object> map = new HashMap<>();

        User user = userMapper.selectByUsername(username);
        if (username.isEmpty() || password.isEmpty() || rePassword.isEmpty()) {
            map.put("code", -1);
            map.put("message", "用户名或密码为空!");
        } else if (username.length() < 4 || username.length() > 10) {
            map.put("code", -2);
            map.put("message", "用户名长度错误(4-10位)!");
        } else if (password.length() < 5 || password.length() > 16) {
            map.put("code", -3);
            map.put("message", "密码长度错误(5-16位)!");
        } else if (!password.equals(rePassword)) {
            map.put("code", -4);
            map.put("message", "两次密码输入不一致!");
        } else if (user != null) {
            map.put("code", -5);
            map.put("message", "用户名" + username + "已存在!");
        } else {
            // 添加用户
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(MD5Util.md5(password, username));
            newUser.setCreateTime(Timestamp.valueOf(LocalDateTime.now()));
            newUser.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
            userMapper.insert(newUser);

            // 添加用户权限
            Integer userId = newUser.getId();
            userMapper.insertRole(userId, 2);

            map.put("code", 200);
            map.put("message", "注册成功!");
        }
        return map;
    }
}
