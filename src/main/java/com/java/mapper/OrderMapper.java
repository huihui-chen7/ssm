package com.java.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：08:55
 */
public interface OrderMapper {

    /**
     * 动态查询订单信息
     * @return
     */
    List<Map<String,Object>> selectOrders(@Param("flag") String flag,@Param("value") String value);

    /**
     * 根据房间号查询正则入住的客人信息
     * @param roomNum
     * @return
     */
    @Select("SELECT * FROM in_room_info WHERE room_id=\n" +
            "(SELECT id AS roomId FROM rooms WHERE room_num=#{0} LIMIT 1)\n" +
            "AND out_room_status='0'")
    Map<String,Object> selectInRoomInfoByRoomNum(String roomNum);

    /**
     * 根据房间号查询出正在入住的客人信息
     * @param roomNum
     * @return
     */
    @Select("SELECT id AS iriId FROM in_room_info \n" +
            "WHERE room_id= (SELECT id AS roomId FROM rooms WHERE room_num=#{0} LIMIT 1) \n" +
            "AND out_room_status='0' LIMIT 1")
    Long selectIriIdByRoomNum(String roomNum);

    /**
     * 添加订单信息
     * @param paramMap
     * @return
     */
    @Insert("INSERT INTO orders VALUES(NULL,#{order_num},#{money},#{remark},#{order_status},#{iriId},NOW(),'1')")
    int insertOrder(Map<String,Object> paramMap);

}
