package com.java.service;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：09:19
 */
public interface OrderService {
    List<Map<String,Object>> findOrders(Integer pageNum, Integer pageSize, String flag, String value);
    Map<String,Object> findInRoomInfoByRoomNum(String roomNum);

    boolean saveOrder(Map<String,Object> paramMap);
}
