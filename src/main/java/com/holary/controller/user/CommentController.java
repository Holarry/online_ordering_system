package com.holary.controller.user;

import com.holary.entity.Comment;
import com.holary.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2024/3/26 21:39
 * @Description: CommentController
 */
@Controller("userCommentController")
@RequestMapping("/user/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    /**
     * description: 用户留言
     *
     * @param comment: comment
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/addComment")
    @ResponseBody
    public Map<String, Object> addComment(@RequestBody Comment comment) {
        return commentService.addComment(comment);
    }
}
