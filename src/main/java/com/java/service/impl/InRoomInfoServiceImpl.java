package com.java.service.impl;

import com.github.pagehelper.PageHelper;
import com.java.exceptions.CalcDaysException;
import com.java.exceptions.UpdateInRoomInfoException;
import com.java.mapper.InRoomInfoMapper;
import com.java.pojo.InRoomInfo;
import com.java.utils.DateTool;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：10:19
 */
@Service
@Transactional(readOnly = false)//开启事务
public class InRoomInfoServiceImpl implements com.java.service.InRoomInfoService {

    @Autowired
    private InRoomInfoMapper inRoomInfoMapper;

    /**
     * 根据条件查询入住信息
     * @return
     */
    @Override
    public List<Map<String,Object>> findInRoomInfo(String flag, String value,Integer pageNum,Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        return inRoomInfoMapper.selectInRoomInfo(flag,value);
    }

    @Override
    public boolean modifyInRoomInfoById(Long id) {
        return inRoomInfoMapper.updateInRoomInfoById(id)==1;
    }

    @Override
    public boolean modifyBatchUpdateInRoomInfo(String idStr) {//idStr="1,2,3,"
        return inRoomInfoMapper.batchUpdateInRoomInfo(idStr+"0")>=1;
    }

    @Transactional(readOnly = true)
    @Override
    public List<Map<String, Object>> findKXRoom() {
        return inRoomInfoMapper.selectKXRoom();
    }

    @Override
    public boolean modifyInRoomInfo(String oldRoomNum,Long iriId, String phone, Long room_id) throws UpdateInRoomInfoException {
        //1、修改入住信息的
        int flag1 = inRoomInfoMapper.updateInRoomInfoStatus(iriId, phone, room_id);
        //2、将被退的房间由已入住(1)变为打扫(2)
        int flag2 = inRoomInfoMapper.updateRoomStatusByRoomNum("2", oldRoomNum);
        //3、将新房间由空闲(0)变为已经入住(1)
        int flag3 = inRoomInfoMapper.updateRoomStatus("1", room_id);
        if(flag1==1 && flag2==1 && flag3==1){
            return true;
        }else{
            throw new UpdateInRoomInfoException("修改入住信息失败");
        }
    }

    @Override
    public Map<String, Object> findCustomerInfoByVipNum(String vipNum) {
        Map<String,Object> resultMap= new HashMap<>();
        resultMap.put("status","0");//会员存在
        Map<String, Object> vipInfoMap = inRoomInfoMapper.selectCustomerInfoByVipNum(vipNum);
        if(vipInfoMap==null || vipInfoMap.size()==0){//vip不存在
            resultMap.put("status","1");
            return resultMap;
        }
        resultMap.put("vipInfoMap",vipInfoMap);
        return resultMap;
    }

    @Override
    public boolean saveInRoomInfo(InRoomInfo inRoomInfo) throws Exception {
        //1、判断指定的会员是否存在
        int flag1 = inRoomInfoMapper.selectIsVip(inRoomInfo.getVipNum());
        //2、如果会员存在则插入入住信息记录
        inRoomInfo.setIsVip(flag1==1?"1":"0");
        int flag2 = inRoomInfoMapper.insertInRoomInfo(inRoomInfo);
        //3、修改房间的状态(将空闲房间改为已入住状态)
        int flag3 = inRoomInfoMapper.updateRoomStatus("1", Long.parseLong(inRoomInfo.getRoomId()));
        if(flag2==1 && flag3==1){
            return true;
        }else{
            //回滚
            throw new Exception("添加入住信息失败");
        }
    }

    @Transactional(readOnly = true)
    @Override
    public List<Map<String, Object>> findRoomInfo() {
        return inRoomInfoMapper.selectRoomInfo();
    }

    @Override
    public Map<String, Object> findOutInfo(Long roomId) {
        //1、查询退房客户基本信息
        Map<String, Object> resultMap = inRoomInfoMapper.selectOutRoomInfo(roomId);
        //2、查询未支付总金额
        Float money = inRoomInfoMapper.selectOutWZFMoney(roomId);
        if(money==null){
            money=0F;
        }
        //3、拼接结果
        resultMap.put("order_cost",money);
        return resultMap;
    }

    @Override
    public Map<String, Object> findOutRoomCost(String outRoomTime,Long roomId) {
        Map<String,Object> resultMap = new HashMap<>();
        resultMap.put("status","0");//计算账单成功
        try {
            //0根据roomId获取iriId
            Long iriId = inRoomInfoMapper.selectIriId(roomId);
            //1、判断是否是vip
            Map<String, Object> iriMap = inRoomInfoMapper.selectVipInfo(iriId);
            String isVip = (String) iriMap.get("is_vip");
            //2、查询房间单价
            Float roomPrice = inRoomInfoMapper.selectRoomPrice(roomId);
            //3、查询未支付的消费总金额
            Float orderCost = inRoomInfoMapper.selectOrderCost(iriId);
            //4、计算入住的天数
            String inRoomTime = (String) iriMap.get("create_date");
            System.out.println("inRoomTime="+inRoomTime);
            long days = DateTool.calcDays(inRoomTime, outRoomTime);
            //5、获取押金
            Float money = (Float) iriMap.get("money");
            //定义最终结果
            Float cost = 0F;
            if("0".equals(isVip)){//不是会员
                cost=roomPrice*days+orderCost-money;
            }else{//是会员
                //6如果是vip则查询折扣率
                Float vipRate = inRoomInfoMapper.selectVipRate(iriId);
                cost=roomPrice*vipRate*days+orderCost-money;
            }
            resultMap.put("cost",cost);
            return resultMap;
        } catch (Exception e) {
            resultMap.put("status","1");//失败
            return resultMap;
        }
    }

    @Override
    public boolean modifyOutRoom(Long roomId) throws Exception {
        //0、根据roomId查询出入住信息id
        Long iriId = inRoomInfoMapper.selectIriId(roomId);
        //1、修改入住信息表：out_room_status(0)---->1    需要参数：iriId
        int flag1 = inRoomInfoMapper.updateInRoomInfoOutRoomStatus("1", iriId);
        //2、修改房间表状态：room_status(1)---->2   需要参数：roomId
        int flag2 = inRoomInfoMapper.updateRoomStatus("2",roomId);
        //3、如果用户有其他消费：则将orders表中的order_status(0)--->1  需要参数:iriId
        int flag3 = inRoomInfoMapper.updateOrderZFStatus(iriId);
        if(flag1==1 && flag2==1 && flag3>=0){
            return true;
        }else{
            throw  new Exception("最终退房失败!!!");
        }
    }

}
