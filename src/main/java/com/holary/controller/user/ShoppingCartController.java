package com.holary.controller.user;

import com.holary.entity.ShoppingCart;
import com.holary.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/12/6 15:58
 * @Description: ShoppingCartController
 */
@Controller
@RequestMapping("/user/shoppingCart")
public class ShoppingCartController {
    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * description: 加入购物车
     *
     * @param shoppingCart: shoppingCart对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/addShoppingCart")
    @ResponseBody
    public Map<String, Object> addShoppingCart(@RequestBody ShoppingCart shoppingCart) {
        return shoppingCartService.addShoppingCart(shoppingCart);
    }

    /**
     * description: 根据用户id查询购物车
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list() {
        return shoppingCartService.list();
    }

    /**
     * description: 根据用户id和菜品id修改购物车中的菜品数量
     *
     * @param dishId:   菜品id
     * @param quantity: 数量(1或-1)
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/updateNumber")
    @ResponseBody
    public Map<String, Object> updateNumber(Integer dishId, Integer quantity) {
        return shoppingCartService.updateNumber(dishId, quantity);
    }

    /**
     * description: 计算购物车中菜品的总金额
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/calculateTotalAmount")
    @ResponseBody
    public Map<String, Object> calculateTotalAmount() {
        return shoppingCartService.calculateTotalAmount();
    }

    /**
     * description: 根据用户id和菜品id删除购物车中的菜品
     *
     * @param dishId: 菜品id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/deleteShoppingCartDish")
    @ResponseBody
    public Map<String, Object> deleteShoppingCartDish(Integer dishId) {
        return shoppingCartService.deleteShoppingCartDish(dishId);
    }

    /**
     * description: 清空购物车
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/clearShoppingCart")
    @ResponseBody
    public Map<String, Object> clearShoppingCart() {
        return shoppingCartService.clearShoppingCart();
    }
}
