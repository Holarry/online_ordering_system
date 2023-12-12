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

    /**
     * description: 根据订单号查询订单
     *
     * @param orderNumber: 订单号
     * @return: com.holary.entity.Order
     */
    Order selectByOrderNumber(String orderNumber);

    /**
     * description: 根据订单号修改订单状态
     *
     * @param orderNumber: 订单号
     * @param status:      订单状态
     * @return: void
     */
    void updateByOrderNumber(@Param("orderNumber") String orderNumber, @Param("status") int status);

    /**
     * description: 用户条件查询订单
     *
     * @param userId:      用户id
     * @param orderNumber: 订单号
     * @param status:      订单状态
     * @return: java.util.List<com.holary.entity.Order>
     */
    List<Order> selectByUserId(@Param("userId") Integer userId, @Param("orderNumber") String orderNumber, @Param("status") Integer status);
}
