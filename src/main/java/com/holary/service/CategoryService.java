package com.holary.service;

import com.holary.entity.Category;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/11/22 19:55
 * @Description: CategoryService
 */
public interface CategoryService {
    /**
     * description: 查询分类
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> list();

    /**
     * description: 添加分类
     *
     * @param category: category对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> save(Category category);

    /**
     * description: 根据分类id查询分类信息
     *
     * @param id: 分类id
     * @return: com.com.holary.entity.Category
     */
    Category getDetailInfo(Integer id);

    /**
     * description: 根据分类id修改分类
     *
     * @param category: category对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> update(Category category);

    /**
     * description: 根据id删除分类
     *
     * @param id: 分类id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> delete(Integer id);
}
