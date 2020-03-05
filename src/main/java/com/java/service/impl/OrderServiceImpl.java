package com.java.service.impl;

import com.github.pagehelper.PageHelper;
import com.java.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * description：
 * author：丁鹏
 * date：09:17
 */
@Service
@Transactional(readOnly = false)
public class OrderServiceImpl implements com.java.service.OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public List<Map<String,Object>> findOrders(Integer pageNum, Integer pageSize, String flag, String value){
        PageHelper.startPage(pageNum,pageSize);
        return orderMapper.selectOrders(flag,value);
    }

    @Override
    public Map<String, Object> findInRoomInfoByRoomNum(String roomNum) {
        return orderMapper.selectInRoomInfoByRoomNum(roomNum);
    }

    @Override
    public boolean saveOrder(Map<String, Object> paramMap) {
        Long iriId = orderMapper.selectIriIdByRoomNum((String) paramMap.get("room_num"));
        if(iriId==null){
            return false;
        }
        //将iriId保存进Map集合中
        paramMap.put("iriId",iriId);
        //生成订单编号
        paramMap.put("order_num", UUID.randomUUID().toString());
        //保存数据
        int i = orderMapper.insertOrder(paramMap);
        return i==1;
    }


}
