package com.holary.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: Holary
 * @Date: 2023/10/3 18:09
 * @Description: 角色实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Role {
    //主键id
    private Integer id;
    //角色
    private String role;
}
