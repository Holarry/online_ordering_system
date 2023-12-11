package com.holary.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @Author: Holary
 * @Date: 2023/12/10 17:16
 * @Description: OrderDetailDto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailDto {
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
    //下单用户
    private String username;
    //订单状态
    private Integer status;
    //订单时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date orderTime;
}
