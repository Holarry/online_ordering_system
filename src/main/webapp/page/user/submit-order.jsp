<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/12/8
  Time: 20:36
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
            <label for="consignee" class="form-item-label-d" style="width: 100px">收货人</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <input id="consignee" name="consignee" class="form-input-inner-d" type="text" autocomplete="off"
                           placeholder="请输入收货人">
                </div>
            </div>
        </div>

        <div class="form-item-d">
            <label for="phone" class="form-item-label-d" style="width: 100px">手机号</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <input id="phone" name="phone" class="form-input-inner-d" type="text" autocomplete="off"
                           placeholder="请输入手机号">
                </div>
            </div>
        </div>

        <div class="form-item-d">
            <label for="address" class="form-item-label-d" style="width: 100px">地址</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <input id="address" name="address" class="form-input-inner-d" type="text" autocomplete="off"
                           placeholder="请输入地址">
                </div>
            </div>
        </div>

        <div class="form-item-d" style="margin-top: 30px">
            <label for="remark" class="form-item-label-d" style="width: 100px">备注</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <textarea id="remark" name="remark" class="form-input-inner-d" type="text"
                              autocomplete="off" tabindex="0" placeholder="请输入备注"
                              style="height: 100px"></textarea>
                </div>
            </div>
        </div>

        <div class="form-item-content-d" style="float: right">
            <span style="margin-right: 10px; font-family: 'Microsoft YaHei', sans-serif; font-size: 14px"
                  id="totalAmount">总计：0.00元
            </span>
            <button class="layui-btn layui-btn-normal"
                    type="button" onclick="submitOrder()">提交订单
            </button>
        </div>
    </form>
</div>
</body>
<script type="text/javascript">
    let shoppingCartList;
    let totalAmount;

    $(document).ready(function () {
        calculateTotalAmount();
    });

    // 计算购物车中菜品的总金额
    function calculateTotalAmount() {
        $.ajax({
            url: "../user/shoppingCart/calculateTotalAmount",
            type: "GET",
            dataType: "JSON",
            data: {},
            success: function (data) {
                if (data.code === 200) {
                    totalAmount = data.totalAmount;
                    $("#totalAmount").text("总计: " + data.totalAmount.toFixed(2) + "元");
                }
            }, error: function () {
                layer.msg("访问计算总金额接口失败!", function () {
                    location.reload();
                });
            }
        });
    }

    // 查询购物车
    function selectShoppingCart() {
        $.ajax({
            url: "../user/shoppingCart/list",
            type: "GET",
            dataType: "JSON",
            data: {},
            success: function (data) {
                if (data.code === 200) {
                    shoppingCartList = data.shoppingCartList;
                }
            }, error: function () {
                layer.msg("访问购物车接口失败!", function () {
                    location.reload();
                });
            }
        });
    }

    // 提交订单
    function submitOrder() {
        // 获取表单数据
        let consignee = $('#consignee').val();
        let consigneePhone = $('#phone').val();
        let address = $('#address').val();
        let amount = totalAmount;
        let remark = $('#remark').val();

        // 构造order对象
        let order = {
            consignee: consignee,
            consigneePhone: consigneePhone,
            address: address,
            amount: amount,
            remark: remark
        }

        $.ajax({
            url: "../user/order/submitOrder",
            type: "POST",
            dataType: "JSON",
            data: JSON.stringify(order),
            contentType: 'application/json;charset=utf-8',
            success: function (data) {
                if (data.code === 200) {
                    layer.msg(data.message, {icon: 1, time: 1000}, function () {
                        notifyParentPage();
                    });
                } else if (data.code === -1 || data.code === -2 || data.code === -3 || data.code === -4 || data.code === -5) {
                    layer.msg(data.message, {icon: 2});
                }
            }, error: function () {
                layer.msg("访问提交订单接口失败!", function () {
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
