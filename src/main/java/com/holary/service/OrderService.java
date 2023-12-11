package com.holary.service;

import com.holary.dto.OrderDetailDto;
import com.holary.entity.Order;

import java.util.List;
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

    /**
     * description: 根据订单号查询订单详情
     *
     * @param orderNumber: 订单号
     * @return: java.util.List<com.holary.dto.OrderDetailDto>
     */
    List<OrderDetailDto> getOrderDetail(String orderNumber);

    /**
     * description: 根据订单号修改订单状态
     *
     * @param orderNumber: 订单号
     * @param status:      订单状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> updateOrderStatus(String orderNumber, Integer status);
}
