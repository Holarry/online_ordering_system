package com.holary.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: Holary
 * @Date: 2023/10/3 18:20
 * @Description: 地址实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    //主键id
    private Integer id;
    //用户id
    private Integer userId;
    //收货人
    private String consignee;
    //性别
    private String gender;
    //手机号
    private String phone;
    //详细地址
    private String addressDetail;
    //默认地址
    private Integer isDefault;
    //创建时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    //修改时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    //是否删除
    private Integer isDelete;
}
