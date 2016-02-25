package com.repair.common.pojo;

import java.io.Serializable;
/**
 * 作业分工
 * @author Administrator
 *
 */
public class JCDivision implements Serializable{

	private static final long serialVersionUID = 5102486525043099015L;
	/**
	 * 表主键：关联id	
	 */
	private int divideId;
	/**
	 * 日计划主表id
	 */
	private DatePlanPri dayPlan; 
	/**
	 * 用户id	指向用户表
	 */
	private UsersPrivs user;
	/**
	 * 预分工大类id	指向项目预设分类表
	 */
	private PresetDivision presetDivision;
	/**
	 * 项目id
	 */
	private JCFixitem fixitem;
	/**
	 * 分工工长id
	 */
	private UsersPrivs leader;
	/**
	 * 接活时间
	 */
	private String jhDate;
	/**
	 * 分工时间
	 */
	private String fgDate;
	public int getDivideId() {
		return divideId;
	}
	public void setDivideId(int divideId) {
		this.divideId = divideId;
	}
	public DatePlanPri getDayPlan() {
		return dayPlan;
	}
	public void setDayPlan(DatePlanPri dayPlan) {
		this.dayPlan = dayPlan;
	}
	public UsersPrivs getUser() {
		return user;
	}
	public void setUser(UsersPrivs user) {
		this.user = user;
	}
	public PresetDivision getPresetDivision() {
		return presetDivision;
	}
	public void setPresetDivision(PresetDivision presetDivision) {
		this.presetDivision = presetDivision;
	}
	public JCFixitem getFixitem() {
		return fixitem;
	}
	public void setFixitem(JCFixitem fixitem) {
		this.fixitem = fixitem;
	}
	public UsersPrivs getLeader() {
		return leader;
	}
	public void setLeader(UsersPrivs leader) {
		this.leader = leader;
	}
	public String getJhDate() {
		return jhDate;
	}
	public void setJhDate(String jhDate) {
		this.jhDate = jhDate;
	}
	public String getFgDate() {
		return fgDate;
	}
	public void setFgDate(String fgDate) {
		this.fgDate = fgDate;
	}
}
