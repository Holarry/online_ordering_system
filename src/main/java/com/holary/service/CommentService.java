package com.holary.service;

import com.holary.dto.CommentDto;
import com.holary.entity.Comment;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2024/3/26 16:30
 * @Description: CommentService
 */
public interface CommentService {
    /**
     * description: 查询留言
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> list();

    /**
     * description: 根据留言id查询留言信息
     *
     * @param id: 留言id
     * @return: com.holary.dto.CommentDto
     */
    CommentDto getDetailInfo(Integer id);

    /**
     * description: 商家回复留言
     *
     * @param commentDto: commentDto
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> reply(CommentDto commentDto);

    /**
     * description: 用户留言
     *
     * @param comment: comment
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> addComment(Comment comment);
}
