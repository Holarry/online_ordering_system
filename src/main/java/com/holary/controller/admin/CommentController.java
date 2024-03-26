package com.holary.controller.admin;

import com.holary.dto.CommentDto;
import com.holary.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2024/3/26 16:28
 * @Description: CommentController
 */
@Controller("adminCommentController")
@RequestMapping("/admin/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    /**
     * description: 查询留言
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @GetMapping("/list")
    @ResponseBody
    public Map<String, Object> list() {
        return commentService.list();
    }

    /**
     * description: 根据留言id查询留言信息
     *
     * @param id:    留言id
     * @param model: model
     * @return: java.lang.String
     */
    @GetMapping("/getDetailInfo")
    public String getDetailInfo(Integer id, Model model) {
        CommentDto comment = commentService.getDetailInfo(id);
        model.addAttribute("comment", comment);
        return "/admin/comment-reply";
    }

    /**
     * description: 商家回复留言
     *
     * @param commentDto: commentDto
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PutMapping("reply")
    @ResponseBody
    public Map<String, Object> reply(@RequestBody CommentDto commentDto) {
        return commentService.reply(commentDto);
    }
}
