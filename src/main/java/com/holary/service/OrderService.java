package com.holary.service;

import com.holary.entity.Order;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/12/9 14:47
 * @Description: OrderService
 */
public interface OrderService {
    /**
     * description: 提交订单
     *
     * @param order: order对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> submitOrder(Order order);
}
