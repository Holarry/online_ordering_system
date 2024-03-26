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
    <style>
        /* 自定义按钮样式 */
        .switch-buttons {
            position: absolute;
            top: 2px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 9999;
        }

        .switch-buttons button {
            margin-right: 2px;
        }

        /* 标签页样式 */
        .tab {
            display: none;
        }

        .tab.active {
            display: block;
        }
    </style>
</head>
<body>
<div class="body-d">
    <form class="form-d">
        <!-- 左上角的切换按钮 -->
        <div class="switch-buttons">
            <button class="layui-btn layui-btn-warm layui-btn-radius" onclick="switchTab('takeaway')"
                    data-tab="takeaway">外卖
            </button>
            <button class="layui-btn layui-btn-primary layui-btn-radius" onclick="switchTab('dinein')"
                    data-tab="dinein">堂食
            </button>
        </div>
        <!-- 外卖标签页 -->
        <div class="tab active" id="takeaway" style="margin-top: 25px">
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
        </div>

        <!-- 堂食标签页 -->
        <div class="tab" id="dinein" style="margin-top: 25px">
            <div class="form-item-d">
                <label for="tableNumber" class="form-item-label-d" style="width: 100px">桌号</label>
                <div class="form-item-content-d">
                    <div class="form-input-d">
                        <input id="tableNumber" name="tableNumber" class="form-input-inner-d" type="number"
                               autocomplete="off" placeholder="请输入桌号">
                    </div>
                </div>
            </div>

            <div class="form-item-d" style="margin-top: 30px">
                <label for="remark1" class="form-item-label-d" style="width: 100px">备注</label>
                <div class="form-item-content-d">
                    <div class="form-input-d">
                    <textarea id="remark1" name="remark1" class="form-input-inner-d" type="text"
                              autocomplete="off" tabindex="0" placeholder="请输入备注"
                              style="height: 100px"></textarea>
                    </div>
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
    let orderType = 0;

    function switchTab(tabName) {
        event.preventDefault();
        // 切换标签页的逻辑
        $('.tab').removeClass('active');
        $('#' + tabName).addClass('active');
        // 移除所有按钮的选中样式
        $('.switch-buttons button').removeClass('layui-btn-warm').addClass('layui-btn-primary');
        // 添加当前按钮的选中样式
        $('button[data-tab="' + tabName + '"]').addClass('layui-btn-warm');
        // 设置订单类型
        orderType = (tabName === 'takeaway') ? 0 : 1;
    }

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
                layer.msg("访问计算总金额接口失败");
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
                layer.msg("访问购物车接口失败");
            }
        });
    }

    // 提交订单
    function submitOrder() {
        // 获取表单数据
        let tableNumber = $('#tableNumber').val();
        let consignee = $('#consignee').val();
        let consigneePhone = $('#phone').val();
        let address = $('#address').val();
        let amount = totalAmount;
        let remark;
        if (orderType === 0) {
            remark = $('#remark').val();
        } else {
            remark = $('#remark1').val();
        }

        // 构造order对象
        let order = {
            orderType: orderType,
            tableNumber: tableNumber,
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
                layer.msg("访问提交订单接口失败", function () {
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
