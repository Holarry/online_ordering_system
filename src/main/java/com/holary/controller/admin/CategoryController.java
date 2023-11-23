package com.holary.controller.admin;

import com.holary.entity.Category;
import com.holary.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/11/22 19:54
 * @Description: CategoryController
 */
@Controller
@RequestMapping("/admin/category")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    /**
     * description: 查询分类
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list() {
        return categoryService.list();
    }

    /**
     * description: 添加分类
     *
     * @param category: category对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/save")
    @ResponseBody
    public Map<String, Object> save(@RequestBody Category category) {
        return categoryService.save(category);
    }

    /**
     * description: 根据分类id查询分类信息
     *
     * @param id:    分类id
     * @param model: model
     * @return: java.lang.String
     */
    @RequestMapping("/getDetailInfo")
    public String getDetailInfo(Integer id, Model model) {
        Category category = categoryService.getDetailInfo(id);
        model.addAttribute("category", category);
        return "/admin/category-edit";
    }

    /**
     * description: 根据分类id修改分类
     *
     * @param category: category对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody Category category) {
        return categoryService.update(category);
    }

    /**
     * description: 根据id删除分类
     *
     * @param id: 分类id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String, Object> delete(Integer id) {
        return categoryService.delete(id);
    }
}
