package com.holary.controller.user;

import com.holary.entity.Order;
import com.holary.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/12/9 14:45
 * @Description: OrderController
 */
@RequestMapping("/user/order")
@Controller
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
}
