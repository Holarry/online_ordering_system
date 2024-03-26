package com.holary.mapper;

import com.holary.dto.CommentDto;
import com.holary.entity.Comment;

import java.util.List;

/**
 * @Author: Holary
 * @Date: 2024/3/26 16:39
 * @Description: CommentMapper
 */
public interface CommentMapper {
    /**
     * description: 查询留言
     *
     * @return: java.util.List<com.holary.dto.CommentDto>
     */
    List<CommentDto> selectAll();

    /**
     * description: 根据留言id查询留言信息
     *
     * @param id: 留言id
     * @return: com.holary.dto.CommentDto
     */
    CommentDto selectById(Integer id);

    /**
     * description: 根据留言id回复留言
     *
     * @param commentDto: commentDto
     * @return: void
     */
    void updateById(CommentDto commentDto);

    /**
     * description: 用户留言
     *
     * @param comment: comment
     * @return: void
     */
    void insert(Comment comment);
}
