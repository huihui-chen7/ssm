package com.java.controller.admin;

import com.github.pagehelper.PageInfo;
import com.java.exceptions.UpdateInRoomInfoException;
import com.java.pojo.InRoomInfo;
import com.java.service.InRoomInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：10:13
 */
@Controller
@RequestMapping("/inroominfo")
public class InRoomInfoController {
    @Autowired
    private InRoomInfoService inRoomInfoService;

    /**
     * 跳转到入住信息列表页面，同时带数据过去
     * @return
     */
    @RequestMapping("/toInRoomInfo.do")
    public String toInRoomInfo(@RequestParam(defaultValue = "0") String flag,
                               String value,
                               @RequestParam(defaultValue = "1") Integer pageNum,
                               @RequestParam(defaultValue = "10") Integer pageSize,
                               Model model){
        //调用业务层
        List<Map<String, Object>> inRoomInfoList = inRoomInfoService.findInRoomInfo(flag, value, pageNum, pageSize);
        //跳转页面
        PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(inRoomInfoList);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("flag",flag);
        model.addAttribute("value",value);
        return "/pages/admin/bill/inroominfo.jsp";
    }

    /**
     * 修改执行id的入住信息记录
     * @param id
     * @return
     */
    @RequestMapping("/updateInRoomInfoById")
    public @ResponseBody boolean updateInRoomInfoById(Long id){
        return inRoomInfoService.modifyInRoomInfoById(id);
    }

    /**
     * 批量修改指定id的入住信息记录
     * @param idStr
     * @return
     */
    @RequestMapping("/batchUpdateInRoomInfo.do")
    public @ResponseBody boolean batchUpdateInRoomInfo(String idStr){
        return inRoomInfoService.modifyBatchUpdateInRoomInfo(idStr);
    }

    /**
     * 查询所有空闲房间
     * @return
     */
    @RequestMapping("/getKXRoom.do")
    public @ResponseBody List<Map<String,Object>> getKXRoom(){
        return inRoomInfoService.findKXRoom();
    }

    /**
     * 修改房间入住信息
     * @param oldRoomNum
     * @param iriId
     * @param phone
     * @param room_id
     * @return
     */
    @RequestMapping("/updateInRoomInfo.do")
    public @ResponseBody boolean updateInRoomInfo(String oldRoomNum,Long iriId, String phone, Long room_id){
        try {
            inRoomInfoService.modifyInRoomInfo(oldRoomNum,iriId,phone,room_id);
            return true;
        } catch (UpdateInRoomInfoException e) {
            return false;
        }
    }

    /***
     * 点击入住信息添加按钮，跳转到checkin.jsp页面
     * @return
     */
    @RequestMapping("/toCheckInPage.do")
    public String toCheckInPage(Model model){
        List<Map<String, Object>> roomList = inRoomInfoService.findKXRoom();
        model.addAttribute("roomList",roomList);
        return "/pages/admin/bill/checkin.jsp";
    }

    /**
     * 根据vip编号获取客户信息
     * @param vipNum
     * @return
     */
    @RequestMapping("/getCustomerInfoByVipNum.do")
    public @ResponseBody Map<String,Object> getCustomerInfoByVipNum(String vipNum){
        return inRoomInfoService.findCustomerInfoByVipNum(vipNum);
    }

    /**
     * 添加入住信息
     * @return
     */
    @RequestMapping("/addInRoomInfo.do")
    public String addInRoomInfo(@Valid InRoomInfo info, BindingResult br,Model model){
        //判断数据格式是否有错误
        boolean flag = br.hasErrors();
        if(flag){//格式有错
            //取出错误信息
            List<FieldError> errorList = br.getFieldErrors();
            //声明一个Map集合用来封装全部的错误信息
            Map<String,Object> errorMap = new HashMap<>();
            for(FieldError temp :errorList){
                String fieldName = temp.getField();
                String message = temp.getDefaultMessage();
                errorMap.put(fieldName,message);
            }
            //将错误信息带过去
            model.addAttribute("errorMap",errorMap);
            //将封装有格式正确的数据和格式错误的数据带过去
            model.addAttribute("info",info);
            return "/inroominfo/toCheckInPage.do";
        }else{//格式正确
            //调用业务层，将数据保存到数据库中去
            try {
                inRoomInfoService.saveInRoomInfo(info);
                return "redirect:/inroominfo/toInRoomInfo.do";
            } catch (Exception e) {
                e.printStackTrace();
                return "/inroominfo/toCheckInPage.do";
            }

        }
    }

    /**
     * 点击结账退房时，跳转到out.jsp页面
     * @return
     */
    @RequestMapping("/toOutPage.do")
    public String toOutPage(Model model){
        //调用业务层，查询房间信息
        List<Map<String, Object>> roomList = inRoomInfoService.findRoomInfo();
        //将房间信息带过去
        model.addAttribute("roomList",roomList);
        return "/pages/admin/bill/out.jsp";
    }

    /**
     * 查询退房信息
     * @param roomId
     * @return
     */
    @RequestMapping("/getOutRoomInfoByRoomId.do")
    public @ResponseBody Map<String,Object> getOutRoomInfoByRoomId(Long roomId){
        return inRoomInfoService.findOutInfo(roomId);
    }

    /**
     * 计算退房的账单
     * @param outRoomTime
     * @param roomId
     * @return
     */
    @RequestMapping("/calcOutRoomCost.do")
    public @ResponseBody Map<String,Object> calcOutRoomCost(String outRoomTime,Long roomId){
        return inRoomInfoService.findOutRoomCost(outRoomTime,roomId);
    }

    /**
     * 最终退房
     * @param roomId
     * @return
     */
    @RequestMapping("/finalOutRoom.do")
    public @ResponseBody boolean finalOutRoom(Long roomId){
        try {
            return inRoomInfoService.modifyOutRoom(roomId);
        } catch (Exception e) {
            return false;
        }
    }

}
