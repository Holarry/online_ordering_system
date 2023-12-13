<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/11/20
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="../../static/style/list.css">
    <link rel="stylesheet" href="../../static/style/font.css">
    <link rel="stylesheet" href="../../static/style/xadmin.css">
    <link rel="stylesheet" href="../../static/lib/layui-2.8.18/css/layui.css">
    <link rel="stylesheet" href="../../static/lib/bootstrap3.3.7/css/bootstrap.css">
    <script type="text/javascript" src="../../static/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../../static/js/jqPaginator.js"></script>
    <script type="text/javascript" src="../../static/lib/layui-2.8.18/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../static/js/xadmin.js"></script>
</head>
<body>
<div class="x-body">
    <div class="header-d">
        <span>用户管理</span>
        <%--添加用户--%>
        <button class="layui-btn layui-btn-normal"
                onclick="x_admin_show('添加用户','../sys/goUserAdd',500,450)">
            <i class="layui-icon layui-icon-add-1"></i>添加
        </button>
    </div>
    <hr>
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <%--模糊查询--%>
            <div class="like-query">
                <span>用户名 : </span>
                <label for="username">
                    <input type="text" placeholder="请输入用户名" id="username" autocomplete="off"
                           class="layui-input"
                           style="margin-right: 20px;">
                </label>
                <span>性别 : </span>
                <label for="gender">
                    <select id="gender" style="margin-right: 25px;">
                        <option value="">请选择</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </label>
                <div style="margin-right: 25px"></div>
                <span>状态 : </span>
                <label for="status">
                    <select id="status">
                        <option value="">请选择</option>
                        <option value="正常">正常</option>
                        <option value="禁用">禁用</option>
                    </select>
                </label>
                <button class="layui-btn layui-btn-normal" type="button" style="margin-bottom: 5px;margin-left: 25px"
                        onclick="selectUserByCondition()">
                    <i class="layui-icon layui-icon-search"></i>
                </button>
                <button class="layui-btn layui-btn-primary layui-border-blue" type="button"
                        style="margin-bottom: 5px;" onclick="clearSelected()">
                    重置
                </button>
            </div>
        </form>
    </div>

    <table class="layui-table-d layui-table">
        <thead>
        <tr>
            <th>编号</th>
            <th>用户名</th>
            <th>年龄</th>
            <th>性别</th>
            <th>手机号</th>
            <th>状态</th>
            <th style="width: 200px">创建时间</th>
            <th style="width: 200px">修改时间</th>
            <th style="width: 150px">操作</th>
        </tr>
        </thead>
        <tbody id="tab"></tbody>
        <tr>
            <td colspan="9" align="center">
                <ul class="pagination" id="pagination1"></ul>
            </td>
        </tr>
    </table>
