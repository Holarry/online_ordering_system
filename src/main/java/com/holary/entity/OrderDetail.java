package com.holary.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * @Author: Holary
 * @Date: 2023/10/3 19:49
 * @Description: 订单详情实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail {
    //主键id
    private Integer id;
    //订单id
    private String orderNumber;
    //菜品id
    private Integer dishId;
    //菜品名称
    private String dishName;
    //菜品图片
    private String dishImage;
    //菜品价格
    private BigDecimal dishPrice;
    //数量
    private Integer number;
    //金额
    private BigDecimal amount;
}
