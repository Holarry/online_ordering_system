package com.holary.util;

import org.apache.shiro.crypto.hash.SimpleHash;

/**
 * @Author: Holary
 * @Date: 2023/10/3 20:03
 * @Description: 加密工具类
 */
public class MD5Util {
    /**
     * description: md5加密
     *
     * @param password: 密码
     * @param salt:     盐
     * @return: java.lang.String
     */
    public static String md5(String password, String salt) {
        /*
          algorithmName代表进行加密的算法名称、
          source代表需要加密的元数据，如密码、
          salt代表盐，需要加进一起加密的数据、
          hashIterations代表hash迭代次数。
         */
        return new SimpleHash("MD5", password, salt, 1024).toString();
    }
}
