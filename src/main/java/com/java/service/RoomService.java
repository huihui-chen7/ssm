package com.java.service;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：08:28
 */
public interface RoomService {

    List<Map<String,Object>> findRoom();

    List<Map<String,Object>> findRoomType(Integer pageNum,Integer pageSize);

    boolean findRoomTypeNameIsExist(String roomTypeName);

    boolean saveRoomType(String roomTypeName,String price);

    List<Map<String,Object>> findRoomTypeList();

    boolean saveRoom(String roomNum,String roomStatus,Long roomTypeId);

    boolean modifyRoomStatusByRoomNum(String roomStatus,String roomNum);

}
