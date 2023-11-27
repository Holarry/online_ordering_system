package com.holary.util;

import com.holary.entity.User;
import com.holary.mapper.LoginMapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;

/**
 * @Author: Holary
 * @Date: 2023/10/3 20:12
 * @Description: MyShiroRealm
 */
public class MyShiroRealm extends AuthorizingRealm {
    @Autowired
    private LoginMapper loginMapper;

    /**
     * description:shiro授权方法
     *
     * @param principalCollection:
     * @return: org.apache.shiro.authz.AuthorizationInfo
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //获取当前已认证的账号
        String username = (String) principalCollection.getPrimaryPrincipal();
        //查询该用户的身份
        User user = loginMapper.selectUserByUsername(username);
        HashSet<String> roles = new HashSet<>();
        if (user.getRole() != null) {
            roles.add(user.getRole().getRole());
        }
        //查询用户的权限授权信息
        HashSet<String> perms = new HashSet<>();
        //创建授权对象
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        //设置角色
        info.setRoles(roles);
        //设置权限
        info.setStringPermissions(perms);
        return info;
    }

    /**
     * description:shiro认证方法
     *
     * @param token:
     * @return: org.apache.shiro.authc.AuthenticationInfo
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //通过token获取用户名
        String username = (String) token.getPrincipal();
        //从数据库中查询account的用户信息
        User user = loginMapper.selectUserByUsername(username);
        //判断用户是否存在
        if (user == null) {
            throw new UnknownAccountException("用户名" + username + "不存在!");
        } else if (user.getStatus() == 0) {
            throw new UnknownAccountException("用户名" + username + "已被禁用!");
        }
        //保存用户信息
        //获取shiro提供的当前会话对象
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute("user", user);

        //创建一个SimpleAuthenticationInfo对象,利用构造方法中的参数进行用户名、密码校验
        //获取盐
        ByteSource salt = ByteSource.Util.bytes(user.getUsername());
        return new SimpleAuthenticationInfo(user.getUsername(), user.getPassword(), salt, getName());
    }
}
