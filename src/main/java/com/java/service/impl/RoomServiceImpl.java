package com.java.service.impl;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.java.mapper.RoomMapper;
import com.java.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：08:28
 */
@Service
@Transactional(readOnly = false)
public class RoomServiceImpl implements RoomService{
    @Autowired
    private RoomMapper roomMapper;

    @Override
    public List<Map<String, Object>> findRoom() {
        return roomMapper.selectRoom();
    }

    @Override
    public List<Map<String, Object>> findRoomType(Integer pageNum,Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        return roomMapper.selectRoomType();
    }

    @Override
    public boolean findRoomTypeNameIsExist(String roomTypeName) {
        if(StrUtil.isNullOrUndefined(roomTypeName) || StrUtil.isBlank(roomTypeName)){
            return false;//校验失败
        }
        return roomMapper.selectRoomTypeNameIsExist(roomTypeName.trim())==1?false:true;
    }

    @Override
    public boolean saveRoomType(String roomTypeName, String price) {
        if(StrUtil.isBlank(price) || StrUtil.isNullOrUndefined(price) || StrUtil.isBlank(roomTypeName) || StrUtil.isNullOrUndefined(roomTypeName)){
            return  false;
        }
        if(!price.matches("[1-9]\\d*.\\d*|0.\\d*[1-9]\\d*|0?.0+|0")){
            return false;
        }
        return roomMapper.insertRoomType(roomTypeName,price)==1;
    }

    @Override
    public List<Map<String, Object>> findRoomTypeList() {
        return roomMapper.selectRoomType();
    }

    @Override
    public boolean saveRoom(String roomNum, String roomStatus, Long roomTypeId) {
        //1、校验数据
        if(StrUtil.isBlank(roomNum) || StrUtil.isNullOrUndefined(roomNum) || StrUtil.isBlank(roomStatus) || StrUtil.isNullOrUndefined(roomNum)){
            return false;
        }
        if(!roomStatus.matches("[02]"))
            return false;
        //2、判断指定的房间号是否存在
        int flag = roomMapper.selectRoomIsExistByRoomNum(roomNum);
        if(flag!=0){
            return false;
        }
        //3、插入
        return roomMapper.insertRoom(roomNum,roomStatus,roomTypeId)==1;
    }

    @Override
    public boolean modifyRoomStatusByRoomNum(String roomStatus, String roomNum) {
        return roomMapper.updateRoomStatusByRoomNum(roomStatus,roomNum)==1;
    }

}
