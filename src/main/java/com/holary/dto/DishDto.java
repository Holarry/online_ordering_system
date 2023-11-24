package com.holary.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: Holary
 * @Date: 2023/11/24 15:32
 * @Description: DishDto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DishDto {
    //主键id
    private Integer id;
    //菜品名称
    private String name;
    //分类id
    private Integer categoryId;
    //菜品价格
    private Double price;
    //菜品图片
    private String image;
    //菜品描述
    private String Description;
    //状态
    private Integer status;
    //创建时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    //修改时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    //是否删除
    private Integer isDelete;
    // 菜品名称
    private String categoryName;
}
