package com.java.utils;


import cn.hutool.core.date.DateUtil;
import com.java.exceptions.CalcDaysException;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

/**
 * description：时间工具类
 * author：丁鹏
 * date：11:15
 */
public class DateTool {

    public static long calcDays(String inRoomTime,String outRoomTime) throws ParseException, CalcDaysException {
        //判断inRoomTime与outRoomTime是否为null
        if(inRoomTime==null || outRoomTime==null){
            throw new CalcDaysException("时间参数不能为null");
        }
        //判断时间格式是否满足要求
        if(!inRoomTime.matches("\\d{4}-\\d{1,2}-\\d{1,2} \\d{1,2}:\\d{1,2}:\\d{1,2}") || !outRoomTime.matches("\\d{4}-\\d{1,2}-\\d{1,2} \\d{1,2}:\\d{1,2}:\\d{1,2}")){
            throw new CalcDaysException("时间格式不正确!!!");
        }
        //计算入住时间与退房时间的天数之差
        Date inRoomDate = new SimpleDateFormat("yyyy-MM-dd").parse(inRoomTime);
        Date outRoomDate = new SimpleDateFormat("yyyy-MM-dd").parse(outRoomTime);
        long cha = DateUtil.betweenDay(inRoomDate,outRoomDate,false);
        //再比较退房时的时分秒(13:12:12)与12:00:00的关系
        //将退房时间的时分秒转成毫秒
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        long outRoomSec = sdf.parse(outRoomTime.split(" ")[1]).getTime();
        long tempSec = sdf.parse("12:00:00").getTime();
        if(inRoomDate.getTime()==outRoomDate.getTime()){
            cha = 1;
        }else if(outRoomSec-tempSec>0){//退房时间超过中午12点
            cha++;
        }
        return cha;
    }

    public static void main(String[] args) throws CalcDaysException, ParseException {
        long days = DateTool.calcDays("2019-04-22 10:12:12", "2019-04-23 13:14:12");
        System.out.println(days);
    }

}
