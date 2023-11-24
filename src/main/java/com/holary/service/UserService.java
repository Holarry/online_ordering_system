package com.holary.service;

import com.holary.entity.User;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/11/20 17:17
 * @Description: UserService
 */
public interface UserService {
    /**
     * description: 分页查询和条件查询用户
     *
     * @param pageNum:  页码
     * @param pageSize: 条数
     * @param username: 用户名
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> list(int pageNum, int pageSize, String username, String gender, Integer status);

    /**
     * description: 根据用户id查询用户信息
     *
     * @param id: 用户id
     * @return: com.com.holary.entity.User
     */
    User getDetailInfo(Integer id);

    /**
     * description: 根据用户id修改用户信息
     *
     * @param user: user对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> update(User user);

    /**
     * description: 根据用户id删除用户
     *
     * @param id: 用户id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> delete(Integer id);
}
