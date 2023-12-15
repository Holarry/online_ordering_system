package com.holary.service.impl;

import com.holary.entity.Category;
import com.holary.entity.Dish;
import com.holary.mapper.CategoryMapper;
import com.holary.mapper.DishMapper;
import com.holary.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * @Author: Holary
 * @Date: 2023/11/22 19:55
 * @Description: CategoryServiceImpl
 */
@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private DishMapper dishMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * description: 查询分类
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> list() {
        HashMap<String, Object> map = new HashMap<>();
        // 构造key
        String key = "category";
        List<Category> categoryList = (List<Category>) redisTemplate.opsForValue().get(key);
        // 如果缓存中有数据直接返回
        if (categoryList != null && !categoryList.isEmpty()) {
            map.put("code", 200);
            map.put("list", categoryList);
            return map;
        }
        // 如果缓存中没有数据则查询数据库,并将数据放入缓存中
        categoryList = categoryMapper.selectAll();
        redisTemplate.opsForValue().set(key, categoryList, 30, TimeUnit.MINUTES);
        map.put("code", 200);
        map.put("list", categoryList);
        return map;
    }

    /**
     * description: 添加分类
     *
     * @param category: category对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> save(Category category) {
        Category category1 = categoryMapper.selectByName(category.getName());
        HashMap<String, Object> map = new HashMap<>();
        if (category.getName().isEmpty() || category.getSort() == null) {
            map.put("code", -1);
            map.put("message", "分类名称或排序为空!");
        } else if (category.getSort() < 0 || category.getSort() > 100) {
            map.put("code", -2);
            map.put("message", "排序超出范围(0-100)!");
        } else if (category1 != null) {
            map.put("code", -3);
            map.put("message", category.getName() + "分类已存在!");
        } else {
            category.setCreateTime(Timestamp.valueOf(LocalDateTime.now()));
            category.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
            categoryMapper.insert(category);
            // 清理缓存
            cleanCache("category");
            map.put("code", 200);
            map.put("message", "添加分类成功!");
        }
        return map;
    }

    /**
     * description: 根据分类id查询分类信息
     *
     * @param id: 分类id
     * @return: com.com.holary.entity.Category
     */
    @Override
    public Category getDetailInfo(Integer id) {
        return categoryMapper.selectById(id);
    }

    /**
     * description: 根据分类id修改分类
     *
     * @param category: category对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> update(Category category) {
        Integer id = category.getId();
        String name = category.getName();
        Category category1 = categoryMapper.selectByIdAndName(id, name);

        HashMap<String, Object> map = new HashMap<>();
        if (category.getSort() == null || name.isEmpty()) {
            map.put("code", -1);
            map.put("message", "分类名称或排序为空!");
        } else if (category.getSort() < 0 || category.getSort() > 100) {
            map.put("code", -2);
            map.put("message", "排序超出范围(0-100)!");
        } else if (category1 != null) {
            map.put("code", -3);
            map.put("message", name + "分类已存在!");
        } else {
            category.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
            categoryMapper.updateById(category);
            // 清理缓存
            cleanCache("category");
            map.put("code", 200);
            map.put("message", "修改分类成功!");
        }
        return map;
    }

    /**
     * description: 根据id删除分类
     *
     * @param id: 分类id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> delete(Integer id) {
        HashMap<String, Object> map = new HashMap<>();
        // 判断删除的分类下是否有关联菜品
        List<Dish> dishList = dishMapper.selectByCategoryId(id);
        if (!dishList.isEmpty()) {
            map.put("code", -1);
            map.put("message", "该分类下关联有菜品,不能删除!");
        } else {
            int i = categoryMapper.deleteById(id);
            if (i > 0) {
                // 清理缓存
                cleanCache("category");
                map.put("code", 200);
                map.put("message", "删除分类成功!");
            } else {
                map.put("code", -2);
                map.put("message", "删除分类失败!");
            }
        }
        return map;
    }

    /**
     * description: 清理缓存中的数据
     *
     * @param pattern:
     * @return: void
     */
    public void cleanCache(String pattern) {
        Set keys = redisTemplate.keys(pattern);
        redisTemplate.delete(keys);
    }
}
