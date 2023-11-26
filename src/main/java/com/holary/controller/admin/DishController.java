package com.holary.controller.admin;

import com.holary.entity.Dish;
import com.holary.service.DishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/11/24 15:36
 * @Description: DishController
 */
@RequestMapping("/admin/dish")
@Controller
public class DishController {
    @Autowired
    private DishService dishService;

    /**
     * description: 分页查询和条件查询菜品
     *
     * @param pageNum:    页码
     * @param pageSize:   条数
     * @param name:       菜品名称
     * @param categoryId: 分类id
     * @param status:     状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list(int pageNum, int pageSize, String name, Integer categoryId, Integer status) {
        return dishService.list(pageNum, pageSize, name, categoryId, status);
    }

    /**
     * description: 添加菜品
     *
     * @param dish: dish对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/save")
    @ResponseBody
    public Map<String, Object> save(@RequestBody Dish dish) {
        return dishService.save(dish);
    }
}
