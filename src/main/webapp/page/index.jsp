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
    <link rel="stylesheet" href="../static/style/index.css">
    <link rel="stylesheet" href="../static/lib/layui-2.8.18/css/layui.css">
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-nav-d layui-header">
        <div class="logo">
            <img src="../static/images/logo2.jpg" alt="图片未找到"
                 style="width: 130px; height: 60px; margin-left: 30px; margin-top: 30px"/>
        </div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block" style="margin-right: 10px">
                <a href="javascript:">
                    <img src="../static/images/avatar.png"
                         class="layui-nav-img" alt="图片未找到">
                    <shiro:principal/>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="../logout">退出登录</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav-d layui-nav layui-nav-tree layui-nav-side">
                <shiro:hasRole name="管理员">
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goUserList" target="right" style="margin-top: 120px">
                            <i class="layui-icon layui-icon-user"></i>
                            <span>用户管理</span>
                        </a>
                    </li>
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goCategoryList" target="right">
                            <i class="layui-icon layui-icon-app"></i>
                            <span>分类管理</span>
                        </a>
                    </li>
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goDishList" target="right">
                            <i class="layui-icon layui-icon-console"></i>
                            <span>菜品管理</span>
                        </a>
                    </li>
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goOrderList" target="right">
                            <i class="layui-icon layui-icon-notice"></i>
                            <span>订单管理</span>
                        </a>
                    </li>
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goCommentList" target="right">
                            <i class="layui-icon layui-icon-reply-fill"></i>
                            <span>留言管理</span>
                        </a>
                    </li>
                </shiro:hasRole>

                <shiro:hasRole name="普通用户">
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goUserDishList" target="right" style="margin-top: 120px">
                            <i class="layui-icon layui-icon-form"></i>
                            <span>菜单列表</span>
                        </a>
                    </li>
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goShoppingCartList" target="right">
                            <i class="layui-icon layui-icon-cart"></i>
                            <span>购物车</span>
                        </a>
                    </li>
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goUserOrderList" target="right">
                            <i class="layui-icon layui-icon-notice"></i>
                            <span>我的订单</span>
                        </a>
                    </li>
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../sys/goUserCommentList" target="right">
                            <i class="layui-icon layui-icon-reply-fill"></i>
                            <span>留言广场</span>
                        </a>
                    </li>
                    <li class="layui-nav-item-d layui-nav-item">
                        <a href="../user/user/getDetailInfo" target="right">
                            <i class="layui-icon layui-icon-username"></i>
                            <span>个人中心</span>
                        </a>
                    </li>
                </shiro:hasRole>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <shiro:hasRole name="管理员">
            <iframe src="../sys/goUserList" name="right"></iframe>
        </shiro:hasRole>
        <shiro:hasRole name="普通用户">
            <iframe src="../sys/goUserDishList" name="right"></iframe>
        </shiro:hasRole>
    </div>

    <div class="layui-footer">
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
        });
    });
</script>
</body>
</html>
