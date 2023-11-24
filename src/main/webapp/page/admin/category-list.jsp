<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/11/22
  Time: 19:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script type="text/javascript" src="../../static/lib/layui-2.8.18/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../static/js/xadmin.js"></script>
</head>
<body>
<div class="x-body">
    <h2 style="text-align: center; margin-bottom: 20px; margin-top: 0;">分类列表</h2>
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <%--添加分类--%>
            <button type="button" class="layui-btn layui-btn-normal" style="float: left"
                    onclick="x_admin_show('添加分类','/sys/goCategoryAdd',500,275)">
                <i class="layui-icon layui-icon-add-1"></i>添加
            </button>
        </form>
    </div>

    <table class="layui-table" style="margin-top: 0;text-align: center;">
        <thead>
        <tr>
            <td>编号</td>
            <td>分类名称</td>
            <td>排序</td>
            <td>创建时间</td>
            <td>修改时间</td>
            <td>操作</td>
        </tr>
        </thead>
        <tbody id="tab"></tbody>
    </table>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        selectCategory();
    })

    function selectCategory() {
        $.ajax({
            url: "/admin/category/list",
            type: "GET",
            dataType: "JSON",
            success: function (data) {
                let categoryList = data.list;
                if (categoryList.length > 0) {
                    let str = ''; // 用str变量拼接字符串
                    for (let i = 0; i < categoryList.length; i++) {
                        str += '<tr>' +
                            '<td>' + (i + 1) + '</td>' +
                            '<td>' + categoryList[i].name + '</td>' +
                            '<td>' + categoryList[i].sort + '</td>' +
                            '<td>' + categoryList[i].createTime + '</td>' +
                            '<td>' + categoryList[i].updateTime + '</td>' +
                            '<td class="td-manage">' +
                            '<button type="button" class="layui-btn layui-btn-sm layui-btn-warm" onclick="editCategory(' + categoryList[i].id + ')"><i class="layui-icon layui-icon-edit"></i></button>' +
                            '<button type="button" class="layui-btn layui-btn-sm layui-btn-danger" onclick="deleteCategory(' + categoryList[i].id + ')"><i class="layui-icon layui-icon-delete"></i></button>' +
                            '</td>' +
                            '</tr>';
                    }
                    $("#tab").html(str);
                } else {
                    $("#tab").html('<tr><td colspan="6" align="center">没有分类数据</td></tr>');
                }
            }, error: function () {
                alert("访问分类接口失败!");
            }
        });
    }

    // 修改分类
    function editCategory(categoryId) {
        $.ajax({
            url: "/admin/category/getDetailInfo",
            type: "GET",
            data: {
                id: categoryId
            }, success: function () {
                // 处理编辑操作
                x_admin_show('编辑分类', '/admin/category/getDetailInfo?id=' + categoryId, 500, 275);
            }, error: function () {
                alert("获取分类信息失败!");
            }
        });
    }

    // 删除分类
    function deleteCategory(categoryId) {
        layer.confirm('您确认删除该分类吗?', {
            icon: 3,
            title: '警告',
            btn: ['确认', '取消'],
        }, function () {
            $.ajax({
                url: "/admin/category/delete",
                type: "POST",
                data: {
                    id: categoryId
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
                    layer.alert("访问删除分类接口失败!", {icon: 5}, function () {
                        location.reload();
                    });
                }
            });
        });
    }
</script>
</html>
