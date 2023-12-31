package com.holary.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author: Holary
 * @Date: 2023/10/3 19:58
 * @Description: 购物车实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShoppingCart implements Serializable {
    //主键id
    private Integer id;
    //用户id
    private Integer userId;
    //菜品id
    private Integer dishId;
    //菜品名称
    private String dishName;
    //菜品图片
    private String dishImage;
    //数量
    private Integer number;
    //单价
    private Double price;
    //创建时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
}
