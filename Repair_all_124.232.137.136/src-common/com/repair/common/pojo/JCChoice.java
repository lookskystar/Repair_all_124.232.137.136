package com.repair.common.pojo;

import java.io.Serializable;
/**
 * 质检、技术管辖车
 * @author Administrator
 *
 */
public class JCChoice implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//主键ID
	private int choiceId;
	//日计划ID
	private DatePlanPri dpId;
	//用户ID
	private UsersPrivs userId;
	
	public int getChoiceId() {
		return choiceId;
	}
	public void setChoiceId(int choiceId) {
		this.choiceId = choiceId;
	}
	public DatePlanPri getDpId() {
		return dpId;
	}
	public void setDpId(DatePlanPri dpId) {
		this.dpId = dpId;
	}
	public UsersPrivs getUserId() {
		return userId;
	}
	public void setUserId(UsersPrivs userId) {
		this.userId = userId;
	}
}
