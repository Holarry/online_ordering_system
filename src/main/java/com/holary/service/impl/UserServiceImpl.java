package com.holary.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.holary.entity.User;
import com.holary.mapper.UserMapper;
import com.holary.service.UserService;
import com.holary.util.MD5Util;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Author: Holary
 * @Date: 2023/11/20 17:17
 * @Description: UserServiceImpl
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

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
    @Override
    public Map<String, Object> list(int pageNum, int pageSize, String username, String gender, Integer status) {
        // 开启分页插件
        PageHelper.startPage(pageNum, pageSize);
        List<User> userList = userMapper.selectAll(username, gender, status);
        PageInfo<User> userPageInfo = new PageInfo<>(userList);

        HashMap<String, Object> userMap = new HashMap<>();
        userMap.put("code", 200);
        userMap.put("paging", userPageInfo);
        return userMap;
    }

    /**
     * description: 根据用户id查询用户信息
     *
     * @param id: 用户id
     * @return: com.com.holary.entity.User
     */
    @Override
    public User getDetailInfo(Integer id) {
        return userMapper.selectById(id);
    }

    /**
     * description: 根据用户id修改用户信息
     *
     * @param user: user对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> update(User user) {
        // 填充更新时间
        user.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));

        HashMap<String, Object> map = new HashMap<>();

        // 判断年龄是否合法
        if (user.getAge() != null) {
            if (user.getAge() < 0 || user.getAge() > 120) {
                map.put("code", -1);
                map.put("message", "年龄超出范围(0-120)");
                return map;
            }
        }

        // 查询该用户在数据库中的年龄是否为空, 如果不为空则修改时不能为空
        User user1 = userMapper.selectById(user.getId());
        if (user1.getAge() != null) {
            if (user.getAge() == null) {
                map.put("code", -2);
                map.put("message", "年龄不能为空");
                return map;
            }
        }

        // 判断手机号是否合法
        if (!user.getPhone().isEmpty()) {
            // 定义手机号的正则表达式
            String regex = "^(1[3-9]\\d{9})$";
            // 编译正则表达式
            Pattern pattern = Pattern.compile(regex);
            // 创建匹配器
            Matcher matcher = pattern.matcher(user.getPhone());
            // 进行匹配并返回结果
            if (!matcher.matches()) {
                map.put("code", -3);
                map.put("message", "手机号格式错误");
                return map;
            }
        }

        // 查询该用户在数据库中的手机号是否为空, 如果不为空则修改时不能为空
        if (user1.getPhone() != null) {
            if (user.getPhone().isEmpty()) {
                map.put("code", -4);
                map.put("message", "手机号不能为空");
                return map;
            }
        }

        userMapper.updateById(user);
        map.put("code", 200);
        map.put("message", "修改用户成功");
        return map;
    }

    /**
     * description: 根据用户id删除用户
     *
     * @param id: 用户id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Transactional
    @Override
    public Map<String, Object> delete(Integer id) {
        HashMap<String, Object> map = new HashMap<>();
        // 删除用户
        int i = userMapper.deleteById(id);
        // 删除用户权限关系记录
        Integer userRoleId = userMapper.selectUserRoleId(id);
        int j = userMapper.deleteByUserRoleId(userRoleId);
        if (i > 0 && j > 0) {
            map.put("code", 200);
            map.put("message", "删除用户成功");
        } else {
            map.put("code", -1);
            map.put("message", "删除用户失败");
        }
        return map;
    }

    /**
     * description: 用户修改个人基本信息
     *
     * @param user: user对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> updatePersonalInfo(User user) {
        HashMap<String, Object> map = new HashMap<>();

        // 查询用户名是否存在
        User user1 = userMapper.selectByUserIdAndUsername(user.getId(), user.getUsername());

        if (user.getPhone().isEmpty()) {
            map.put("code", -1);
            map.put("message", "手机号码为空");
            return map;
        }

        // 定义手机号的正则表达式
        String regex = "^(1[3-9]\\d{9})$";
        // 编译正则表达式
        Pattern pattern = Pattern.compile(regex);
        // 创建匹配器
        Matcher matcher = pattern.matcher(user.getPhone());

        if (user.getUsername().isEmpty()) {
            map.put("code", -1);
            map.put("message", "用户名为空");
        } else if (user.getUsername().length() < 4 || user.getUsername().length() > 10) {
            map.put("code", -1);
            map.put("message", "用户名长度错误(4-10位)");
        } else if (user.getAge() == null) {
            map.put("code", -1);
            map.put("message", "用户年龄为空");
        } else if (user.getGender().isEmpty()) {
            map.put("code", -1);
            map.put("message", "用户性别为空");
        } else if (user.getAge() < 0 || user.getAge() > 120) {
            map.put("code", -2);
            map.put("message", "年龄超出范围(0-120)");
        } else if (!matcher.matches()) {
            map.put("code", -2);
            map.put("message", "手机号格式错误");
        } else if (user1 != null) {
            map.put("code", -2);
            map.put("message", "用户名" + user.getUsername() + "已存在");
        } else {
            // 填充更新时间
            user.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
            userMapper.updateById(user);
            map.put("code", 200);
            map.put("message", "修改个人信息成功");
        }
        return map;
    }

    /**
     * description: 用户修改密码
     *
     * @param oldPassword: 旧密码
     * @param newPassword: 新密码
     * @param rePassword:  确认密码
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> updatePassword(String oldPassword, String newPassword, String rePassword) {
        HashMap<String, Object> map = new HashMap<>();

        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        User user1 = userMapper.selectById(userId);
        String oldPassword1 = user1.getPassword();

        String oldPassword2 = MD5Util.md5(oldPassword, user1.getUsername());
        String newPassword1 = MD5Util.md5(newPassword, user1.getUsername());

        if (oldPassword.isEmpty()) {
            map.put("code", -1);
            map.put("message", "原密码为空");
        } else if (newPassword.isEmpty()) {
            map.put("code", -1);
            map.put("message", "新密码为空");
        } else if (rePassword.isEmpty()) {
            map.put("code", -1);
            map.put("message", "确认密码为空");
        } else if (newPassword.length() < 5 || newPassword.length() > 16) {
            map.put("code", -1);
            map.put("message", "新密码长度错误(5-16位)");
        } else if (!newPassword.equals(rePassword)) {
            map.put("code", -1);
            map.put("message", "两次密码输入不一致");
        } else if (!oldPassword2.equals(oldPassword1)) {
            map.put("code", -2);
            map.put("message", "旧密码错误");
        } else {
            // 构造user对象
            User user2 = new User();
            user2.setId(userId);
            user2.setPassword(newPassword1);
            user2.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
            userMapper.updateById(user2);

            map.put("code", 200);
            map.put("message", "修改密码成功");
        }
        return map;
    }
}
