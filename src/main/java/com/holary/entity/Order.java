package com.holary.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
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
    // 收货人
    private String consignee;
    // 收货人手机号
    private String consigneePhone;
    //地址
    private String address;
    //金额
    private BigDecimal amount;
    //备注
    private String remark;
    //状态
    private Integer status;
    //订单时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date orderTime;
}
