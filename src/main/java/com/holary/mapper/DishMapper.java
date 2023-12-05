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

    /**
     * description: 根据菜品id查询菜品
     *
     * @param id: 菜品id
     * @return: com.holary.entity.Dish
     */
    Dish selectById(Integer id);

    /**
     * description: 根据菜品id和菜品名称查询菜品
     *
     * @param id:   菜品id
     * @param name: 菜品名称
     * @return: com.holary.entity.Dish
     */
    Dish selectByIdAndName(@Param("id") Integer id, @Param("name") String name);

    /**
     * description: 根据菜品id修改菜品
     *
     * @param dish: dish对象
     * @return: void
     */
    void updateById(Dish dish);

    /**
     * 根据菜品id删除菜品
     *
     * @return: int
     */
    int deleteById(Integer id);

    /**
     * description: 根据菜品名称和菜品分类查询菜品
     *
     * @param name:       菜品名称
     * @param categoryId: 菜品分类
     * @return: java.util.List<com.holary.dto.DishDto>
     */
    List<DishDto> selectAll1(@Param("name") String name, @Param("categoryId") Integer categoryId);
}
