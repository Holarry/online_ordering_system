package com.holary.util;

/**
 * @Author: Holary
 * @Date: 2023/11/28 17:10
 * @Description: 基于ThreadLocal封装工具类, 用于保存和获取当前登录用户id
 */
public class BaseContext {
    private static ThreadLocal<Integer> threadLocal = new ThreadLocal<>();

    /**
     * description: 设置id
     *
     * @param id: 用户id
     * @return: void
     */
    public static void setCurrentId(Integer id) {
        threadLocal.set(id);
    }

    /**
     * description: 获取id
     *
     * @return: java.lang.Long
     */
    public static Integer getCurrentId() {
        return threadLocal.get();
    }
}
