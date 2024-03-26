package com.holary.service.impl;

import com.holary.dto.CommentDto;
import com.holary.entity.Comment;
import com.holary.entity.User;
import com.holary.mapper.CommentMapper;
import com.holary.service.CommentService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2024/3/26 16:30
 * @Description: CommentServiceImpl
 */
@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentMapper commentMapper;

    /**
     * description: 查询留言
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> list() {
        HashMap<String, Object> map = new HashMap<>();

        List<CommentDto> commentList = commentMapper.selectAll();
        map.put("code", 200);
        map.put("list", commentList);
        return map;
    }

    /**
     * description: 根据留言id查询留言信息
     *
     * @param id: 留言id
     * @return: com.holary.dto.CommentDto
     */
    @Override
    public CommentDto getDetailInfo(Integer id) {
        return commentMapper.selectById(id);
    }

    /**
     * description: 商家回复留言
     *
     * @param commentDto: commentDto
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> reply(CommentDto commentDto) {
        HashMap<String, Object> map = new HashMap<>();

        if (commentDto.getReply().isEmpty()) {
            map.put("code", -1);
            map.put("message", "回复内容为空");
            return map;
        }

        commentDto.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
        commentMapper.updateById(commentDto);
        map.put("code", 200);
        map.put("message", "回复留言成功");
        return map;
    }

    /**
     * description: 用户留言
     *
     * @param comment: comment
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> addComment(Comment comment) {
        HashMap<String, Object> map = new HashMap<>();
        // 获取当前用户id
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer userId = user.getId();

        if (comment.getContent().isEmpty()) {
            map.put("code", -1);
            map.put("message", "留言内容为空");
            return map;
        }

        //填充字段
        comment.setUserId(userId);
        comment.setCreateTime(Timestamp.valueOf(LocalDateTime.now()));
        comment.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));

        commentMapper.insert(comment);
        map.put("code", 200);
        map.put("message", "留言成功");
        return map;
    }
}
