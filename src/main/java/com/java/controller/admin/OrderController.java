package com.java.controller.admin;

import com.github.pagehelper.PageInfo;
import com.java.service.OrderService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * description：订单管理模块
 * author：丁鹏
 * date：08:38
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 点击订单信息按钮时，跳转到信息列表页面，同时带数据过去
     * @return
     */
    @RequestMapping("/toOrderList.do")
    public String toOrderList(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "2") Integer pageSize,
                              @RequestParam(defaultValue = "0") String flag,
                              String value,
                              Model model){
        //`1、调用业务层，查询订单数据
        List<Map<String, Object>> orderList = orderService.findOrders(pageNum, pageSize, flag, value);
        PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(orderList);
        //2、转发带数据
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("flag",flag);
        model.addAttribute("value",value);
        return "/pages/admin/order/orderList.jsp";
    }

    /**
     * 根据房间号查询用户的正在入住的信息
     * @param roomNum
     * @return
     */
    @RequestMapping("/getInRoomInfoByRoomNum.do")
    public @ResponseBody Map<String,Object> getInRoomInfoByRoomNum(String roomNum){
        Map<String, Object> inRoomMap = orderService.findInRoomInfoByRoomNum(roomNum);
        if(inRoomMap==null || inRoomMap.size()==0){
            inRoomMap = new HashMap<>();
            inRoomMap.put("ok","0");//数据不存在
            return inRoomMap;
        }
        inRoomMap.put("ok","1");//存在
        return inRoomMap;
    }

    /**
     * 添加订单
     * @param paramMap
     * @return
     */
    @RequestMapping("/addOrder.do")
    public @ResponseBody boolean addOrder(@RequestParam Map<String,Object> paramMap){
        //1、对提交过来的数据进行校验
        //2、调用业务层
        return orderService.saveOrder(paramMap);
    }

}
