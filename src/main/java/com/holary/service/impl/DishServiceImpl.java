package com.holary.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.holary.dto.DishDto;
import com.holary.entity.Dish;
import com.holary.mapper.DishMapper;
import com.holary.service.DishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/11/24 15:37
 * @Description: DishServiceImpl
 */
@Service
public class DishServiceImpl implements DishService {
    @Autowired
    private DishMapper dishMapper;

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
    @Override
    public Map<String, Object> list(int pageNum, int pageSize, String name, Integer categoryId, Integer status) {
        // 开启分页插件
        PageHelper.startPage(pageNum, pageSize);
        List<DishDto> dishDtoList = dishMapper.selectAll(name, categoryId, status);
        PageInfo<DishDto> dishDtoPageInfo = new PageInfo<>(dishDtoList);

        HashMap<String, Object> map = new HashMap<>();
        map.put("code", 200);
        map.put("paging", dishDtoPageInfo);
        return map;
    }

    /**
     * description: 添加菜品
     *
     * @param dish: dish对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> save(Dish dish) {
        HashMap<String, Object> map = new HashMap<>();

        String name = dish.getName();
        Dish dish1 = dishMapper.selectByName(name);
        if (name.isEmpty()) {
            map.put("code", -1);
            map.put("message", "菜品名称为空!");
        } else if (dish.getCategoryId() == null) {
            map.put("code", -2);
            map.put("message", "菜品分类为空!");
        } else if (dish.getPrice() == null) {
            map.put("code", -3);
            map.put("message", "菜品价格为空!");
        } else if (dish1 != null) {
            map.put("code", -4);
            map.put("message", name + "菜品已存在!");
        } else {
            dish.setCreateTime(Timestamp.valueOf(LocalDateTime.now()));
            dish.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
            dishMapper.insert(dish);
            map.put("code", 200);
            map.put("message", "添加菜品成功!");
        }
        return map;
    }

    /**
     * description: 根据菜品id查询菜品
     *
     * @param id: 菜品id
     * @return: com.holary.entity.Dish
     */
    @Override
    public Dish getDetailInfo(Integer id) {
        return dishMapper.selectById(id);
    }

    /**
     * description: 根据菜品id修改菜品
     *
     * @param dish: dish对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> update(Dish dish) {
        HashMap<String, Object> map = new HashMap<>();
        Dish dish1 = dishMapper.selectByIdAndName(dish.getId(), dish.getName());
        if (dish.getName().isEmpty()) {
            map.put("code", -1);
            map.put("message", "菜品名称为空!");
        } else if (dish.getCategoryId() == null) {
            map.put("code", -2);
            map.put("message", "菜品分类为空!");
        } else if (dish.getPrice() == null) {
            map.put("code", -3);
            map.put("message", "菜品价格为空!");
        } else if (dish1 != null) {
            map.put("code", -4);
            map.put("message", dish.getName() + "菜品已存在!");
        } else {
            dish.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
            dishMapper.updateById(dish);
            map.put("code", 200);
            map.put("message", "修改菜品成功!");
        }
        return map;
    }

    /**
     * description: 根据菜品id删除菜品
     *
     * @param id: 菜品id
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> delete(Integer id) {
        HashMap<String, Object> map = new HashMap<>();
        int i = dishMapper.deleteById(id);
        if (i > 0) {
            map.put("code", 200);
            map.put("message", "删除菜品成功!");
        } else {
            map.put("code", -1);
            map.put("message", "删除菜品失败!");
        }
        return map;
    }

    /**
     * description: 用户端菜品分页查询和条件查询
     *
     * @param name:       菜品名称
     * @param categoryId: 菜品分类
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @Override
    public Map<String, Object> list1(String name, Integer categoryId) {
        HashMap<String, Object> map = new HashMap<>();
        List<DishDto> dishList = dishMapper.selectAll1(name, categoryId);
        map.put("code", 200);
        map.put("dishList", dishList);
        return map;
    }
}
