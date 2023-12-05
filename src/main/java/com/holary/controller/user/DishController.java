package com.holary.controller.user;

import com.holary.service.DishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/12/5 16:39
 * @Description: DishController
 */
@Controller("userDishController")
@RequestMapping("/user/dish")
public class DishController {
    @Autowired
    private DishService dishService;

    /**
     * description: 用户端菜品分页查询和条件查询
     *
     * @param name:       菜品名称
     * @param categoryId: 菜品分类
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list(String name, Integer categoryId) {
        return dishService.list1(name, categoryId);
    }
}
