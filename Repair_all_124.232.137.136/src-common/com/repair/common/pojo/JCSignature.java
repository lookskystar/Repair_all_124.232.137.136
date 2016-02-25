package com.repair.common.pojo;

import java.io.Serializable;
/**
 * 班组质检技术验收员和交车工长 交车签到
 * @author Administrator
 *
 */
public class JCSignature implements Serializable{

	private static final long serialVersionUID = -9125327772387152304L;
	/**
	 * 表主键：关联id	
	 */
	private int signatireId;
	/**
	 * 机车日计划Id
	 */
	private DatePlanPri datePlanId;
	/**
	 * 签到用户id
	 */
	private UsersPrivs user;
	/**
	 * 签到时间
	 */
	private String signTime;
	/**
	 * 用户班组  不映射到数据库
	 * @return
	 */
	private String bzName;
	
	public int getSignatireId() {
		return signatireId;
	}
	public void setSignatireId(int signatireId) {
		this.signatireId = signatireId;
	}
	public DatePlanPri getDatePlanId() {
		return datePlanId;
	}
	public void setDatePlanId(DatePlanPri datePlanId) {
		this.datePlanId = datePlanId;
	}
	public UsersPrivs getUser() {
		return user;
	}
	public void setUser(UsersPrivs user) {
		this.user = user;
	}
	public String getSignTime() {
		return signTime;
	}
	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}
	public String getBzName() {
		return bzName;
	}
	public void setBzName(String bzName) {
		this.bzName = bzName;
	}
}
