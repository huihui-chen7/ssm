package com.java.utils;

import cn.hutool.core.date.DateUtil;

import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * description：
 * author：丁鹏
 * date：08:21
 */
public class Demo1Test {
    public static void main(String[] args) throws ParseException {
        String inRoomTime = "2019-04-20 10:12:12";
        String outRoomTime = "2019-04-22 8:12:12";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        long days = DateUtil.betweenDay(sdf.parse(inRoomTime), sdf.parse(outRoomTime), false);
        System.out.println("days="+days);
    }
}
