package com.holary.mapper;

import com.holary.entity.ShoppingCart;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Holary
 * @Date: 2023/12/6 16:04
 * @Description: ShoppingCartMapper
 */
public interface ShoppingCartMapper {
    /**
     * description: 根据用户id和菜品id查询购物车
     *
     * @param userId: 用户id
     * @param dishId: 菜品id
     * @return: com.holary.entity.ShoppingCart
     */
    ShoppingCart selectByUserIdAndDishId(@Param("userId") Integer userId, @Param("dishId") Integer dishId);

    /**
     * description: 添加购物车
     *
     * @param shoppingCart: shoppingCart对象
     * @return: void
     */
    void insert(ShoppingCart shoppingCart);

    /**
     * description: 根据id修改购物车菜品数量
     *
     * @param shoppingCart: shoppingCart对象
     * @return: void
     */
    void updateNumberById(ShoppingCart shoppingCart);

    /**
     * description: 根据用户id查询购物车
     *
     * @param userId: 用户id
     * @return: java.util.List<com.holary.entity.ShoppingCart>
     */
    List<ShoppingCart> selectByUserId(Integer userId);

    /**
     * description: 根据用户id和菜品id删除购物车中的菜品
     *
     * @param userId: 用户id
     * @param dishId: 菜品id
     * @return: void
     */
    void deleteByUserIdAndDishId(@Param("userId") Integer userId, @Param("dishId") Integer dishId);
}
