package com.holary.mapper;

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
}
