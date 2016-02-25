package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 检修大部件时部件的子配件记录
 * @author cuisine
 *
 */
public class PJUnitPart implements Serializable {

	private static final long serialVersionUID = -7921433394266321921L;
	/**
	 * 主键
	 */
	private Long upId;
	/**
	 * 配件检修日计划
	 */
	private PJDatePlan datePlan;
	/**
	 * 大部件
	 */
	private PJDynamicInfo parentPJ;
	/**
	 * 子部件（配件）
	 */
	private PJDynamicInfo childPJ;
	/**
	 * 配件出厂编号
	 */
	private String childFacNum;
	/**
	 * 选择配件的人
	 */
	private UsersPrivs user;
	public Long getUpId() {
		return upId;
	}
	public void setUpId(Long upId) {
		this.upId = upId;
	}
	public PJDatePlan getDatePlan() {
		return datePlan;
	}
	public void setDatePlan(PJDatePlan datePlan) {
		this.datePlan = datePlan;
	}
	public PJDynamicInfo getParentPJ() {
		return parentPJ;
	}
	public void setParentPJ(PJDynamicInfo parentPJ) {
		this.parentPJ = parentPJ;
	}
	public PJDynamicInfo getChildPJ() {
		return childPJ;
	}
	public void setChildPJ(PJDynamicInfo childPJ) {
		this.childPJ = childPJ;
	}
	public String getChildFacNum() {
		return childFacNum;
	}
	public void setChildFacNum(String childFacNum) {
		this.childFacNum = childFacNum;
	}
	public UsersPrivs getUser() {
		return user;
	}
	public void setUser(UsersPrivs user) {
		this.user = user;
	}
	
}
