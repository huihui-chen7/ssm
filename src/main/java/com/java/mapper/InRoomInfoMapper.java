package com.java.mapper;

import com.java.pojo.InRoomInfo;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：10:13
 */
public interface InRoomInfoMapper {

    /**
     * 根据条件查询入住信息
     * @return
     */
    List<Map<String,Object>> selectInRoomInfo(@Param("flag") String flag,@Param("value") String value);

    /**
     * 修改指定id的入住信息记录
     * @param id
     * @return
     */
    @Update("update in_room_info set status='0' where id = #{0}")
    int updateInRoomInfoById(Long id);

    /**
     * 批量修改入住信息记录的显示状态
     * @param idStr
     * @return
     */
    @Update("UPDATE in_room_info SET STATUS='0' WHERE id IN(${idStr})")
    int batchUpdateInRoomInfo(@Param("idStr") String idStr);

    /**
     * 查找出所有空闲房间
     * @return
     */
    @Select("SELECT * FROM rooms WHERE room_status='0'")
    List<Map<String,Object>> selectKXRoom();

    /**
     * 修改入住信息
     * @param iriId
     * @param phone
     * @param room_id
     * @return
     */
    @Update("UPDATE in_room_info SET room_id=#{2},phone=#{1} WHERE id=#{0}")
    int updateInRoomInfoStatus(Long iriId,String phone,Long room_id);

    /**
     * 修改房间状态
     * @param room_status
     * @param room_id
     * @return
     */
    @Update("UPDATE rooms SET room_status=#{0} WHERE id=#{1}")
    int updateRoomStatus(String room_status,Long room_id);

    /**
     * 根据房间号修改房间状态
     * @param room_status
     * @param room_num
     * @return
     */
    @Update("UPDATE rooms SET room_status=#{0} WHERE room_num=#{1}")
    int updateRoomStatusByRoomNum(String room_status,String room_num);

    /**
     * 根据vip查询客户信息
     * @param vipNum
     * @return
     */
    @Select("SELECT * FROM vip WHERE vip_num=#{0} LIMIT 1")
    Map<String,Object> selectCustomerInfoByVipNum(String vipNum);

    /**
     * 添加入住信息
     * @param info
     * @return
     */
    @Insert("INSERT INTO in_room_info VALUES(NULL,#{customerName},#{gender},#{isVip},#{idcard},#{phone},#{money},#{createDate},#{roomId},'1','0')")
    int insertInRoomInfo(InRoomInfo info);

    /**
     * 判断指定的vip号码是否存在
     * @param vipNum
     * @return
     */
    @Select("SELECT COUNT(*) FROM vip WHERE vip_num=#{0}")
    int selectIsVip(String vipNum);

    /**
     * 查询已经入住的信息房间信息
     * @return
     */
    @Select("SELECT rm.`id` AS roomId,rm.`room_num`,rt.`room_price`,rt.`room_type_name` \n" +
            "FROM rooms rm INNER JOIN room_type rt \n" +
            "ON rt.id=rm.room_type_id WHERE rm.room_status='1'")
    List<Map<String,Object>> selectRoomInfo();

    /**
     * 根据房间id查询一套退房的客户信息
     * @param roomId
     * @return
     */
    @Select("SELECT iri.`customer_name`,rt.`room_price`,iri.`money`,\n" +
            "DATE_FORMAT(iri.`create_date`,'%Y-%m-%d %H:%i:%s') AS create_date\n" +
            "FROM in_room_info iri INNER JOIN rooms rm ON\n" +
            "iri.`room_id`=rm.`id` INNER JOIN room_type rt ON\n" +
            "rt.`id`=rm.`room_type_id` WHERE iri.`room_id`=#{0}\n" +
            "AND iri.`out_room_status`='0' AND rm.`room_status`='1' LIMIT 1")
    Map<String,Object> selectOutRoomInfo(Long roomId);

    /**
     * 查询要退房的客户为支付的总金额
     * @param roomId
     * @return
     */
    @Select("SELECT SUM(order_money) AS order_cost FROM orders WHERE iri_id=\n" +
            "(SELECT id AS iriId FROM in_room_info WHERE room_id=#{0} AND out_room_status='0')\n" +
            "AND order_status='0' LIMIT 1")
    Float selectOutWZFMoney(Long roomId);

    /**
     * 查询是否是vip
     * @param iriId
     * @return
     */
    @Select("SELECT is_vip,money,DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') AS create_date FROM in_room_info WHERE id=#{0}")
    Map<String,Object> selectVipInfo(Long iriId);

    /**
     * 获取入住客人的折扣率
     * @param iriId
     * @return
     */
    @Select("SELECT v.vip_rate FROM in_room_info iri INNER JOIN vip v \n" +
            "ON iri.idcard=v.idcard WHERE iri.id=#{0}")
    Float selectVipRate(Long iriId);

    /**
     * 获取某个房间的单价
     * @param roomId
     * @return
     */
    @Select("SELECT rt.room_price FROM rooms rm INNER JOIN room_type rt\n" +
            "ON rm.room_type_id=rt.id WHERE rm.id=#{roomId}")
    Float selectRoomPrice(Long roomId);

    /**
     * 获取用户订单总消费金额
     * @param iriId
     * @return
     */
    @Select("SELECT IFNULL(SUM(order_money),0) FROM orders WHERE iri_id=#{0} AND order_status='0'")
    Float selectOrderCost(Long iriId);

    /**
     * 根据房间id获取入住信息id
     * @param roomId
     * @return
     */
    @Select("SELECT id FROM in_room_info WHERE room_id=#{0} AND out_room_status='0' LIMIT 1")
    Long selectIriId(Long roomId);

    /**
     * 退房时，修改入住信息状态:由未退房(0)--->退房(1)
     * @param status
     * @param iriId
     * @return
     */
    @Update("UPDATE in_room_info SET out_room_status=#{0} WHERE id=#{1}")
    int updateInRoomInfoOutRoomStatus(String status,Long iriId);

    /**
     * 退房时，将未支付的订单状态由未支付(0)---->已支付(1)
     * @param iriId
     * @return
     */
    @Update("UPDATE orders SET order_status='1' WHERE iri_id=#{0} AND order_status='0';")
    int updateOrderZFStatus(Long iriId);

}
