package com.holary.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: Holary
 * @Date: 2023/10/3 18:23
 * @Description: 订单实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    //主键id
    private Integer id;
    //订单号
    private String orderNumber;
    //用户id
    private Integer userId;
    //地址id
    private Integer addressId;
    //订单时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date orderTime;
    //金额
    private Double amount;
    //状态
    private Integer status;
}
