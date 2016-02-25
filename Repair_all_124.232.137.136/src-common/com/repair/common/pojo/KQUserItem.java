package com.repair.common.pojo;

import java.io.Serializable;


public class KQUserItem implements Serializable{

	/**
	 * 考勤用户项目关联表
	 */
	private static final long serialVersionUID = 7655141236622614644L;

	public Long id;
	//班组项目
	public KQWorkTimeItem item;
	//班组
	public DictProTeam proteam;
	//班组成员
	public UsersPrivs user;
	//工时得分
	public Integer workScore;
	//派工日期
	public String workTime;
	//备注
	public String workNote;
	//状态(0:默认 1：工人签认完成  2：已结转)
	public Integer status;
	//工人签认时间
	public String signTime;
	//结转成员
	public Long overUser;
	//工长结转时间
	public String overTime;
	
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public KQWorkTimeItem getItem() {
		return item;
	}
	public void setItem(KQWorkTimeItem item) {
		this.item = item;
	}
	public DictProTeam getProteam() {
		return proteam;
	}
	public void setProteam(DictProTeam proteam) {
		this.proteam = proteam;
	}
	public UsersPrivs getUser() {
		return user;
	}
	public void setUser(UsersPrivs user) {
		this.user = user;
	}
	public Integer getWorkScore() {
		return workScore;
	}
	public void setWorkScore(Integer workScore) {
		this.workScore = workScore;
	}
	public String getWorkTime() {
		return workTime;
	}
	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}
	public String getWorkNote() {
		return workNote;
	}
	public void setWorkNote(String workNote) {
		this.workNote = workNote;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getSignTime() {
		return signTime;
	}
	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}
	public Long getOverUser() {
		return overUser;
	}
	public void setOverUser(Long overUser) {
		this.overUser = overUser;
	}
	public String getOverTime() {
		return overTime;
	}
	public void setOverTime(String overTime) {
		this.overTime = overTime;
	}
	
	
}
