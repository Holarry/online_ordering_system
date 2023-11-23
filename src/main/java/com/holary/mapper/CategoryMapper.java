package com.holary.mapper;

import com.holary.entity.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: Holary
 * @Date: 2023/11/22 19:55
 * @Description: CategoryMapper
 */
public interface CategoryMapper {
    /**
     * description: 查询分类
     *
     * @return: java.util.List<com.com.holary.entity.Category>
     */
    List<Category> selectAll();

    /**
     * description: 根据分类名称查询分类
     *
     * @param name: 分类名称
     * @return: com.com.holary.entity.Category
     */
    Category selectByName(String name);

    /**
     * description: 添加分类
     *
     * @param category: category对象
     * @return: void
     */
    void insert(Category category);

    /**
     * description: 根据分类id查询分类信息
     *
     * @param id: 分类id
     * @return: com.com.holary.entity.Category
     */
    Category selectById(Integer id);

    /**
     * description: 根据分类id和分类名称查询分类
     *
     * @param id:   分类id
     * @param name: 分类名称
     * @return: com.com.holary.entity.Category
     */
    Category selectByIdAndName(@Param("id") Integer id, @Param("name") String name);

    /**
     * description: 根据分类id修改分类
     *
     * @param category: category对象
     * @return: void
     */
    void updateById(Category category);

    /**
     * description: 根据id删除分类
     *
     * @param id: 分类id
     * @return: int
     */
    int deleteById(Integer id);
}
