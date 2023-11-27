<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/11/20
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
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
            <label for="username" class="layui-form-label">用户名</label>
            <div class="layui-input-inline">
                <input type="text" id="username" name="username" autocomplete="off" class="layui-input"
                       disabled value="${user.username}">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="age" class="layui-form-label">年龄</label>
            <div class="layui-input-inline">
                <input type="number" id="age" name="age" autocomplete="off" class="layui-input"
                       value="${user.age}" min="0" max="120">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="gender" class="layui-form-label">性别</label>
            <div class="layui-input-inline">
                <select id="gender" name="gender">
                    <c:if test="${user.gender == '男' || user.gender == null}">
                        <option value="男" selected>男</option>
                        <option value="女">女</option>
                    </c:if>
                    <c:if test="${user.gender == '女'}">
                        <option value="男">男</option>
                        <option value="女" selected>女</option>
                    </c:if>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="phone" class="layui-form-label">手机号</label>
            <div class="layui-input-inline">
                <input type="text" id="phone" name="phone" autocomplete="off" class="layui-input"
                       value="${user.phone}">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="status" class="layui-form-label">状态</label>
            <div class="layui-input-inline">
                <select id="status" name="status">
                    <c:if test="${user.status == 1}">
                        <option value="正常" selected>正常</option>
                        <option value="禁用">禁用</option>
                    </c:if>
                    <c:if test="${user.status == 0}">
                        <option value="正常">正常</option>
                        <option value="禁用" selected>禁用</option>
                    </c:if>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label"></label>
            <input type="button" id="L_repass" class="layui-btn-primary" value="修改"
                   onclick="editUser()">
        </div>
    </form>
</div>
<script>
    function editUser() {
        // 获取表单数据
        let id = ${user.id};
        let username = $('#username').val();
        let age = $('#age').val();
        let gender = $('#gender').val();
        let phone = $('#phone').val();
        let status = $('#status').val();

        // 转换status
        if (status === '正常') {
            status = 1
        } else {
            status = 0;
        }

        // 构造用户对象
        let user = {
            id: id,
            username: username,
            age: parseInt(age),
            gender: gender,
            phone: phone,
            status: status
        };
        $.ajax({
            url: '/admin/user/update',
            data: JSON.stringify(user),
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            success: function (data) {
                console.log(data);
                if (data.code === 200) {
                    layer.msg(data.message, {icon: 6, time: 1000}, function () {
                        closeDialog();
                    });
                } else if (data.code === -1 || data.code === -2 || data.code === -3 || data.code === -4) {
                    layer.msg(data.message, {icon: 5});
                }
            }, error() {
                layer.msg("访问修改用户接口失败!", {icon: 5}, function () {
                    location.reload();
                })
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
</body>
</html>
