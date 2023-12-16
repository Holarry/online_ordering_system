<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/12/14
  Time: 18:10
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
    <link rel="stylesheet" href="../../static/style/person-info.css">
    <link rel="stylesheet" href="../../static/style/list.css">
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
    <div class="header-d">
        <span>个人中心</span>
        <%--修改密码--%>
        <button class="layui-btn layui-btn-normal"
                type="button" onclick="openUpdatePassword()">修改密码
        </button>
    </div>
    <hr>
    <div class="body-d">
        <form class="form-d">
            <div class="form-item-d">
                <label for="username" class="form-item-label-d" style="width: 100px">用户名称</label>
                <div class="form-item-content-d">
                    <div class="form-input-d">
                        <input id="username" name="username" class="form-input-inner-d" type="text" autocomplete="off"
                               value="${user.username}" placeholder="请输入用户名">
                    </div>
                </div>
            </div>

            <div class="form-item-d" style="margin-top: 25px">
                <label for="age" class="form-item-label-d" style="width: 100px">用户年龄</label>
                <div class="form-item-content-d">
                    <div class="form-input-d">
                        <input id="age" name="age" class="form-input-inner-d" type="number" autocomplete="off"
                               value="${user.age}" placeholder="请输入年龄">
                    </div>
                </div>
            </div>

            <div class="layui-form layui-row layui-col-space16" style="margin-top: 5px">
                <div style="display: flex">
                    <label for="gender" class="form-item-label-d" style="width: 100px">用户性别</label>
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

            <div class="form-item-d" style="margin-top: 20px">
                <label for="phone" class="form-item-label-d" style="width: 100px">手机号码</label>
                <div class="form-item-content-d">
                    <div class="form-input-d">
                        <input id="phone" name="phone" class="form-input-inner-d" type="text" autocomplete="off"
                               value="${user.phone}" placeholder="请输入手机号码">
                    </div>
                </div>
            </div>

            <div class="form-item-d" style="margin-top: 25px">
                <label for="createTime" class="form-item-label-d" style="width: 100px">注册时间</label>
                <div class="form-item-content-d">
                    <div class="form-input-d">
                        <input id="createTime" name="createTime" class="form-input-inner-d" type="text"
                               value="<fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                               autocomplete="off" disabled>
                    </div>
                </div>
            </div>

            <button class="layui-btn layui-btn-normal" style="margin-left: 100px" type="button"
                    onclick="updatePersonalInfo()">提交修改
            </button>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    // 用户修改个人信息
    function updatePersonalInfo() {
        // 获取表单数据
        let id = ${user.id};
        let username = $('#username').val();
        let age = $('#age').val();
        let gender = $('#gender').val();
        let phone = $('#phone').val();

        // 构造user对象
        let user = {
            id: id,
            username: username,
            age: age,
            gender: gender,
            phone: phone
        }

        $.ajax({
            url: "../../user/user/update",
            type: "POST",
            dataType: "JSON",
            data: JSON.stringify(user),
            contentType: 'application/json;charset=utf-8',
            success: function (data) {
                if (data.code === 200) {
                    layer.msg(data.message, {icon: 1, time: 1000}, function () {
                        location.reload();
                    });
                } else if (data.code === -1 || data.code === -2) {
                    layer.msg(data.message, {icon: 2});
                }
            }, error: function () {
                layer.msg("访问修改用户信息接口失败")
            }
        });
    }

    // 打开修改密码弹窗
    function openUpdatePassword() {
        layer.open({
            type: 2,
            title: '修改密码',
            area: ['500px', '300px'],
            content: "../../sys/goUpdatePassword"
        });
    }

    // addDishSuccessCallback 函数
    function addDishSuccessCallback() {
        // 关闭抽屉
        layer.closeAll();
        // 退出登录
        logout();
    }

    // 退出登录
    function logout() {
        $.ajax({
            url: "../../logout",
            type: "POST",
            success: function () {
                window.parent.location.href = "../sys/goLogin";
            },
            error: function () {
                layer.msg("退出登录失败");
            }
        });
    }
</script>
</html>
