package com.holary.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: Holary
 * @Date: 2023/10/3 18:16
 * @Description: 分类实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category {
    //主键id
    private Integer id;
    //分类名称
    private String name;
    //排序
    private Integer sort;
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
}
