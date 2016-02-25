package com.repair.common.pojo;

import java.io.Serializable;

public class PJFixFlowRecord implements Serializable {

	private static final long serialVersionUID = -4591238796675491951L;
	/**
	 * 主键（检修流程节点id）
	 */
	private Long recId;
	/**
	 * 配件检修流程
	 */
	private PJFixFlow pjFixFlow;
	/**
	 * 配件检修日计划
	 */
	private PJDatePlan datePlan;
	/**
	 * 动态配件
	 */
	private PJDynamicInfo pjDynamicInfo;
	/**
	 * 班组
	 */
	private DictProTeam team;
	/**
	 * 机务段编号
	 */
	private String jwdCode;
	/**
	 * 完成状态：0未完成；1完成
	 */
	private int status;
	public Long getRecId() {
		return recId;
	}
	public void setRecId(Long recId) {
		this.recId = recId;
	}
	public PJFixFlow getPjFixFlow() {
		return pjFixFlow;
	}
	public void setPjFixFlow(PJFixFlow pjFixFlow) {
		this.pjFixFlow = pjFixFlow;
	}
	public PJDatePlan getDatePlan() {
		return datePlan;
	}
	public void setDatePlan(PJDatePlan datePlan) {
		this.datePlan = datePlan;
	}
	public PJDynamicInfo getPjDynamicInfo() {
		return pjDynamicInfo;
	}
	public void setPjDynamicInfo(PJDynamicInfo pjDynamicInfo) {
		this.pjDynamicInfo = pjDynamicInfo;
	}
	public DictProTeam getTeam() {
		return team;
	}
	public void setTeam(DictProTeam team) {
		this.team = team;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
