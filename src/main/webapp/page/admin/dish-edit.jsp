<%--
  Created by IntelliJ IDEA.
  User: Holary
  Date: 2023/11/27
  Time: 17:48
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
            <label for="name" class="form-item-label-d" style="width: 100px">菜品名称</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <input id="name" name="name" class="form-input-inner-d" type="text" autocomplete="off"
                           value="${dish.name}" placeholder="请输入菜品名称">
                </div>
            </div>
        </div>

        <div class="layui-form layui-row layui-col-space16" style="margin-top: 25px">
            <div class="layui-col-md6" style="display: flex">
                <label for="categoryName" class="form-item-label-d" style="width: 100px">菜品分类</label>
                <select id="categoryName" name="categoryName"></select>
            </div>
        </div>

        <div class="layui-form layui-row layui-col-space16" style="margin-top: 25px">
            <div class="layui-col-md6" style="display: flex">
                <label for="status" class="form-item-label-d" style="width: 100px">菜品状态</label>
                <select id="status" name="status">
                    <c:if test="${dish.status == 1}">
                        <option value="上架" selected>上架</option>
                        <option value="下架">下架</option>
                    </c:if>
                    <c:if test="${dish.status == 0}">
                        <option value="上架">上架</option>
                        <option value="下架" selected>下架</option>
                    </c:if>
                </select>
            </div>
        </div>

        <div class="form-item-d" style="margin-top: 30px">
            <label for="price" class="form-item-label-d" style="width: 100px">菜品价格</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <input id="price" name="price" class="form-input-inner-d" type="text" autocomplete="off"
                           value="${dish.price}" placeholder="请输入菜品价格">
                </div>
            </div>
        </div>

        <div class="form-item-d" style="margin-top: 30px">
            <label class="form-item-label-d" style="width: 100px">菜品图片</label>
            <div class="form-item-content-d">
                <div class="layui-upload-drag" style="display: block; width: 100px;height: 100px"
                     id="upload-dish-image">
                    <div id="upload-dish-image-preview">
                        <img src="${dish.image}" alt="图片访问失败"
                             style="width: 100%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
                    </div>
                </div>
            </div>
        </div>

        <div class="form-item-d" style="margin-top: 30px">
            <label for="description" class="form-item-label-d" style="width: 100px">菜品描述</label>
            <div class="form-item-content-d">
                <div class="form-input-d">
                    <textarea id="description" name="description" class="form-input-inner-d" type="text"
                              autocomplete="off" tabindex="0" placeholder="请输入菜品描述"
                              style="height: 100px">${dish.description}</textarea>
                </div>
            </div>
        </div>

        <div class="form-item-content-d" style="margin-left: 30px">
            <button class="layui-btn layui-btn-normal"
                    type="button" onclick="editDish()">修改
            </button>
            <button class="layui-btn layui-btn-primary"
                    type="button" onclick="notifyParentPage()">取消
            </button>
        </div>
    </form>
</div>
</body>
<script>
    $(document).ready(function () {
        // 页面加载时获取分类列表
        getCategoryList();
    });

    // 获取分类
    function getCategoryList() {
        $.ajax({
            url: "/admin/category/list",
            type: "GET",
            dataType: "JSON",
            success: function (data) {
                // 清空原有的选项
                $("#categoryName").empty().append();
                // 添加默认选项
                $("#categoryName").append('<option value="">请选择</option>');
                let categoryList = data.list;
                for (let i = 0; i < categoryList.length; i++) {
                    if (categoryList[i].id === ${dish.categoryId}) {
                        $("#categoryName").append('<option selected value="' + categoryList[i].id + '">' + categoryList[i].name + '</option>');
                    } else {
                        $("#categoryName").append('<option value="' + categoryList[i].id + '">' + categoryList[i].name + '</option>');
                    }
                }
                // 刷新select渲染
                layui.form.render('select');
            }, error: function () {
                layer.msg("访问分类接口失败");
            }
        });
    }

    // 图片上传
    layui.use(function () {
        let upload = layui.upload;
        let $ = layui.$;
        // 渲染
        upload.render({
            elem: '#upload-dish-image',
            url: '/file/upload',
            done: function (data) {
                layer.msg('上传成功');
                // 展示图片
                $('#upload-dish-image-preview').find('img').attr('src', data.url);
            }
        });
    });

    // 编辑菜品
    function editDish() {
        // 获取表单数据
        let id = ${dish.id};
        let name = $('#name').val();
        let categoryId = $('#categoryName').val();
        let status = $('#status').val();
        let price = $('#price').val();
        let image = $('#upload-dish-image-preview img').attr('src');
        let description = $('#description').val();

        // status转换
        if (status === '上架') {
            status = 1;
        } else if (status === '下架') {
            status = 0;
        } else {
            status = null;
        }

        // 构造dish对象
        let dish = {
            id: id,
            name: name,
            categoryId: categoryId,
            status: status,
            price: price,
            image: image,
            description: description
        }

        $.ajax({
            url: "/admin/dish/update",
            type: "PUT",
            dataType: "JSON",
            data: JSON.stringify(dish),
            contentType: 'application/json;charset=utf-8',
            success: function (data) {
                if (data.code === 200) {
                    layer.msg(data.message, {icon: 1, time: 1000}, function () {
                        notifyParentPage();
                    });
                } else if (data.code === -1 || data.code === -2 || data.code === -3 || data.code === -4) {
                    layer.msg(data.message, {icon: 2});
                }
            }, error: function () {
                layer.msg('访问修改菜品接口失败', function () {
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
