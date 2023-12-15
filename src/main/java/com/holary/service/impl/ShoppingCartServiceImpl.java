package com.holary.service.impl;

import com.holary.entity.ShoppingCart;
import com.holary.entity.User;
import com.holary.mapper.ShoppingCartMapper;
import com.holary.service.ShoppingCartService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * @Author: Holary
 * @Date: 2023/12/6 16:03
 * @Description: ShoppingCartServiceImpl
 */
@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {
    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * description: 加入购物车
     *
     * @param shoppingCart: shoppingCart对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> addShoppingCart(ShoppingCart shoppingCart) {
        HashMap<String, Object> map = new HashMap<>();

        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        shoppingCart.setUserId(userId);

        // 根据用户id和菜品id查询购物车对象
        ShoppingCart shoppingCart1 = shoppingCartMapper.selectByUserIdAndDishId(userId, shoppingCart.getDishId());
        if (shoppingCart1 == null) {
            // 填充shoppingCart属性
            shoppingCart.setNumber(1);
            shoppingCart.setCreateTime(Timestamp.valueOf(LocalDateTime.now()));
            shoppingCartMapper.insert(shoppingCart);
        } else {
            shoppingCart1.setNumber(shoppingCart1.getNumber() + 1);
            shoppingCartMapper.updateNumberById(shoppingCart1);
        }

        // 清理缓存
        String key = "shoppingCart_" + userId;
        cleanCache(key);

        ShoppingCart shoppingCart2 = shoppingCartMapper.selectByUserIdAndDishId(userId, shoppingCart.getDishId());
        map.put("code", 200);
        map.put("message", "添加购物车成功!");
        map.put("shoppingCart", shoppingCart2);
        return map;
    }

    /**
     * description: 根据用户id查询购物车
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> list() {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        // 构造key
        String key = "shoppingCart_" + userId;
        List<ShoppingCart> shoppingCartList = (List<ShoppingCart>) redisTemplate.opsForValue().get(key);
        // 如果缓存中有数据直接返回
        if (shoppingCartList != null && !shoppingCartList.isEmpty()) {
            map.put("code", 200);
            map.put("shoppingCartList", shoppingCartList);
            return map;
        }
        // 如果缓存中没有数据则查询数据库,并将数据放入缓存中
        shoppingCartList = shoppingCartMapper.selectByUserId(userId);
        redisTemplate.opsForValue().set(key, shoppingCartList, 30, TimeUnit.MINUTES);
        map.put("code", 200);
        map.put("shoppingCartList", shoppingCartList);
        return map;
    }

    /**
     * description: 根据用户id和菜品id修改购物车中的菜品数量
     *
     * @param dishId:   菜品id
     * @param quantity: 数量(1或-1)
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> updateNumber(Integer dishId, Integer quantity) {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();

        ShoppingCart shoppingCart = shoppingCartMapper.selectByUserIdAndDishId(userId, dishId);
        int number = shoppingCart.getNumber() + quantity;
        if (number < 0) {
            map.put("code", -1);
            map.put("message", "菜品数量超出范围!");
        } else if (number == 0) {
            shoppingCartMapper.deleteByUserIdAndDishId(userId, dishId);
            ShoppingCart shoppingCart1 = new ShoppingCart();
            shoppingCart1.setNumber(-1);
            map.put("code", 200);
            map.put("shoppingCart", shoppingCart1);
            map.put("message", "删除菜品成功!");
        } else {
            shoppingCart.setNumber(number);
            shoppingCartMapper.updateNumberById(shoppingCart);
            map.put("code", 200);
            map.put("shoppingCart", shoppingCart);
            map.put("message", "修改菜品数量成功!");
        }

        // 清理缓存
        String key = "shoppingCart_" + userId;
        cleanCache(key);
        return map;
    }

    /**
     * description: 计算购物车中菜品的总金额
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> calculateTotalAmount() {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        List<ShoppingCart> shoppingCartList = shoppingCartMapper.selectByUserId(userId);

        // 使用BigDecimal计算金额,保证精度不丢失
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (ShoppingCart shoppingCart : shoppingCartList) {
            int number = shoppingCart.getNumber();
            BigDecimal price = BigDecimal.valueOf(shoppingCart.getPrice());
            BigDecimal subtotal = price.multiply(BigDecimal.valueOf(number));
            totalAmount = totalAmount.add(subtotal);
        }
        map.put("code", 200);
        map.put("totalAmount", totalAmount);
        return map;
    }

    /**
     * description: 根据用户id和菜品id删除购物车中的菜品
     *
     * @param dishId: 菜品id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> deleteShoppingCartDish(Integer dishId) {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        shoppingCartMapper.deleteByUserIdAndDishId(userId, dishId);

        // 清理缓存
        String key = "shoppingCart_" + userId;
        cleanCache(key);

        map.put("code", 200);
        map.put("message", "删除菜品成功!");
        return map;
    }

    /**
     * description: 清空购物车
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> clearShoppingCart() {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        shoppingCartMapper.deleteByUserId(userId);

        // 清理缓存
        String key = "shoppingCart_" + userId;
        cleanCache(key);

        map.put("code", 200);
        map.put("message", "清空购物车成功!");
        return map;
    }

    /**
     * description: 清理缓存中的数据
     *
     * @param pattern:
     * @return: void
     */
    public void cleanCache(String pattern) {
        Set keys = redisTemplate.keys(pattern);
        redisTemplate.delete(keys);
    }
}
