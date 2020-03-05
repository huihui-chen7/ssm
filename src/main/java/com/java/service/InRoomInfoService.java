package com.java.service;

import com.java.exceptions.CalcDaysException;
import com.java.exceptions.UpdateInRoomInfoException;
import com.java.pojo.InRoomInfo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：10:21
 */
public interface InRoomInfoService {
    List<Map<String,Object>> findInRoomInfo(String flag, String value,Integer pageNum,Integer pageSize);

    boolean modifyInRoomInfoById(Long id);

    /**
     * 批量修改入住信息记录的显示状态
     * @param idStr
     * @return
     */
    boolean modifyBatchUpdateInRoomInfo(String idStr);

    /**
     * 查找出所有空闲房间
     * @return
     */
    List<Map<String,Object>> findKXRoom();

    /**
     * 修改入住信息
     * @param iriId
     * @param phone
     * @param room_id
     * @return
     */
    boolean modifyInRoomInfo(String oldRoomNum,Long iriId,String phone,Long room_id) throws UpdateInRoomInfoException;

    /**
     * 根据vip编号获取客户信息
     * @param vipNum
     * @return
     */
    Map<String,Object> findCustomerInfoByVipNum(String vipNum);

    /**
     * 添加入住信息
     * @param inRoomInfo
     * @return
     */
    boolean saveInRoomInfo(InRoomInfo inRoomInfo) throws Exception;

    /**
     * 查询已经入住的信息房间信息
     * @return
     */
    List<Map<String,Object>> findRoomInfo();

    /**
     * 查询退房客户信息
     * @param roomId
     * @return
     */
    Map<String,Object> findOutInfo(Long roomId);

    /**
     * 计算退房账单
     * @param roomId
     * @param iriId
     * @return
     */
    Map<String,Object> findOutRoomCost(String outRoomTime,Long roomId);

    boolean modifyOutRoom(Long roomId) throws Exception;
}
