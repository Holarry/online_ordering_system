<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/12/7
  Time: 20:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="../../static/style/user-dish-list.css">
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
        <span>购物车</span>
        <%--清空购物车--%>
        <button style="margin-bottom: 10px; margin-right: 35px"
                class="layui-btn layui-btn-primary layui-border"
                type="button" onclick="confirmClearShoppingCart()">
            <i class="layui-icon layui-icon-clear"></i>清空购物车
        </button>
    </div>
    <hr>
    <table class="layui-table-d layui-table">
        <thead>
        <tr>
            <th>编号</th>
            <th>菜品名称</th>
            <th>菜品图片</th>
            <th>菜品价格</th>
            <th>菜品数量</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="tab"></tbody>
        <tr id="totalAmountRow">
            <td colspan="6" style="align-items: flex-end;">
                <span style="margin-left: 920px; margin-right: 10px; font-family: 'Microsoft YaHei', sans-serif; font-size: 14px"
                      id="totalAmount">总金额：0.00元
                </span>
                <button style="margin-left: auto;" class="layui-btn layui-btn-normal" onclick="submitOrder()">提交订单
                </button>
            </td>
        </tr>
    </table>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        selectShoppingCart();
    });

    // 查询购物车
    function selectShoppingCart() {
        let count = 1;
        $.ajax({
            url: "../user/shoppingCart/list",
            type: "GET",
            dataType: "JSON",
            data: {},
            success: function (data) {
                if (data.code === 200) {
                    let shoppingCartList = data.shoppingCartList;
                    if (shoppingCartList.length > 0) {
                        let str = '';
                        for (let i = 0; i < shoppingCartList.length; i++) {
                            str += '<tr>' +
                                '<td>' + (count++) + '</td>' +
                                '<td>' + shoppingCartList[i].dishName + '</td>' +
                                '<td><img src="' + shoppingCartList[i].dishImage + '" style="width: 100%" alt="图片未找到"/></td>' +
                                '<td>' + shoppingCartList[i].price + '元' + '</td>' +
                                '<td>' +
                                '<button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="decrementDishNumber(' + shoppingCartList[i].dishId + ')">-</button>' +
                                '<span style="margin-right: 8px"></span>' +
                                '<span class="quantity">' + shoppingCartList[i].number + '</span>' +
                                '<span style="margin-right: 8px"></span>' +
                                '<button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="incrementDishNumber(' + shoppingCartList[i].dishId + ')">+</button>' +
                                '</td>' +
                                '<td class="td-manage">' +
                                '<button type="button" class="layui-btn layui-btn-sm layui-btn-danger" onclick="deleteDish(' + shoppingCartList[i].dishId + ')"><i class="layui-icon layui-icon-delete"></i></button>' +
                                '</td>' +
                                '</tr>';
                        }
                        $("#tab").html(str);

                        // 显示总金额和提交订单按钮
                        $("#totalAmountRow").show();
                        // 计算购物车总金额
                        calculateTotalAmount();
                    } else {
                        $("#tab").html('<tr><td colspan="6" align="center">什么都没有!</td></tr>');
                        // 隐藏总金额和提交订单按钮
                        $("#totalAmountRow").hide();
                    }
                }
            }, error: function () {
                layer.msg("访问购物车接口失败!");
            }
        });
    }

    // 增加菜品数量
    function incrementDishNumber(dishId) {
        updateDishNumber(dishId, 1);
    }

    // 减少菜品数量
    function decrementDishNumber(dishId) {
        updateDishNumber(dishId, -1);
    }

    // 更新购物车中菜品数量
    function updateDishNumber(dishId, quantity) {
        $.ajax({
            url: "/user/shoppingCart/updateNumber",
            method: "POST",
            dataType: "JSON",
            data: {
                dishId: dishId,
                quantity: quantity
            }, success: function (data) {
                if (data.code === 200) {
                    selectShoppingCart();
                } else {
                    layer.msg(data.message, {icon: 2});
                }
            }, error: function () {
                layer.msg("访问更新购物车接口失败!", function () {
                    location.reload();
                });
            }
        });
    }

    // 计算购物车中菜品的总金额
    function calculateTotalAmount() {
        $.ajax({
            url: "../user/shoppingCart/calculateTotalAmount",
            type: "GET",
            dataType: "JSON",
            data: {},
            success: function (data) {
                if (data.code === 200) {
                    $("#totalAmount").text("总计: " + data.totalAmount.toFixed(2) + "元");
                }
            }, error: function () {
                layer.msg("访问计算总金额接口失败!", function () {
                    location.reload();
                });
            }
        });
    }

    // 删除购物车中的菜品
    function deleteDish(dishId) {
        $.ajax({
            url: "../user/shoppingCart/deleteShoppingCartDish",
            type: "POST",
            dataType: "JSON",
            data: {
                dishId: dishId
            }, success: function (data) {
                if (data.code === 200) {
                    layer.msg(data.message, {icon: 1, time: 1000}, function () {
                        location.reload();
                    });
                }
            }, error: function () {
                layer.msg("访问删除购物车菜品接口失败!", function () {
                    location.reload();
                });
            }
        });
    }

    // 确认清空购物车
    function confirmClearShoppingCart() {
        layer.confirm('您确定要清空购物车吗?', {
            btn: ['确定', '取消'],
            icon: 3,
            title: '提示'
        }, function (index) {
            // 确定执行清空购物车操作
            clearShoppingCart();
            // 关闭确认框
            layer.close(index);
        }, function (index) {
            // 点击取消关闭确认框
            layer.close(index);
        });
    }

    // 清空购物车
    function clearShoppingCart() {
        $.ajax({
            url: "../user/shoppingCart/clearShoppingCart",
            type: "POST",
            dataType: "JSON",
            data: {},
            success: function (data) {
                if (data.code === 200) {
                    layer.msg("清空购物车成功!", {icon: 1, time: 1000}, function () {
                        location.reload();
                    });
                }
            }, error: function () {
                layer.msg("访问清空购物车接口失败!", function () {
                    location.reload();
                });
            }
        });
    }

    // 打开提交订单弹窗
    function submitOrder() {
        layer.open({
            type: 2,
            title: '确认订单',
            area: ['500px', '450px'],
            content: ['/sys/goSubmitOrder', 'no']
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
