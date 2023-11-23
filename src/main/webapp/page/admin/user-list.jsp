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
    <h2 style="text-align: center; margin-bottom: 20px; margin-top: 0;">用户列表</h2>
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <%--添加用户--%>
            <button class="layui-btn layui-btn-normal" style="float: left"
                    onclick="x_admin_show('添加用户','../sys/goUserAdd',500,450)">
                <i class="layui-icon layui-icon-add-1"></i>添加
            </button>

            <%--模糊查询--%>
            <label for="queryUser">
                <input type="text" placeholder="请输入用户名" id="queryUser" autocomplete="off" class="layui-input">
                <button class="layui-btn" type="button" onclick="selectUserByUsername()">
                    <i class="layui-icon layui-icon-search"></i>
                </button>
            </label>

            <%--刷新--%>
            <a class="layui-btn layui-btn-normal" style="float: right"
               href="javascript:location.replace(location.href);" title="刷新">
                <i class="layui-icon layui-icon-refresh"></i>
            </a>
        </form>
    </div>

    <table class="layui-table" style="margin-top: 0;text-align: center;width: auto">
        <thead>
        <tr>
            <td>编号</td>
            <td>用户名</td>
            <td>年龄</td>
            <td>性别</td>
            <td>手机号</td>
            <td>状态</td>
            <td style="width: 200px">创建时间</td>
            <td style="width: 200px">修改时间</td>
            <td style="width: 150px">操作</td>
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
</html>
<script type="text/javascript">
    // 解决enter键问题
    $(document).ready(function enterJudge() {
        $(this).keydown(function (e) {
            if (e.which === "13" && $("#queryUser").val() !== '') {
                selectUserByUsername();
                return false;
            }
        })
    })
    // 总页数
    let totalPages = 0;
    // 总条数
    let totalCounts = 0;
    // 当前页
    let currentPage = 0;
    // 页面一加载后就执行, 这里就是查询信息
    $(document).ready(function () {
        // 执行全查
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
        })
    })

    let count = 1;

    //全查
    function selectAll(number) {
        $.ajax({
            url: "../admin/user/list",
            dataType: "JSON",
            type: "POST",
            async: false,
            data: {
                pageNum: number,
                pageSize: 5,
                username: $("#queryUser").val(),
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
                    count = (number - 1) * 5 + 1;
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
                alert("查询用户失败!");
            }
        })
    }

    // 条件查询
    function selectUserByUsername() {
        // 初始化
        selectAll(1);
        // 加载数据
        $("#pagination1").jqPaginator({
            totalPages: totalPages,
            totalCounts: totalCounts,
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
        })
    }

    // 修改用户
    function editUser(userId) {
        $.ajax({
            url: "/admin/user/getDetailInfo",
            type: "GET",
            data: {
                id: userId
            }, success: function () {
                // 处理编辑操作
                x_admin_show('编辑用户', '/admin/user/getDetailInfo?id=' + userId, 500, 450);
            }, error: function () {
                alert("获取用户信息失败!");
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
                        layer.alert(data.message, {icon: 6}, function () {
                            x_admin_close();
                            location.reload();
                        });
                    } else if (data.code === -1) {
                        layer.alert(data.message, {icon: 5});
                    }
                }, error() {
                    layer.alert("访问删除用户接口失败!", {icon: 5}, function () {
                        location.reload();
                    });
                }
            });
        });
    }

</script>
