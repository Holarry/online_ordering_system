<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/10/4
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>首页 | 开饭啦</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../static/lib/layui-2.8.18/css/layui.css">
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">在线点餐系统</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <a href="javascript:">
                    <img src="../static/images/avatar.png"
                         class="layui-nav-img" alt="图片未找到">
                    <shiro:principal/>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:" target="right">个人信息</a></dd>
                    <dd><a href="../logout">退出登录</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                <a href="javascript:">
                    <i class="layui-icon layui-icon-more-vertical"></i>
                </a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <shiro:hasRole name="管理员">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="javascript:">功能菜单</a>
                        <dl class="layui-nav-child">
                            <dd style="margin-left: 20px; text-align: left;"><a href="../sys/goUserList" target="right">用户管理</a>
                            </dd>
                            <dd style="margin-left: 20px; text-align: left;"><a href="../sys/goCategoryList"
                                                                                target="right">分类管理</a></dd>
                            <dd style="margin-left: 20px; text-align: left;"><a href="../sys/goDishList"
                                                                                target="right">菜品管理</a></dd>
                            <dd style="margin-left: 20px; text-align: left;"><a href="javascript:"
                                                                                target="right">订单管理</a></dd>
                        </dl>
                    </li>
                </shiro:hasRole>
                <shiro:hasRole name="普通用户">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="javascript:">功能菜单</a>
                        <dl class="layui-nav-child">
                            <dd style="margin-left: 20px; text-align: left;"><a href="javascript:"
                                                                                target="right">菜单列表</a></dd>
                            <dd style="margin-left: 20px; text-align: left;"><a href="javascript:"
                                                                                target="right">购物车</a></dd>
                            <dd style="margin-left: 20px; text-align: left;"><a href="javascript:"
                                                                                target="right">地址管理</a></dd>
                            <dd style="margin-left: 20px; text-align: left;"><a href="javascript:"
                                                                                target="right">我的订单</a></dd>
                        </dl>
                    </li>
                </shiro:hasRole>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <shiro:hasRole name="管理员">
            <iframe src="../sys/goUserList" name="right"
                    style="width: 100%; height: 98.5%; border: none; overflow: hidden;"></iframe>
        </shiro:hasRole>
        <shiro:hasRole name="普通用户">
            <iframe src="" name="right" style="width: 100%; height: 98.5%; border: none; overflow: hidden;"></iframe>
        </shiro:hasRole>
    </div>

    <div class="layui-footer" style="text-align: center;height: 50px">
        <!-- 底部固定区域 -->
        <p>Copyright &copy; 2023 202020201345何林</p>
    </div>
</div>
<script type="text/javascript" src="../static/lib/layui-2.8.18/layui.js"></script>
<script>
    layui.use(['element', 'layer', 'util'], function () {
        let layer = layui.layer;
        let util = layui.util;

        //头部事件
        util.event('lay-header-event', {
            //左侧菜单事件
            menuLeft: function () {
                layer.msg('展开左侧菜单的操作', {icon: 0});
            }
            , menuRight: function () {
                layer.open({
                    type: 1,
                    title: '介绍',
                    content: '<div style="padding: 15px;">在线点餐系统管理端</div>',
                    area: ['260px', '100%'],
                    offset: 'rt', //右上角
                    anim: 'slideLeft', // 从右侧抽屉滑出
                    shadeClose: true,
                    scrollbar: false
                });
            }
        });

    });
</script>
</body>
</html>
