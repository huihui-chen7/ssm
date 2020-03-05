package com.java.pojo;

import lombok.Data;

/**
 * description：二级菜单
 * author：丁鹏
 * date：15:31
 */
@Data
public class TwoMenu {
    private Long twoId;//二级菜单主键
    private String twoName;//二级菜单名
    private String twoUrl;//二级菜单跳转地址
	public Long getTwoId() {
		return twoId;
	}
	public void setTwoId(Long twoId) {
		this.twoId = twoId;
	}
	public String getTwoName() {
		return twoName;
	}
	public void setTwoName(String twoName) {
		this.twoName = twoName;
	}
	public String getTwoUrl() {
		return twoUrl;
	}
	public void setTwoUrl(String twoUrl) {
		this.twoUrl = twoUrl;
	}
	@Override
	public String toString() {
		return "TwoMenu [twoId=" + twoId + ", twoName=" + twoName + ", twoUrl=" + twoUrl + "]";
	}
    
}
