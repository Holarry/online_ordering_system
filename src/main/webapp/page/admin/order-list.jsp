<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/11/28
  Time: 17:25
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
        <span>订单管理</span>
    </div>
    <hr>
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <%--模糊查询--%>
            <div class="like-query">
                <span>订单号 : </span>
                <label for="orderNumber">
                    <input type="text" placeholder="请输入订单号" id="orderNumber" autocomplete="off"
                           class="layui-input"
                           style="margin-right: 20px;">
                </label>
                <span>收货人 : </span>
                <label for="consignee">
                    <input type="text" placeholder="请输入收货人" id="consignee" autocomplete="off"
                           class="layui-input"
                           style="margin-right: 20px;">
                </label>
                <button class="layui-btn layui-btn-normal" type="button" style="margin-bottom: 5px;margin-left: 25px"
                        onclick="selectOrderByCondition()">
                    <i class="layui-icon layui-icon-search"></i>
                </button>
                <button class="layui-btn layui-btn-primary layui-border-blue" type="button"
                        style="margin-bottom: 5px;" onclick="clearSelected()">
                    重置
                </button>
            </div>
        </form>
    </div>

    <!-- 切换栏 -->
    <div class="status-switch">
        <button class="layui-btn layui-btn-primary" type="button" onclick="selectAll(1, null)">全部</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="selectAll(1, '已下单')">已下单</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="selectAll(1, '派送中')">派送中</button>
        <button class="layui-btn layui-btn-primary" type="button" onclick="selectAll(1, '已完成')">已完成</button>
    </div>
    <table class="layui-table-d layui-table">
        <thead>
        <tr>
            <th>订单号</th>
            <th>收货人</th>
            <th>手机号</th>
            <th>地址</th>
            <th>金额</th>
            <th>备注</th>
            <th>订单状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="tab"></tbody>
        <tr>
            <td colspan="8" align="center">
                <ul class="pagination" id="pagination1"></ul>
            </td>
        </tr>
    </table>
</div>
</body>
<script type="text/javascript">
    // 总页数
    let totalPages = 0;
    // 总条数
    let totalCounts = 0;
    // 当前页
    let currentPage = 0;
    // 订单状态
    let orderStatus;

    // 解决enter键问题
    $(document).ready(function () {
        $(this).keydown(function (e) {
            if (e.which === 13) {
                if ($("#orderNumber").val() !== '' || $("#consignee").val() !== '') {
                    selectOrderByCondition();
                    return false;
                }
            }
        });
    });

    // 页面一加载后就执行, 这里就是查询信息
    $(document).ready(function () {
        // 页面初始化时，默认点击 "全部" 按钮
        $(".status-switch button:first-child").removeClass("layui-btn-primary").addClass("layui-btn-normal");
        page();
    });

    // 切换状态按钮点击事件
    $(".status-switch button").on("click", function () {
        // 移除其他按钮的active样式
        $(".status-switch button").removeClass("layui-btn-normal").addClass("layui-btn-primary");
        // 给当前按钮添加active样式
        $(this).removeClass("layui-btn-primary").addClass("layui-btn-normal");
        orderStatus = $(this).text().trim();
        // 重置分页信息
        totalPages = 0;
        totalCounts = 0;
        currentPage = 0;
        page();
    });

    // 分页
    function page() {
        // 执行全查
        selectAll(1, orderStatus);
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
                selectAll(number, orderStatus);
            }
        });
    }


    //全查
    function selectAll(number, status) {
        if (status === '已下单') {
            status = 1;
        } else if (status === '派送中') {
            status = 2;
        } else if (status === '已完成') {
            status = 3;
        } else {
            status = null;
        }
        $.ajax({
            url: "../admin/order/list",
            dataType: "JSON",
            type: "POST",
            async: false,
            data: {
                pageNum: number,
                pageSize: 8,
                orderNumber: $("#orderNumber").val(),
                consignee: $("#consignee").val(),
                status: status
            }, success: function (data) {
                // 取出返回数据中订单数据
                let orderList = data.paging.list;
                // 判断orderList是否有数据
                if (orderList.length > 0) {
                    totalPages = data.paging.pages;  // 总页数
                    totalCounts = data.paging.total; // 总条数
                    currentPage = data.paging.pageNum;// 当前页
                    //把数据写在页面上
                    let str = ''; // 用str变量拼接字符串
                    for (let i = 0; i < orderList.length; i++) {
                        let status;
                        if (orderList[i].status === 1) {
                            status = '已下单';
                        } else if (orderList[i].status === 2) {
                            status = '派送中';
                        } else if (orderList[i].status === 3) {
                            status = '已完成';
                        }

                        str += '<tr>' +
                            '<td>' + orderList[i].orderNumber + '</td>' +
                            '<td>' + orderList[i].consignee + '</td>' +
                            '<td>' + orderList[i].consigneePhone + '</td>' +
                            '<td>' + orderList[i].address + '</td>' +
                            '<td>' + orderList[i].amount + '元' + '</td>' +
                            '<td>' + orderList[i].remark + '</td>' +
                            '<td>' + status + '</td>' +
                            '<td class="td-manage">' +
                            '<button type="button" class="layui-btn layui-btn-sm layui-btn-normal" onclick="orderDetail(' + orderList[i].orderNumber + ')">更多</button>' +
                            '</td>' +
                            '</tr>';
                    }
                    $("#tab").html(str);
                } else {//没有数据
                    totalPages = 1;
                    totalCounts = 1;
                    currentPage = 1;
                    $("#tab").html('<tr><td colspan="10" align="center">没有订单数据</td></tr>');
                }
            }, error: function () {
                layer.msg("访问订单接口失败!");
            }
        });
    }

    // 条件查询
    function selectOrderByCondition() {
        page();
    }

    // 重置
    function clearSelected() {
        // 清空输入框
        $("#orderNumber").val('');
        $("#consignee").val("");
        $("form")[0].reset();
        selectOrderByCondition();
    }
</script>
</html>
