<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/12/15
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <label for="oldPassword" class="form-item-label-d" style="width: 100px">原密码</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <input id="oldPassword" name="oldPassword" class="form-input-inner-d" type="text" autocomplete="off"
                           placeholder="请输入原密码">
                </div>
            </div>
        </div>

        <div class="form-item-d">
            <label for="newPassword" class="form-item-label-d" style="width: 100px">新密码</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <input id="newPassword" name="newPassword" class="form-input-inner-d" type="text" autocomplete="off"
                           placeholder="请输入新密码">
                </div>
            </div>
        </div>

        <div class="form-item-d">
            <label for="rePassword" class="form-item-label-d" style="width: 100px">确认密码</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <input id="rePassword" name="rePassword" class="form-input-inner-d" type="text" autocomplete="off"
                           placeholder="请输入确认新密码">
                </div>
            </div>
        </div>

        <button class="layui-btn layui-btn-normal" style="margin-top: 10px; margin-left: 40%"
                type="button" onclick="updatePassword()">确认修改
        </button>
    </form>
</div>
</body>
<script type="text/javascript">
    function updatePassword() {
        $.ajax({
            url: "../../user/user/updatePassword",
            type: "POST",
            dataType: "JSON",
            data: {
                oldPassword: $('#oldPassword').val(),
                newPassword: $('#newPassword').val(),
                rePassword: $('#rePassword').val()
            }, success: function (data) {
                if (data.code === 200) {
                    layer.msg("修改密码成功,请重新登录", {icon: 1, time: 1500}, function () {
                        notifyParentPage();
                    });
                } else if (data.code === -1 || data.code === -2) {
                    layer.msg(data.message, {icon: 2});
                }
            }, error: function () {
                layer.msg("访问修改密码接口失败");
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
