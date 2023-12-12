package com.holary.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.holary.dto.OrderDetailDto;
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

    /**
     * description: 订单分页查询和条件查询
     *
     * @param pageNum:     页码
     * @param pageSize:    条数
     * @param orderNumber: 订单号
     * @param consignee:   收货人
     * @param status:      状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> list(int pageNum, int pageSize, String orderNumber, String consignee, Integer status) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orderList = orderMapper.list(orderNumber, consignee, status);
        PageInfo<Order> orderPageInfo = new PageInfo<>(orderList);

        HashMap<String, Object> map = new HashMap<>();
        map.put("code", 200);
        map.put("paging", orderPageInfo);
        return map;
    }

    /**
     * description: 根据订单号查询订单详情
     *
     * @param orderNumber: 订单号
     * @return: java.util.List<com.holary.dto.OrderDetailDto>
     */
    @Override
    public List<OrderDetailDto> getOrderDetail(String orderNumber) {
        return orderDetailMapper.selectByOrderNumber(orderNumber);
    }

    /**
     * description: 根据订单号修改订单状态
     *
     * @param orderNumber: 订单号
     * @param status:      订单状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> updateOrderStatus(String orderNumber, Integer status) {
        HashMap<String, Object> map = new HashMap<>();
        // 判断订单号是否存在
        Order order = orderMapper.selectByOrderNumber(orderNumber);
        if (order == null) {
            map.put("code", -1);
            map.put("message", "订单号不存在!");
            return map;
        }
        // 修改订单状态
        if (status == 1) {
            // 派送订单
            orderMapper.updateByOrderNumber(orderNumber, 2);
            map.put("code", 200);
            map.put("message", "订单派送中!");
        } else if (status == 3) {
            // 完成订单
            orderMapper.updateByOrderNumber(orderNumber, 4);
            map.put("code", 200);
            map.put("message", "订单已完成!");
        } else {
            map.put("code", -2);
            map.put("message", "订单状态错误!");
        }
        return map;
    }

    /**
     * description: 用户条件查询订单
     *
     * @param orderNumber: 订单号
     * @param status:      订单状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> list1(String orderNumber, Integer status) {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        List<Order> orderList = orderMapper.selectByUserId(userId, orderNumber, status);
        map.put("code", 200);
        map.put("orderList", orderList);
        return map;
    }

    /**
     * description: 用户查询订单详情
     *
     * @param orderNumber: 订单号
     * @return: java.util.List<com.holary.dto.OrderDetailDto>
     */
    @Override
    public List<OrderDetailDto> getOrderDetailByUserId(String orderNumber) {
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        return orderDetailMapper.selectByUserIdAndOrderNumber(userId, orderNumber);
    }

    /**
     * description: 用户修改订单状态(取消订单, 确认订单)
     *
     * @param orderNumber: 订单号
     * @param status:      订单状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> updateOrderStatusByUserId(String orderNumber, Integer status) {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();
        List<Order> orderList = orderMapper.selectByUserId(userId, orderNumber, status);
        // 判断订单是否存在
        if (orderList == null || orderList.isEmpty()) {
            map.put("code", -1);
            map.put("message", "订单号不存在!");
            return map;
        }
        // 修改订单状态
        if (status == 1) {
            // 取消订单
            orderMapper.updateByOrderNumber(orderNumber, 0);
            map.put("code", 200);
            map.put("message", "取消订单成功!");
        } else if (status == 2) {
            // 确认订单
            orderMapper.updateByOrderNumber(orderNumber, 3);
            map.put("code", 200);
            map.put("message", "确认订单成功!");
        } else {
            map.put("code", -2);
            map.put("message", "订单状态错误!");
        }
        return map;
    }
}
