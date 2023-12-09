package com.holary.mapper;

import com.holary.entity.Order;

/**
 * @Author: Holary
 * @Date: 2023/12/9 14:47
 * @Description: OrderMapper
 */
public interface OrderMapper {
    /**
     * description: 提交订单
     *
     * @param order: order对象
     * @return: void
     */
    void insertOrder(Order order);
}
