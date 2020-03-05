package com.java.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：08:27
 */
public interface RoomMapper {

    /**
     * 查询房间信息
     * @return
     */
    @Select("SELECT rm.`room_num`,rm.`room_status`,rt.`room_type_name`,rt.`room_price` \n" +
            "FROM rooms rm INNER JOIN room_type rt ON rm.room_type_id=rt.id ORDER BY\n" +
            "rm.`room_status` ASC")
    List<Map<String,Object>> selectRoom();

    /**
     * 查询所有房型
     * @return
     */
    @Select("SELECT * FROM room_type")
    List<Map<String,Object>> selectRoomType();

    /**
     * 判断指定的房间类型名是否存在
     * @param roomTypeName
     * @return
     */
    @Select("SELECT COUNT(*) FROM `room_type` WHERE room_type_name=#{0}")
    int selectRoomTypeNameIsExist(String roomTypeName);

    /**
     * 添加房型
     * @param roomTypeName
     * @param price
     * @return
     */
    @Insert("insert into room_type values(null,#{0},#{1})")
    int insertRoomType(String roomTypeName,String price);

    /**
     * 添加房间
     * @param roomNum
     * @param roomStatus
     * @param roomTypeId
     * @return
     */
    @Insert("INSERT INTO rooms VALUES(NULL,#{0},#{1},#{2})")
    int insertRoom(String roomNum,String roomStatus,Long roomTypeId);

    /**
     * 判断指定的房间号是否存在
     * @param roomNum
     * @return
     */
    @Select("SELECT COUNT(*) FROM rooms WHERE room_num=#{0}")
    int selectRoomIsExistByRoomNum(String roomNum);

    /**
     * 根据房间号修改房间状态
     * @param roomStatus
     * @param roomNum
     * @return
     */
    @Update("UPDATE rooms SET room_status=#{0} WHERE room_num=#{1}")
    int updateRoomStatusByRoomNum(String roomStatus,String roomNum);

}
