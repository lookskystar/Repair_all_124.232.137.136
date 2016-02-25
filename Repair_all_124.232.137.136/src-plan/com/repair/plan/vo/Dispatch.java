package com.repair.plan.vo;

public class Dispatch {
	// 班组Id
	private String bzIds;
	
	/**
	 * 项目卡控人员：0-交车工长不控；1-交车工长卡控
	 */
	private Integer itemCtrlComLd;
	/**
	 * 项目卡控人员：0-质检员不控；1-质检员卡控
	 */
	private Integer itemCtrlQI;
	/**
	 * 项目卡控人员：0-技术员不控；1-技术员卡控
	 */
	private Integer itemCtrlTech;
	/**
	 * 项目卡控人员：0-验收员不控；1-验收员卡控
	 */
	private Integer itemCtrlAcce;

	public String getBzIds() {
		return bzIds;
	}

	public void setBzIds(String bzIds) {
		this.bzIds = bzIds;
	}

	public Integer getItemCtrlComLd() {
		return itemCtrlComLd;
	}

	public void setItemCtrlComLd(Integer itemCtrlComLd) {
		this.itemCtrlComLd = itemCtrlComLd;
	}

	public Integer getItemCtrlQI() {
		return itemCtrlQI;
	}

	public void setItemCtrlQI(Integer itemCtrlQI) {
		this.itemCtrlQI = itemCtrlQI;
	}

	public Integer getItemCtrlTech() {
		return itemCtrlTech;
	}

	public void setItemCtrlTech(Integer itemCtrlTech) {
		this.itemCtrlTech = itemCtrlTech;
	}

	public Integer getItemCtrlAcce() {
		return itemCtrlAcce;
	}

	public void setItemCtrlAcce(Integer itemCtrlAcce) {
		this.itemCtrlAcce = itemCtrlAcce;
	}
}
