package com.holary.service;

import com.holary.entity.ShoppingCart;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/12/6 16:03
 * @Description: ShoppingCartService
 */
public interface ShoppingCartService {
    /**
     * description: 加入购物车
     *
     * @param shoppingCart: shoppingCart对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> addShoppingCart(ShoppingCart shoppingCart);

    /**
     * description: 根据用户id查询购物车
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> list();

    /**
     * description: 根据用户id和菜品id修改购物车中的菜品数量
     *
     * @param dishId:   菜品id
     * @param quantity: 数量(1或-1)
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> updateNumber(Integer dishId, Integer quantity);
}
