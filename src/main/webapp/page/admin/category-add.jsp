<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/11/22
  Time: 22:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8"/>
    <link rel="stylesheet" href="../../static/style/font.css">
    <link rel="stylesheet" href="../../static/style/xadmin.css">
    <link rel="stylesheet" href="../../static/style/add.css">
    <script type="text/javascript" src="../../static/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../../static/lib/layui-2.8.18/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../static/js/xadmin.js"></script>
</head>
<body>
<div class="x-body">
    <form class="layui-form">
        <div class="layui-form-item">
            <label for="name" class="layui-form-label">分类名称</label>
            <div class="layui-input-inline">
                <input type="text" id="name" name="name" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="sort" class="layui-form-label">排序</label>
            <div class="layui-input-inline">
                <input type="number" id="sort" name="sort" autocomplete="off" class="layui-input"
                       min="0" max="100">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label"></label>
            <input type="button" id="L_repass" class="layui-btn-primary" value="添加"
                   onclick="addCategory()">
        </div>
    </form>
</div>
</body>
<script>
    function addCategory() {
        // 获取表单数据
        let name = $('#name').val();
        let sort = $('#sort').val();

        // 构造category对象
        let category = {
            name: name,
            sort: parseInt(sort)
        };

        $.ajax({
            url: "/admin/category/save",
            type: "POST",
            data: JSON.stringify(category),
            contentType: 'application/json;charset=utf-8',
            async: false,
            success: function (data) {
                if (data.code === 200) {
                    layer.msg(data.message, {icon: 1, time: 1000}, function () {
                        closeDialog();
                    });
                } else if (data.code === -1 || data.code === -2 || data.code === -3) {
                    layer.msg(data.message, {icon: 2});
                }
            }, error: function () {
                layer.msg("访问添加分类接口失败", function () {
                    location.reload();
                });
            }
        });
    }

    // 关闭弹窗
    function closeDialog() {
        x_admin_close();
        // 刷新user-list页面
        window.parent.location.reload();
    }
</script>
</html>
