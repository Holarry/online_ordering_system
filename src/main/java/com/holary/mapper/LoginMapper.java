package com.holary.mapper;

import com.holary.entity.User;

/**
 * @Author: Holary
 * @Date: 2023/10/3 23:03
 * @Description: LoginMapper
 */
public interface LoginMapper {
    User selectUserByUsername(String username);
}
