package com.holary.mapper;

import com.holary.entity.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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

    /**
     * description: 订单条件查询
     *
     * @param orderNumber: 订单号
     * @param consignee:   收货人
     * @param status:      状态
     * @return: java.util.List<com.holary.entity.Order>
     */
    List<Order> list(@Param("orderNumber") String orderNumber, @Param("consignee") String consignee, @Param("status") Integer status);
}
