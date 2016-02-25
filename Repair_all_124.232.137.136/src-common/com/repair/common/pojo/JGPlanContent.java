package com.repair.common.pojo;

import java.io.Serializable;

public class JGPlanContent implements Serializable {

	private static final long serialVersionUID = 1186815065891511960L;
	/**
	 * 主键 id
	 * */
	private long id;
	/**
	 * 加改项目
	 * */
	private String jgContent;
	/**
	 * 计划台数
	 * */
	private int planNum;
	/**
	 * 车型
	 * */
	private String jcType;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getJgContent() {
		return jgContent;
	}

	public void setJgContent(String jgContent) {
		this.jgContent = jgContent;
	}

	public int getPlanNum() {
		return planNum;
	}

	public void setPlanNum(int planNum) {
		this.planNum = planNum;
	}

	public String getJcType() {
		return jcType;
	}

	public void setJcType(String jcType) {
		this.jcType = jcType;
	}
}
