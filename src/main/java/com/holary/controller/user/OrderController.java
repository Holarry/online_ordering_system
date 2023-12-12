package com.holary.controller.user;

import com.holary.dto.OrderDetailDto;
import com.holary.entity.Order;
import com.holary.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/12/9 14:45
 * @Description: OrderController
 */
@RequestMapping("/user/order")
@Controller("userOrderController")
public class OrderController {
    @Autowired
    private OrderService orderService;

    /**
     * description: 提交订单
     *
     * @param order: order对象
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/submitOrder")
    @ResponseBody
    public Map<String, Object> submitOrder(@RequestBody Order order) {
        return orderService.submitOrder(order);
    }

    /**
     * description: 用户条件查询订单
     *
     * @param orderNumber: 订单号
     * @param status:      订单状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list(String orderNumber, Integer status) {
        return orderService.list1(orderNumber, status);
    }

    /**
     * description: 用户查询订单详情
     *
     * @param orderNumber: 订单号
     * @param model:       Model
     * @return: java.lang.String
     */
    @RequestMapping("/getOrderDetail")
    public String getOrderDetail(String orderNumber, Model model) {
        List<OrderDetailDto> orderDetailList = orderService.getOrderDetailByUserId(orderNumber);
        model.addAttribute("orderDetailList", orderDetailList);
        return "user/orderDetail";
    }
}
