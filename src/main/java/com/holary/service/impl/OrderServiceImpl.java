package com.holary.service.impl;

import com.holary.entity.Order;
import com.holary.entity.OrderDetail;
import com.holary.entity.ShoppingCart;
import com.holary.entity.User;
import com.holary.mapper.OrderDetailMapper;
import com.holary.mapper.OrderMapper;
import com.holary.mapper.ShoppingCartMapper;
import com.holary.service.OrderService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Author: Holary
 * @Date: 2023/12/9 14:47
 * @Description: OrderServiceImpl
 */
@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderDetailMapper orderDetailMapper;

    /**
     * description: 提交订单
     *
     * @param order: order对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Transactional
    @Override
    public Map<String, Object> submitOrder(Order order) {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        List<ShoppingCart> shoppingCartList = shoppingCartMapper.selectByUserId(userId);

        // 校验参数是否异常
        if (shoppingCartList == null || shoppingCartList.isEmpty()) {
            map.put("code", -1);
            map.put("message", "购物车为空,不能提交订单!");
            return map;
        }
        if (order.getConsignee().isEmpty()) {
            map.put("code", -2);
            map.put("message", "收货人为空!");
            return map;
        }
        if (order.getConsigneePhone().isEmpty()) {
            map.put("code", -3);
            map.put("message", "手机号为空!");
            return map;
        }
        if (order.getAddress().isEmpty()) {
            map.put("code", -4);
            map.put("message", "收货地址为空!");
            return map;
        }

        // 定义手机号的正则表达式
        String regex = "^(1[3-9]\\d{9})$";
        // 编译正则表达式
        Pattern pattern = Pattern.compile(regex);
        // 创建匹配器
        Matcher matcher = pattern.matcher(order.getConsigneePhone());
        // 进行匹配并返回结果
        if (!matcher.matches()) {
            map.put("code", -5);
            map.put("message", "手机号格式错误!");
            return map;
        }

        // 补充order属性
        // 订单号
        long orderNumber = System.currentTimeMillis();
        order.setOrderNumber(String.valueOf(orderNumber));
        // 用户id
        order.setUserId(userId);
        // 备注
        if (order.getRemark().isEmpty()) {
            order.setRemark("无");
        }
        // 订单状态(1为已下单, 2为派送中, 3为已完成)
        order.setStatus(1);
        // 订单时间
        order.setOrderTime(Timestamp.valueOf(LocalDateTime.now()));
        // 向订单表插入数据
        orderMapper.insertOrder(order);

        List<OrderDetail> orderDetailList = new ArrayList<>();
        for (ShoppingCart shoppingCart : shoppingCartList) {
            Integer dishId = shoppingCart.getDishId();
            String dishName = shoppingCart.getDishName();
            String dishImage = shoppingCart.getDishImage();
            Double dishPrice = shoppingCart.getPrice();
            Integer number = shoppingCart.getNumber();

            // 计算菜品金额
            BigDecimal amount;
            BigDecimal price = BigDecimal.valueOf(dishPrice);
            amount = price.multiply(BigDecimal.valueOf(number));

            // 补充orderDetail属性
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrderNumber(String.valueOf(orderNumber));
            orderDetail.setDishId(dishId);
            orderDetail.setDishName(dishName);
            orderDetail.setDishImage(dishImage);
            orderDetail.setDishPrice(price);
            orderDetail.setNumber(number);
            orderDetail.setAmount(amount);

            orderDetailList.add(orderDetail);
        }
        // 向订单明细表插入数据
        orderDetailMapper.insertBatch(orderDetailList);

        // 清空购物车
        shoppingCartMapper.deleteByUserId(userId);

        map.put("code", 200);
        map.put("message", "提交订单成功!");
        return map;
    }
}
