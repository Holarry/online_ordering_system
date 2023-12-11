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
    Map<String, Object> list(int pageNum, int pageSize, String orderNumber, String consignee, Integer status);
}
