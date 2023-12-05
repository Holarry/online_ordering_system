<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/12/5
  Time: 15:39
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
        <span>菜单</span>
    </div>
    <hr>
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <%--模糊查询--%>
            <div class="like-query">
                <span>菜品名称 : </span>
                <label for="name">
                    <input type="text" placeholder="请输入菜品名称" id="name" autocomplete="off"
                           class="layui-input"
                           style="margin-right: 20px;">
                </label>
                <span>分类 : </span>
                <label for="categoryName">
                    <select id="categoryName" style="margin-right: 25px;">
                    </select>
                </label>
                <button class="layui-btn layui-btn-normal" type="button" style="margin-bottom: 5px;margin-left: 25px"
                        onclick="selectDishByCondition()">
                    <i class="layui-icon layui-icon-search"></i>
                </button>
                <button class="layui-btn layui-btn-primary layui-border-blue" type="button"
                        style="margin-bottom: 5px;" onclick="clearSelected()">
                    重置
                </button>
            </div>
        </form>
    </div>
    <div id="menu-container"></div>
</div>
</body>
<script>
    $(document).ready(function () {
        // 获取分类
        getCategoryList();

        // 查询菜品
        selectDishByCondition();
    });

    // 获取分类
    function getCategoryList() {
        $.ajax({
            url: "/admin/category/list",
            type: "GET",
            dataType: "JSON",
            success: function (data) {
                console.log(data);
                // 清空原有的选项
                $("#categoryName").empty().append();
                // 添加默认选项
                $("#categoryName").append('<option value="">请选择</option>');
                let categoryList = data.list;
                for (let i = 0; i < categoryList.length; i++) {
                    $("#categoryName").append('<option value="' + categoryList[i].id + '">' + categoryList[i].name + '</option>');
                }
                // 刷新select渲染
                layui.form.render('select');
            }, error: function (err) {
                console.log(err);
                layer.msg("访问分类接口失败!");
            }
        });
    }

    // 查询菜品
    function selectDishByCondition() {
        const menuContainer = $("#menu-container");

        // 清空原有内容
        menuContainer.empty();

        // 使用Ajax从后端获取菜品数据
        $.ajax({
            url: "/user/dish/list",
            method: "GET",
            dataType: "JSON",
            data: {
                name: $("#name").val(),
                categoryId: $("#categoryName").val()
            }, success: function (data) {
                if (data.code === 200) {
                    renderDishList(data.dishList);
                } else {
                    layer.msg("查询数据失败!", {icon: 5});
                }
            }, error: function (err) {
                console.log(err);
                layer.msg("访问菜品接口失败!", {icon: 5});
            }
        });

        // 渲染菜品数据到页面
        function renderDishList(dishList) {
            dishList.forEach(dish => {
                const dishContainer = $("<div>").addClass("menu-item");

                const image = $("<img>").attr("src", dish.image).attr("alt", "图片未找到");

                const detailsContainer = $("<div>").addClass("menu-item-details");

                const name = $("<p>").text('菜品名称: ' + dish.name);
                const category = $("<p>").text('菜品分类: ' + dish.categoryName);
                const price = $("<p>").text('菜品价格: ￥' + dish.price.toFixed(2));
                const description = $("<p>").text('菜品描述: ' + dish.description);

                const addToCartButton = $('<button type="button" onclick="addShoppingCart()">')
                    .html('<i class="layui-icon layui-icon-cart-simple"></i>加入购物车');

                detailsContainer.append(name, category, price, description, addToCartButton);
                dishContainer.append(image).append(detailsContainer);
                menuContainer.append(dishContainer);
            });
        }
    }

    // 重置
    function clearSelected() {
        // 清空输入框
        $("#name").val('');
        // 清空分类选择框
        $("#categoryName").val("");
        $("form")[0].reset();
        selectDishByCondition();
    }

    // 加入购物车
    function addShoppingCart() {

    }
</script>
</html>
