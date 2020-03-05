package com.java.pojo;

import lombok.Data;

import java.util.List;

/**
 * description：一级菜单
 * author：丁鹏
 * date：15:31
 */
@Data
public class OneMenu {
    private Long oneId;//一级菜单主键
    private String oneName;//一级菜单名
    private List<TwoMenu> twoMenuList;//二级菜单集合
	public Long getOneId() {
		return oneId;
	}
	public void setOneId(Long oneId) {
		this.oneId = oneId;
	}
	public String getOneName() {
		return oneName;
	}
	public void setOneName(String oneName) {
		this.oneName = oneName;
	}
	public List<TwoMenu> getTwoMenuList() {
		return twoMenuList;
	}
	public void setTwoMenuList(List<TwoMenu> twoMenuList) {
		this.twoMenuList = twoMenuList;
	}
	@Override
	public String toString() {
		return "OneMenu [oneId=" + oneId + ", oneName=" + oneName + ", twoMenuList=" + twoMenuList + "]";
	}
    
    
}
