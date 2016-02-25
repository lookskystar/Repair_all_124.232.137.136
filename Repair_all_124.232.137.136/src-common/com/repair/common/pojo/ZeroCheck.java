package com.repair.common.pojo;

/**
 * 零公里检查签到信息
 */

public class ZeroCheck implements java.io.Serializable {

	private int zeroid;
	/**
	 * 机车日计划Id
	 */
	private DatePlanPri dpId;
	/**
	 * 签到用户id
	 */
	private UsersPrivs userId;
	/**
	 * 签到时间
	 */
	private String signTime;
	
	public int getZeroid() {
		return zeroid;
	}
	public void setZeroid(int zeroid) {
		this.zeroid = zeroid;
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
	public String getSignTime() {
		return signTime;
	}
	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}
}