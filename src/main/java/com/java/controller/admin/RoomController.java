package com.java.controller.admin;

import com.github.pagehelper.PageInfo;
import com.java.service.RoomService;
import com.java.utils.SMSUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * description：客房管理模块
 * author：丁鹏
 * date：08:21
 */
@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    /**
     * 点击客房信息查询时，跳转至此页面
     * @return
     */
    @RequestMapping("/toRoomListPage.do")
    public String toRoomListPage(Model model){
        List<Map<String, Object>> roomList = roomService.findRoom();
        model.addAttribute("roomList",roomList);
        return "/pages/admin/room/roomList.jsp";
    }

    /**
     * 点击客房型信息管理时，跳转至此页面
     * @return
     */
    @RequestMapping("/toRoomTypeListPage.do")
    public String toRoomTypeListPage(@RequestParam(defaultValue = "1") Integer pageNum,
                                     @RequestParam(defaultValue = "5") Integer pageSize,
                                     Model model){
        List<Map<String, Object>> roomTypeList = roomService.findRoomType(pageNum, pageSize);
        PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(roomTypeList);
        model.addAttribute("pageInfo",pageInfo);
        return "/pages/admin/room/roomTypeList.jsp";
    }

    /**
     * 校验房间类型名是否满足要求
     * @param roomTypeName
     * @return
     */
    @RequestMapping("/validateRoomTypeName.do")
    public @ResponseBody boolean validateRoomTypeName(String roomTypeName){
        return roomService.findRoomTypeNameIsExist(roomTypeName);
    }

    /**
     * 添加房型到数据库中去
     * @param roomTypeName
     * @param price
     * @return
     */
    @RequestMapping("/addRoomType")
    public @ResponseBody boolean addRoomType(String roomTypeName,String price){
        try {
            return roomService.saveRoomType(roomTypeName,price);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     *获取房型
     * @return
     */
    @RequestMapping("/getRoomType.do")
    public @ResponseBody List<Map<String,Object>> getRoomType(){
        return roomService.findRoomTypeList();
    }

    /**
     * 添加房间
     * @param roomNum
     * @param roomStatus
     * @param roomTypeId
     * @return
     */
    @RequestMapping("/addRoom.do")
    public @ResponseBody boolean addRoom(String roomNum,String roomStatus,Long roomTypeId){
        return roomService.saveRoom(roomNum,roomStatus,roomTypeId);
    }

    /**
     * 发送短信，提醒保洁人员收拾指定的房间
     * @param smsText
     * @param phone
     * @return
     */
    @RequestMapping("/sendDsSMS.do")
    public @ResponseBody boolean sendDsSMS(String smsText,String phone){
        System.out.println("smsText="+smsText+",phone="+phone);
        int i = SMSUtil.sendSMS(smsText, phone);
        return i>0;
    }

    /**
     * 修改房间状态
     * @param roomStatus
     * @param roomNum
     * @return
     */
    @RequestMapping("/updateRoomStatusByRoomNum.do")
    public @ResponseBody boolean updateRoomStatusByRoomNum(String roomStatus,String roomNum){
        return roomService.modifyRoomStatusByRoomNum(roomStatus,roomNum);
    }

}
