package com.holary.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: Holary
 * @Date: 2023/10/3 18:02
 * @Description: 用户实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    //主键id
    private Integer id;
    //用户名
    private String username;
    //密码
    private String password;
    //年龄
    private Integer age;
    //性别
    private String gender;
    //手机号
    private String phone;
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
    //身份
    private Role role;
}
