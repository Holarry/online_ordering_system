package com.holary.service;

import com.holary.entity.Dish;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/11/24 15:37
 * @Description: DishService
 */
public interface DishService {
    /**
     * description: 分页查询和条件查询菜品
     *
     * @param pageNum:    页码
     * @param pageSize:   条数
     * @param name:       菜品名称
     * @param categoryId: 分类id
     * @param status:     状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> list(int pageNum, int pageSize, String name, Integer categoryId, Integer status);

    /**
     * description: 添加菜品
     *
     * @param dish: dish对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> save(Dish dish);
}
