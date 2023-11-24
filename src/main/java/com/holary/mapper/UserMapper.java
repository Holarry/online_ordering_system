package com.holary.mapper;

import com.holary.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Holary
 * @Date: 2023/11/20 17:18
 * @Description: UserMapper
 */
public interface UserMapper {
    /**
     * description: 条件查询用户
     *
     * @param username: 用户名
     * @return: java.util.List<com.com.holary.entity.User>
     */
    List<User> selectAll(@Param("username") String username, @Param("gender") String gender, @Param("status") Integer status);

    /**
     * description: 根据用户名查询用户
     *
     * @param username: 用户名
     * @return: com.com.holary.entity.User
     */
    User selectByUsername(String username);

    /**
     * description: 根据用户id查询用户信息
     *
     * @param id: 用户id
     * @return: com.com.holary.entity.User
     */
    User selectById(Integer id);

    /**
     * description: 根据用户id修改用户信息
     *
     * @param user: user对象
     * @return: void
     */
    void updateById(User user);

    /**
     * description: 根据用户id删除用户
     *
     * @param id: 用户id
     * @return: int
     */
    int deleteById(Integer id);

    /**
     * description: 添加用户
     *
     * @param user: user对象
     * @return: void
     */
    void insert(User user);

    /**
     * description: 添加用户权限
     *
     * @param userId: 用户id
     * @param roleId: 2(代表普通用户)
     * @return: void
     */
    void insertRole(@Param("userId") Integer userId, @Param("roleId") int roleId);
}
