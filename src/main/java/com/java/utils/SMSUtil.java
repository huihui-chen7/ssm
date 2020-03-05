package com.java.utils;

import java.util.HashMap;
import java.util.Map;

/**  
 * @Title: http://www.smschinese.cn/api.shtml
 * @date 2011-3-22
 * @version V1.2  
 */
public class SMSUtil {
	
	//用户名
	private static String Uid = "tinybird123ok";
	
	//接口安全秘钥
	private static String Key = "d41d8cd98f00b204e980";
	
	//手机号码，多个号码如13800000000,13800000001,13800000002
	//private static String smsMob = "13800000000";
	
	//短信内容
	//private static String smsText = "验证码：8888";
	
	
	//public static void main(String[] args) {

	/**
	 * 发送短信
	 * @param smsMob  手机号码
	 * @param smsText  短信内容
	 * @return
	 */
	public static int sendSMS(String smsMob,String smsText){
		
		HttpClientUtil client = HttpClientUtil.getInstance();
		
		//UTF发送
		int result = client.sendMsgUtf8(Uid, Key, smsText, smsMob);
		/*if(result>0){
			System.out.println("UTF8成功发送条数=="+result);
		}else{
			System.out.println(client.getErrorMsg(result));
		}*/
		return result;
	}
}
