package com.holary.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.holary.dto.DishDto;
import com.holary.mapper.DishMapper;
import com.holary.service.DishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
