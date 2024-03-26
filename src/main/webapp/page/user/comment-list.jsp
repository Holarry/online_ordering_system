<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2024/3/26
  Time: 20:56
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
    <script type="text/javascript" src="../../static/lib/layui-2.8.18/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../static/js/xadmin.js"></script>
</head>
<body>
<div class="x-body">
    <div class="header-d">
        <span>留言广场</span>
        <%--留言广场--%>
        <button class="layui-btn layui-btn-normal"
                onclick="x_admin_show('留言','../sys/goCommentAdd',450,300)">
            <i class="layui-icon layui-icon-add-1"></i>我要留言
        </button>
    </div>
    <hr>
    <table class="layui-table-d layui-table">
        <thead>
        <tr>
            <th>编号</th>
            <th>留言用户</th>
            <th>留言内容</th>
            <th>商家回复</th>
            <th>留言时间</th>
            <th>回复时间</th>
        </tr>
        </thead>
        <tbody id="tab"></tbody>
    </table>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        selectComment();
    });

    //查询留言
    function selectComment() {
        $.ajax({
            url: "/admin/comment/list",
            type: "GET",
            dataType: "JSON",
            success: function (data) {
                let commentList = data.list;
                if (commentList.length > 0) {
                    let str = ''; // 用str变量拼接字符串
                    for (let i = 0; i < commentList.length; i++) {
                        let reply;
                        let updateTime;
                        if (commentList[i].reply === '' || commentList[i].reply == null) {
                            reply = '暂无回复';
                            updateTime = '无'
                        } else {
                            reply = commentList[i].reply;
                            updateTime = commentList[i].updateTime;
                        }
                        str += '<tr>' +
                            '<td>' + (i + 1) + '</td>' +
                            '<td>' + commentList[i].username + '</td>' +
                            '<td>' + commentList[i].content + '</td>' +
                            '<td>' + reply + '</td>' +
                            '<td>' + commentList[i].createTime + '</td>' +
                            '<td>' + updateTime + '</td>' +
                            '</tr>';
                    }
                    $("#tab").html(str);
                } else {
                    $("#tab").html('<tr><td colspan="6" align="center">没有留言数据</td></tr>');
                }
            },
            error: function () {
                layer.msg("访问留言接口失败");
            }
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
