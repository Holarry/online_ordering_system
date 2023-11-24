package com.holary.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.holary.entity.User;
import com.holary.mapper.UserMapper;
import com.holary.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
                map.put("message", "年龄超出范围(0-120)!");
                return map;
            }
        }

        // 查询该用户在数据库中的年龄是否为空, 如果不为空则修改时不能为空
        User user1 = userMapper.selectById(user.getId());
        if (user1.getAge() != null) {
            if (user.getAge() == null) {
                map.put("code", -2);
                map.put("message", "年龄不能为空!");
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
                map.put("message", "手机号格式错误!");
                return map;
            }
        }

        // 查询该用户在数据库中的手机号是否为空, 如果不为空则修改时不能为空
        if (user1.getPhone() != null) {
            if (user.getPhone().isEmpty()) {
                map.put("code", -4);
                map.put("message", "手机号不能为空!");
                return map;
            }
        }

        userMapper.updateById(user);
        map.put("code", 200);
        map.put("message", "修改用户成功!");
        return map;
    }

    /**
     * description: 根据用户id删除用户
     *
     * @param id: 用户id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> delete(Integer id) {
        HashMap<String, Object> map = new HashMap<>();
        int i = userMapper.deleteById(id);
        if (i > 0) {
            map.put("code", 200);
            map.put("message", "删除用户成功!");
        } else {
            map.put("code", -1);
            map.put("message", "删除用户失败!");
        }
        return map;
    }
}
