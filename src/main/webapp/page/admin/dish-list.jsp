<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/11/24
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
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
        <span>菜品管理</span>
        <%--添加菜品--%>
        <button class="layui-btn layui-btn-normal"
                type="button" onclick="addDish()">
            <i class="layui-icon layui-icon-add-1"></i>添加
        </button>
    </div>
    <hr>
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <%--模糊查询--%>
            <div class="like-query">
                <span>菜品名称 : </span>
                <label for="name">
                    <input type="text" placeholder="请输入菜品名称" id="name" autocomplete="off"
                           class="layui-input"
                           style="margin-right: 20px;">
                </label>
                <span>分类 : </span>
                <label for="categoryName">
                    <select id="categoryName" style="margin-right: 25px;">
                    </select>
                </label>
                <div style="margin-right: 25px"></div>
                <span>状态 : </span>
                <label for="status">
                    <select id="status">
                        <option value="">请选择</option>
                        <option value="上架">上架</option>
                        <option value="下架">下架</option>
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
            <td>编号</td>
            <td>菜品名称</td>
            <td>分类</td>
            <td>价格</td>
            <td>图片</td>
            <td>描述</td>
            <td>状态</td>
            <td style="width: 240px">创建时间</td>
            <td style="width: 240px">修改时间</td>
            <td style="width: 160px">操作</td>
        </tr>
        </thead>
        <tbody id="tab"></tbody>
        <tr>
            <td colspan="10" align="center">
                <ul class="pagination" id="pagination1"></ul>
            </td>
        </tr>
    </table>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function enterJudge() {
        // 页面加载时获取分类列表
        getCategoryList();

        // 解决enter键问题
        $(this).keydown(function (e) {
            if (e.which === 13) {
                if ($("#name").val() !== '' || $("#categoryName").val() !== '' || $("#status").val() !== '') {
                    selectUserByCondition();
                    return false;
                }
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
        let status = $("#status").val();
        if (status === '上架') {
            status = 1;
        } else if (status === '下架') {
            status = 0;
        } else {
            status = null;
        }
        $.ajax({
            url: "../admin/dish/list",
            dataType: "JSON",
            type: "POST",
            async: false,
            data: {
                pageNum: number,
                pageSize: 5,
                name: $("#name").val(),
                categoryId: $("#categoryName").val(),
                status: status
            }, success: function (data) {
                // 取出返回数据中用户数据
                let dishList = data.paging.list;
                // 判断userList是否有数据
                if (dishList.length > 0) {
                    totalPages = data.paging.pages;  // 总页数
                    totalCounts = data.paging.total; // 总条数
                    currentPage = data.paging.pageNum;// 当前页
                    //把数据写在页面上
                    let str = ''; // 用str变量拼接字符串
                    count = (number - 1) * 5 + 1;
                    for (let i = 0; i < dishList.length; i++) {
                        let status;
                        if (dishList[i].status === 1) {
                            status = '上架';
                        } else {
                            status = '下架';
                        }

                        str += '<tr>' +
                            '<td>' + (count++) + '</td>' +
                            '<td>' + dishList[i].name + '</td>' +
                            '<td>' + dishList[i].categoryName + '</td>' +
                            '<td>' + dishList[i].price + '元' + '</td>' +
                            '<td><img src="' + dishList[i].image + '" style="width: 100%" alt="图片未找到"/></td>' +
                            '<td>' + dishList[i].description + '</td>' +
                            '<td>' + status + '</td>' +
                            '<td>' + dishList[i].createTime + '</td>' +
                            '<td>' + dishList[i].updateTime + '</td>' +
                            '<td class="td-manage">' +
                            '<button type="button" class="layui-btn layui-btn-sm layui-btn-warm" onclick="editDish(' + dishList[i].id + ')"><i class="layui-icon layui-icon-edit"></i></button>' +
                            '<button type="button" class="layui-btn layui-btn-sm layui-btn-danger" onclick="deleteDish(' + dishList[i].id + ')"><i class="layui-icon layui-icon-delete"></i></button>' +
                            '</td>' +
                            '</tr>';
                    }
                    $("#tab").html(str);
                } else {//没有数据
                    totalPages = 1;
                    totalCounts = 1;
                    currentPage = 1;
                    $("#tab").html('<tr><td colspan="10" align="center">没有菜品数据</td></tr>');
                }
            }, error: function () {
                alert("访问菜品接口失败!");
            }
        })
    }

    // 条件查询
    function selectUserByCondition() {
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

    // 重置
    function clearSelected() {
        // 清空输入框
        $("#name").val('');
        // 清空性别和状态选择框
        $("#categoryName").val("");
        $("#status").val("");
        $("form")[0].reset();
        selectUserByCondition();
    }

    // 获取分类
    function getCategoryList() {
        $.ajax({
            url: "/admin/category/list",
            type: "GET",
            dataType: "JSON",
            success: function (data) {
                console.log(data);
                // 清空原有的选项
                $("#categoryName").empty().append();
                // 添加默认选项
                $("#categoryName").append('<option value="">请选择</option>');
                let categoryList = data.list;
                for (let i = 0; i < categoryList.length; i++) {
                    $("#categoryName").append('<option value="' + categoryList[i].id + '">' + categoryList[i].name + '</option>');
                }
                // 刷新select渲染
                layui.form.render('select');
            }, error: function (err) {
                console.log(err);
                alert("访问分类接口失败!");
            }
        });
    }

    // 添加菜品
    function addDish() {
        layer.open({
            type: 2,
            title: '添加菜品',
            offset: 'r',
            anim: 'slideLeft', // 从右往左
            area: ['550px', '100%'],
            shade: 0.1,
            shadeClose: true,
            content: '/sys/goDishAdd'
        });
    }

    // 修改菜品
    function editDish(dishId) {
        $.ajax({
            url: "/admin/dish/getDetailInfo",
            type: "GET",
            data: {
                id: dishId
            }, success: function (data) {
                console.log(data);
                layer.open({
                    type: 2,
                    title: '编辑菜品',
                    offset: 'r',
                    anim: 'slideLeft', // 从右往左
                    area: ['550px', '100%'],
                    shade: 0.1,
                    shadeClose: true,
                    content: '/admin/dish/getDetailInfo?id=' + dishId
                });
            }
        });
    }

    // 删除菜品
    function deleteDish(dishId) {
        layer.confirm('您确认删除该菜品吗?', {
            icon: 3,
            title: '警告',
            btn: ['确认', '取消'],
        }, function () {
            $.ajax({
                url: "/admin/dish/delete",
                type: "POST",
                data: {
                    id: dishId
                }, success: function (data) {
                    console.log(data);
                    if (data.code === 200) {
                        layer.msg(data.message, {icon: 6, time: 1000}, function () {
                            x_admin_close();
                            location.reload();
                        });
                    } else if (data.code === -1) {
                        layer.msg(data.message, {icon: 5});
                    }
                }, error(err) {
                    console.log(err);
                    layer.msg("访问删除菜品接口失败!", {icon: 5}, function () {
                        location.reload();
                    });
                }
            });
        });
    }

    // addDishSuccessCallback 函数
    function addDishSuccessCallback() {
        // 关闭抽屉
        layer.closeAll();
        // 刷新页面数据
        location.reload();
    }
</script>
</html>
