<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/12/12
  Time: 16:48
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
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8"/>
    <link rel="stylesheet" href="../../static/style/orderDetail.css">
    <link rel="stylesheet" href="../../static/style/font.css">
    <link rel="stylesheet" href="../../static/style/xadmin.css">
    <link rel="stylesheet" href="../../static/lib/layui-2.8.18/css/layui.css">
    <script type="text/javascript" src="../../static/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../../static/lib/layui-2.8.18/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../static/js/xadmin.js"></script>
</head>
<body>
<div class="info-box">
    <c:forEach var="orderDetail" items="${orderDetailList}" varStatus="loop">
        <c:if test="${loop.index == 0}">
            <div class="item-box">
                <span class="label">订单号: </span>
                <span class="des">${orderDetail.orderNumber}</span>
            </div>
            <c:if test="${orderDetail.status == 0}">
                <div class="item-box">
                    <span class="label">订单状态: </span>
                    <span class="des">已取消</span>
                </div>
            </c:if>
            <c:if test="${orderDetail.status == 1}">
                <div class="item-box">
                    <span class="label">订单状态: </span>
                    <span class="des">已下单</span>
                </div>
            </c:if>
            <c:if test="${orderDetail.status == 2}">
                <div class="item-box">
                    <span class="label">订单状态: </span>
                    <span class="des">派送中</span>
                </div>
            </c:if>
            <c:if test="${orderDetail.status == 3}">
                <div class="item-box">
                    <span class="label">订单状态: </span>
                    <span class="des">已确认</span>
                </div>
            </c:if>
            <c:if test="${orderDetail.status == 4}">
                <div class="item-box">
                    <span class="label">订单状态: </span>
                    <span class="des">已完成</span>
                </div>
            </c:if>
            <div class="item-box">
                <span class="label">下单用户: </span>
                <span class="des">${orderDetail.username}</span>
            </div>
            <div class="item-box">
                <span class="label">菜品信息: </span>
            </div>
        </c:if>
        <div class="item-box">
            <span class="des" style="margin-left: 96px;">${orderDetail.dishName}
                &nbsp;&nbsp;&nbsp;x${orderDetail.number}
                &nbsp;&nbsp;&nbsp;￥${orderDetail.dishPrice}</span>
        </div>
        <c:if test="${loop.index == orderDetailList.size() - 1}">
            <div class="item-box">
                <span class="label">订单时间: </span>
                <span class="des"><fmt:formatDate
                        value="${orderDetail.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </span>
            </div>
            <c:if test="${orderDetail.status == 1}">
                <button style="margin-top: 10px" type="button"
                        onclick="updateOrderStatus(${orderDetail.orderNumber}, ${orderDetail.status})"
                        class="layui-btn layui-btn-normal">取消订单
                </button>
            </c:if>
            <c:if test="${orderDetail.status == 2}">
                <button style="margin-top: 10px" type="button"
                        onclick="updateOrderStatus(${orderDetail.orderNumber}, ${orderDetail.status})"
                        class="layui-btn layui-btn-normal">确认收货
                </button>
            </c:if>
        </c:if>
    </c:forEach>
</div>
</body>
<script type="text/javascript">
    function updateOrderStatus(orderNumber, status) {
        if (status === 1) {
            // 在取消订单时弹出确认框
            layer.confirm('您确认取消订单吗?', {icon: 3, title: '提示'}, function (index) {
                // 确认取消
                doUpdateOrderStatus(orderNumber, status);
                // 关闭确认框
                layer.close(index);
            });
        } else {
            doUpdateOrderStatus(orderNumber, status);
        }
    }

    // 修改订单状态
    function doUpdateOrderStatus(orderNumber, status) {
        $.ajax({
            url: "../../user/order/updateOrderStatus",
            type: "POST",
            dataType: "JSON",
            data: {
                orderNumber: orderNumber,
                status: status
            }, success: function (data) {
                if (data.code === 200) {
                    layer.msg(data.message, {icon: 1, time: 1000}, function () {
                        notifyParentPage();
                    });
                } else if (data.code === -1 || data.code === -2) {
                    layer.msg(data.message, {icon: 2});
                }
            }, error: function () {
                layer.msg("访问修改订单状态接口失败", function () {
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
