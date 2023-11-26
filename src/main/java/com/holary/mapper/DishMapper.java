package com.holary.mapper;

import com.holary.dto.DishDto;
import com.holary.entity.Dish;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Holary
 * @Date: 2023/11/24 15:38
 * @Description: DishMapper
 */
public interface DishMapper {
    /**
     * description: 分页查询和条件查询菜品
     *
     * @param name:       菜品名称
     * @param categoryId: 分类id
     * @param status:     状态
     * @return: java.util.List<com.holary.dto.DishDto>
     */
    List<DishDto> selectAll(@Param("name") String name, @Param("categoryId") Integer categoryId, @Param("status") Integer status);

    /**
     * description: 根据菜品名称查询菜品
     *
     * @param name: 菜品名称
     * @return: com.holary.entity.Dish
     */
    Dish selectByName(String name);

    /**
     * description: 添加菜品
     *
     * @param dish: dish对象
     * @return: void
     */
    void insert(Dish dish);
}
