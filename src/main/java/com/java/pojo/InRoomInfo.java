package com.java.pojo;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

/**
 * description：
 * author：丁鹏
 * date：08:24
 */
public class InRoomInfo {

    @NotNull(message = "房间主键不能为空")
    @Pattern(regexp = "[1-9]\\d*",message = "房间主键格式错误!")
    private String roomId;//房间主键-正整数
    @NotNull(message = "客人姓名不能为空")
    @Pattern(regexp = "[\\u4e00-\\u9fa5]{2,20}",message = "客人姓名格式错误!")
    private String customerName;//客人姓名
    @NotNull(message = "性别不能为空")
    @Pattern(regexp = "[10]",message = "性别格式错误!")
    private String gender;//性别
    @NotNull(message = "会员选项不能为空")
    @Pattern(regexp = "[10]",message = "会员选项格式错误")
    private String isVip;//是否是会员 1是会员，0不是会员
    //@Pattern(regexp = "\\d{5,8}",message = "会员号格式错误")
    private String vipNum;//会员卡号
    @NotNull(message = "身份证不能为空")
    @Pattern(regexp = "\\d{17}[0-9X]",message = "身份证格式错误")
    private String idcard;//身份证号
    @NotNull(message = "手机号不能为空")
    @Pattern(regexp = "1[356789]\\d{9}",message = "手机号格式错误")
    private String phone;//手机号
    @NotNull(message = "押金不能为空")
    @Pattern(regexp = "[1-9]\\d*.\\d*|0.\\d*[1-9]\\d*|0?.0+|0",message = "押金格式错误")
    private String money;//押金
    private String createDate;//入住时间

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getIsVip() {
        return isVip;
    }

    public void setIsVip(String isVip) {
        this.isVip = isVip;
    }

    public String getVipNum() {
        return vipNum;
    }

    public void setVipNum(String vipNum) {
        this.vipNum = vipNum;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    @Override
    public String toString() {
        return "InRoomInfo{" +
                "roomId='" + roomId + '\'' +
                ", customerName='" + customerName + '\'' +
                ", gender='" + gender + '\'' +
                ", isVip='" + isVip + '\'' +
                ", vipNum='" + vipNum + '\'' +
                ", idcard='" + idcard + '\'' +
                ", phone='" + phone + '\'' +
                ", money='" + money + '\'' +
                ", createDate='" + createDate + '\'' +
                '}';
    }
}
