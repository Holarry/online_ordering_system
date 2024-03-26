<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2024/3/26
  Time: 21:22
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
    <link rel="stylesheet" href="../../static/style/dish-add.css">
    <link rel="stylesheet" href="../../static/style/font.css">
    <link rel="stylesheet" href="../../static/style/xadmin.css">
    <link rel="stylesheet" href="../../static/style/add.css">
    <link rel="stylesheet" href="../../static/lib/layui-2.8.18/css/layui.css">
    <script type="text/javascript" src="../../static/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../../static/lib/layui-2.8.18/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../static/js/xadmin.js"></script>
</head>
<body>
<div class="body-d">
    <form class="form-d">
        <div class="form-item-d">
            <label for="content" class="form-item-label-d" style="width: 100px">留言内容</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <textarea id="content" name="content" class="form-input-inner-d" type="text"
                              autocomplete="off" tabindex="0" placeholder="留言"
                              style="height: 130px"></textarea>
                </div>
            </div>
        </div>

        <div class="form-item-content-d" style="float: right">
            <button class="layui-btn layui-btn-normal"
                    type="button" onclick="addComment()">确认留言
            </button>
        </div>
    </form>
</div>
</body>
<script type="text/javascript">
    function addComment() {
        let comment = {
            content: $('#content').val()
        }

        $.ajax({
            url: "../user/comment/addComment",
            type: "POST",
            dataType: "JSON",
            data: JSON.stringify(comment),
            contentType: 'application/json;charset=utf-8',
            success: function (data) {
                if (data.code === 200) {
                    layer.msg(data.message, {icon: 1, time: 1000}, function () {
                        notifyParentPage();
                    });
                } else if (data.code === -1) {
                    layer.msg(data.message, {icon: 2});
                }
            },
            error: function () {
                layer.msg("访问添加留言接口失败", function () {
                    location.reload();
                });
            }
        });
    }

    // 通知主页面关闭抽屉并刷新数据
    function notifyParentPage() {
        // 获取主页面的全局对象
        let parentPage = window.parent;

        // 调用主页面定义的回调函数
        if (parentPage.addDishSuccessCallback) {
            parentPage.addDishSuccessCallback();
        }
    }
</script>
</html>
