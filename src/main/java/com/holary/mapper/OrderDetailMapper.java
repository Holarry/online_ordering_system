package com.holary.mapper;

import com.holary.dto.OrderDetailDto;
import com.holary.entity.OrderDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Holary
 * @Date: 2023/12/9 15:36
 * @Description: OrderDetailMapper
 */
public interface OrderDetailMapper {
    /**
     * description: 向订单详细表批量插入数据
     *
     * @param orderDetailList: 订单明细集合
     * @return: void
     */
    void insertBatch(@Param("orderDetailList") List<OrderDetail> orderDetailList);

    /**
     * description: 根据订单号查询订单详情
     *
     * @param orderNumber: 订单号
     * @return: java.util.List<com.holary.dto.OrderDetailDto>
     */
    List<OrderDetailDto> selectByOrderNumber(String orderNumber);

    /**
     * description: 根据用户id和订单号查询订单详情
     *
     * @param userId:      用户id
     * @param orderNumber: 订单号
     * @return: java.util.List<com.holary.dto.OrderDetailDto>
     */
    List<OrderDetailDto> selectByUserIdAndOrderNumber(@Param("userId") Integer userId, @Param("orderNumber") String orderNumber);
}
