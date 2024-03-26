<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/12/12
  Time: 15:35
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
    <script type="text/javascript" src="../../static/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../../static/lib/layui-2.8.18/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../static/js/xadmin.js"></script>
</head>
<body>
<div class="x-body">
    <div class="header-d">
        <span>我的订单</span>
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
                <span>订单状态 : </span>
                <label for="status">
                    <select id="status" style="margin-right: 25px;">
                        <option value="">请选择</option>
                        <option value="已取消">已取消</option>
                        <option value="已下单">已下单</option>
                        <option value="派送中">派送中</option>
                        <option value="已确认">已确认</option>
                        <option value="已完成">已完成</option>
                    </select>
                </label>
                <button class="layui-btn layui-btn-normal" type="button" style="margin-bottom: 5px;margin-left: 25px"
                        onclick="selectOrder()">
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
            <th>订单号</th>
            <th>订单类型</th>
            <th>桌号</th>
            <th>收货人</th>
            <th>手机号</th>
            <th>地址</th>
            <th>金额</th>
            <th style="width: 240px">订单时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="tab"></tbody>
    </table>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        selectOrder();
    });

    // 查询订单
    function selectOrder() {
        // 转换status
        let status = $('#status').val();
        if (status === '已取消') {
            status = 0;
        } else if (status === '已下单') {
            status = 1;
        } else if (status === '派送中') {
            status = 2;
        } else if (status === '已确认') {
            status = 3;
        } else if (status === '已完成') {
            status = 4;
        } else {
            status = null;
        }
        $.ajax({
            url: "../user/order/list",
            type: "GET",
            dataType: "JSON",
            data: {
                orderNumber: $("#orderNumber").val(),
                status: status
            }, success: function (data) {
                if (data.code === 200) {
                    let orderList = data.orderList;
                    if (orderList.length > 0) {
                        let str = '';
                        for (let i = 0; i < orderList.length; i++) {
                            /*let status;
                            if (orderList[i].status === 0) {
                                status = '已取消';
                            } else if (orderList[i].status === 1) {
                                status = '已下单';
                            } else if (orderList[i].status === 2) {
                                status = '派送中';
                            } else if (orderList[i].status === 3) {
                                status = '已确认';
                            } else if (orderList[i].status === 4) {
                                status = '已完成';
                            }*/
                            let orderType = '';
                            let tableNumber = '';
                            let consignee = '';
                            let consigneePhone = '';
                            let address = '';
                            if (orderList[i].orderType === 0) {
                                orderType = '外卖';
                            } else if (orderList[i].orderType === 1) {
                                orderType = '堂食';
                            } else {
                                orderType = '类型错误';
                            }
                            if (orderList[i].tableNumber == null) {
                                tableNumber = '无';
                            } else {
                                tableNumber = orderList[i].tableNumber;
                            }
                            if (orderList[i].consignee === '') {
                                consignee = '无';
                            } else {
                                consignee = orderList[i].consignee;
                            }
                            if (orderList[i].consigneePhone === '') {
                                consigneePhone = '无';
                            } else {
                                consigneePhone = orderList[i].consigneePhone;
                            }
                            if (orderList[i].address === '') {
                                address = '无';
                            } else {
                                address = orderList[i].address;
                            }
                            str += '<tr>' +
                                '<td>' + orderList[i].orderNumber + '</td>' +
                                '<td>' + orderType + '</td>' +
                                '<td>' + tableNumber + '</td>' +
                                '<td>' + consignee + '</td>' +
                                '<td>' + consigneePhone + '</td>' +
                                '<td>' + address + '</td>' +
                                '<td>' + orderList[i].amount + '元' + '</td>' +
                                '<td>' + orderList[i].orderTime + '</td>' +
                                '<td class="td-manage">' +
                                '<button type="button" class="layui-btn layui-btn-sm layui-btn-normal" onclick="orderDetail(' + orderList[i].orderNumber + ')">更多</button>' +
                                '</td>' +
                                '</tr>';
                        }
                        $("#tab").html(str);
                    } else {
                        $("#tab").html('<tr><td colspan="9" align="center">没有订单信息!</td></tr>');
                    }
                }
            }, error() {
                layer.msg("访问查询订单接口失败");
            }
        });
    }

    // 打开订单详情
    function orderDetail(orderNumber) {
        let url = '../user/order/getOrderDetail?orderNumber=' + orderNumber;
        layer.open({
            type: 2,
            title: '订单详情',
            area: ['500px', '450px'],
            content: url
        });
    }

    // 重置
    function clearSelected() {
        // 清空输入框
        $("#orderNumber").val('');
        // 清空选择框
        $("#status").val("");
        $("form")[0].reset();
        selectOrder();
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
