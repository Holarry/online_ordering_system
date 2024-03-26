package com.holary.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: Holary
 * @Date: 2024/3/26 16:26
 * @Description: CommentDto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentDto {
    //主键id
    private Integer id;
    //用户id
    private Integer userId;
    //留言内容
    private String content;
    //商家回复
    private String reply;
    //创建时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    //修改时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    //用户名
    private String username;
}
