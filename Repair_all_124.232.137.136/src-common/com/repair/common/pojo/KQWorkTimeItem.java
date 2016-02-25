package com.repair.common.pojo;

import java.io.Serializable;

public class KQWorkTimeItem implements Serializable{

	/**
	 * 班组任务表
	 */
	private static final long serialVersionUID = -786029553179257293L;

	public Long id;
	//班组
	public DictProTeam proteam;
	//任务工分
	public Integer itemScore;
	//任务名
	public String itemName;
	//是否启用	1 启用 0 不启用
	public Integer isused;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public DictProTeam getProteam() {
		return proteam;
	}
	public void setProteam(DictProTeam proteam) {
		this.proteam = proteam;
	}
	public Integer getItemScore() {
		return itemScore;
	}
	public void setItemScore(Integer itemScore) {
		this.itemScore = itemScore;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public Integer getIsused() {
		return isused;
	}
	public void setIsused(Integer isused) {
		this.isused = isused;
	}
}
