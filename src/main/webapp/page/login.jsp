<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/10/3
  Time: 21:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录 | 开饭啦</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8"/>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../static/style/bootstrap.css">
    <link rel="stylesheet" href="../static/style/login.css">
    <link rel="stylesheet" href="../static/style/common.css">
    <link rel="stylesheet" href="../static/style/icon/iconfont.css">
    <link rel="stylesheet" href="../static/style/xadmin.css">
    <script type="text/javascript" src="../static/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../static/lib/layui-2.8.18/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../static/js/xadmin.js"></script>
</head>

<body>
<div class="login">
    <div class="login-box">
        <img src="../static/images/login.jpg" alt="图片未找到">
        <div class="login-form">
            <form>
                <div class="login-form-title">
                    <img src="../static/images/logo.png" style="width:139px;height:45px;" alt="图片未找到">
                </div>
                <div>
                    <label for="username">
                        <input type="text" class="el-input__inner" id="username" name="username"
                               onblur="checkUsername(this.value);" autocomplete="off" placeholder="用户名"
                               maxlength="10">
                    </label>
                    <br>
                    <span id="checkUserNameResult" style="color: red;font-size: small"></span>
                </div>
                <div>
                    <label for="password">
                        <input type="password" class="el-input__inner" id="password" name="password"
                               onblur="checkPassword(this.value);" placeholder="密码" maxlength="16">
                    </label>
                    <br>
                    <span id="checkPasswordResult" style="color: red;font-size: small"></span>
                </div>

                <input class="login-btn" value="登录" type="button" style="width:100%;" onclick="login()">
                <div style="float: right; margin-top: 15px">
                    <a style="font-size: 14px;font-weight: 500" href="../sys/goRegister">注册 →</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function login() {
        $.ajax({
            url: "../login",
            dataType: "JSON",
            type: "POST",
            data: {
                username: $("#username").val(),
                password: $("#password").val(),
            }, success: function (data) {
                console.log(data);
                if (data.code === 200) {
                    layer.msg("登录成功!", {icon: 6, time: 1000}, function () {
                        location.href = "/sys/goIndex";
                    });
                } else if (data.code === -1 || data.code === -2 || data.code === -3) {
                    layer.msg(data.message, {icon: 5});
                }
            }, error: function () {
                layer.msg("访问登录接口失败!", {icon: 5}, function () {
                    location.reload();
                });
            }
        })
    }

    // 校验用户名
    function checkUsername(obj) {
        let checkUserNameResult = document.getElementById("checkUserNameResult");
        if (obj.trim().length === 0) {
            checkUserNameResult.innerHTML = "用户名不能为空";
            obj.focus();
        } else {
            checkUserNameResult.innerHTML = "";
        }
    }

    // 校验密码
    function checkPassword(obj) {
        let checkPasswordResult = document.getElementById("checkPasswordResult");
        if (obj.trim().length === 0) {
            checkPasswordResult.innerHTML = "密码不能为空";
            obj.focus();
        } else {
            checkPasswordResult.innerHTML = "";
        }
    }
</script>
</body>
</html>