</div>
</body>
<script type="text/javascript">
    // 总页数
    let totalPages = 0;
    // 总条数
    let totalCounts = 0;
    // 当前页
    let currentPage = 0;
    // 编号
    let count = 1;

    // 解决enter键问题
    $(document).ready(function () {
        $(this).keydown(function (e) {
            if (e.which === 13) {
                if ($("#username").val() !== '' || $("#gender").val() !== '' || $("#status").val() !== '') {
                    selectUserByCondition();
                    return false;
                }
            }
        });
    });

    // 分页
    function page() {
        // 初始化
        selectAll(1);
        // 加载按钮
        $("#pagination1").jqPaginator({
            // 总页数
            totalPages: totalPages,
            // 总条数
            totalCounts: totalCounts,
            // 当前页
            currentPage: currentPage,
            // 加载按钮
            first: '<li class="first"><a href="javascript:void(0);">首页</a></li>',
            prev: '<li class="prev"><a href="javascript:void(0);">上一页</a></li>',
            next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
            last: '<li class="last"><a href="javascript:void(0);">末页</a></li>',
            page: '<li class="page"><a href="javascript:void(0);">{{page}}</a></li>',
            onPageChange: function (number) {
                // 当页面一改变就执行
                selectAll(number);
            }
        });
    }

    // 页面一加载后就执行, 这里就是查询信息
    $(document).ready(function () {
        page();
    });

    //全查
    function selectAll(number) {
        let status = $("#status").val();
        if (status === '正常') {
            status = 1;
        } else if (status === '禁用') {
            status = 0;
        } else {
            status = null;
        }
        $.ajax({
            url: "../admin/user/list",
            dataType: "JSON",
            type: "POST",
            async: false,
            data: {
                pageNum: number,
                pageSize: 8,
                username: $("#username").val(),
                gender: $("#gender").val(),
                status: status
            }, success: function (data) {
                // 取出返回数据中用户数据
                let userList = data.paging.list;
                // 判断userList是否有数据
                if (userList.length > 0) {
                    totalPages = data.paging.pages;  // 总页数
                    totalCounts = data.paging.total; // 总条数
                    currentPage = data.paging.pageNum;// 当前页
                    //把数据写在页面上
                    let str = ''; // 用str变量拼接字符串
                    count = (number - 1) * 8 + 1;
                    for (let i = 0; i < userList.length; i++) {
                        let status;
                        if (userList[i].status === 1) {
                            status = '正常';
                        } else {
                            status = '禁用';
                        }
                        str += '<tr>' +
                            '<td>' + (count++) + '</td>' +
                            '<td>' + userList[i].username + '</td>' +
                            '<td>' + userList[i].age + '</td>' +
                            '<td>' + userList[i].gender + '</td>' +
                            '<td>' + userList[i].phone + '</td>' +
                            '<td>' + status + '</td>' +
                            '<td>' + userList[i].createTime + '</td>' +
                            '<td>' + userList[i].updateTime + '</td>' +
                            '<td class="td-manage">' +
                            '<button type="button" class="layui-btn layui-btn-sm layui-btn-warm" onclick="editUser(' + userList[i].id + ')"><i class="layui-icon layui-icon-edit"></i></button>' +
                            '<button type="button" class="layui-btn layui-btn-sm layui-btn-danger" onclick="deleteUser(' + userList[i].id + ')"><i class="layui-icon layui-icon-delete"></i></button>' +
                            '</td>' +
                            '</tr>';
                    }
                    $("#tab").html(str);
                } else {//没有数据
                    totalPages = 1;
                    totalCounts = 1;
                    currentPage = 1;
                    $("#tab").html('<tr><td colspan="9" align="center">没有用户数据</td></tr>');
                }
            }, error: function () {
                layer.msg("访问用户接口失败!");
            }
        });
    }

    // 条件查询
    function selectUserByCondition() {
        page();
    }

    // 重置
    function clearSelected() {
        // 清空用户名输入框
        $("#username").val('');
        // 清空性别和状态选择框
        $("#gender").val("");
        $("#status").val("");
        $("form")[0].reset();
        selectUserByCondition();
    }

    // 编辑用户
    function editUser(userId) {
        $.ajax({
            url: "/admin/user/getDetailInfo",
            type: "GET",
            data: {
                id: userId
            }, success: function () {
                // 处理编辑操作
                x_admin_show('编辑用户', '/admin/user/getDetailInfo?id=' + userId, 500, 455);
            }, error: function () {
                layer.msg("获取用户信息失败!", function () {
                    location.reload();
                });
            }
        });
    }

    // 删除用户
    function deleteUser(userId) {
        layer.confirm('您确认删除该用户吗?', {
            icon: 3,
            title: '警告',
            btn: ['确认', '取消'],
        }, function () {
            $.ajax({
                url: "/admin/user/delete",
                type: "POST",
                data: {
                    id: userId
                }, success: function (data) {
                    if (data.code === 200) {
                        layer.msg(data.message, {icon: 1, time: 1000}, function () {
                            x_admin_close();
                            location.reload();
                        });
                    } else if (data.code === -1) {
                        layer.msg(data.message, {icon: 2});
                    }
                }, error() {
                    layer.msg("访问删除用户接口失败!", function () {
                        location.reload();
                    });
                }
            });
        });
    }
</script>
</html>
