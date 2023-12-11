package com.holary.controller.admin;

import com.holary.dto.OrderDetailDto;
import com.holary.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/12/10 16:47
 * @Description: OrderController
 */
@Controller("adminOrderController")
@RequestMapping("/admin/order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    /**
     * description: 订单分页查询和条件查询
     *
     * @param pageNum:     页码
     * @param pageSize:    条数
     * @param orderNumber: 订单号
     * @param consignee:   收货人
     * @param status:      状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list(int pageNum, int pageSize, String orderNumber, String consignee, Integer status) {
        return orderService.list(pageNum, pageSize, orderNumber, consignee, status);
    }

    /**
     * description: 根据订单号查询订单详情
     *
     * @param orderNumber: 订单号
     * @param model:       Model
     * @return: java.lang.String
     */
    @RequestMapping("/getOrderDetail")
    public String getOrderDetail(String orderNumber, Model model) {
        List<OrderDetailDto> orderDetailList = orderService.getOrderDetail(orderNumber);
        model.addAttribute("orderDetailList", orderDetailList);
        return "admin/orderDetail";
    }

    /**
     * description: 根据订单号修改订单状态
     *
     * @param orderNumber: 订单号
     * @param status:      订单状态
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/updateOrderStatus")
    @ResponseBody
    public Map<String, Object> updateOrderStatus(String orderNumber, Integer status) {
        return orderService.updateOrderStatus(orderNumber, status);
    }
}
