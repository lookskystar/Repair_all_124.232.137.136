package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车检修周计划主表
 * @author zx
 *
 */
public class WeekPlanPri implements Serializable{
	private static final long serialVersionUID = 829026657287799365L;
	// 周计划ID
	private Integer weekPriId;
	// 月计划ID
	private MonPlanPri monPlanId;	
	// 计划类型（0-第一周计划，1-第二周计划...）
	private Short planType;	
	// 计划日期（yyyy-mm-dd）
	private String planDate;
	// 审核人
	private UsersPrivs verifier;	
	// 审核日期
	private String verifyDate;
	// 编制人
	private UsersPrivs fmtpeo;	
	// 编制日期
	private String fmtDate;	
	// 状态（-1-作废，0-预编，1-发布，2-完成）
	private Short status;
	// 变化
	private Short vary;
	//项目类型  0：小辅修 1:中修
	private Integer projectType;
	

	public WeekPlanPri() {
		
	}

	public WeekPlanPri(Integer weekPriId) {
		this.weekPriId = weekPriId;
	}
	
	public Integer getWeekPriId() {
		return weekPriId;
	}

	public void setWeekPriId(Integer weekPriId) {
		this.weekPriId = weekPriId;
	}

	public MonPlanPri getMonPlanId() {
		return monPlanId;
	}

	public void setMonPlanId(MonPlanPri monPlanId) {
		this.monPlanId = monPlanId;
	}

	public Short getPlanType() {
		return planType;
	}

	public void setPlanType(Short planType) {
		this.planType = planType;
	}

	public String getPlanDate() {
		return planDate;
	}

	public void setPlanDate(String planDate) {
		this.planDate = planDate;
	}

	public UsersPrivs getVerifier() {
		return verifier;
	}

	public void setVerifier(UsersPrivs verifier) {
		this.verifier = verifier;
	}

	public String getVerifyDate() {
		return verifyDate;
	}

	public void setVerifyDate(String verifyDate) {
		this.verifyDate = verifyDate;
	}

	public UsersPrivs getFmtpeo() {
		return fmtpeo;
	}

	public void setFmtpeo(UsersPrivs fmtpeo) {
		this.fmtpeo = fmtpeo;
	}

	public String getFmtDate() {
		return fmtDate;
	}

	public void setFmtDate(String fmtDate) {
		this.fmtDate = fmtDate;
	}

	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public Short getVary() {
		return vary;
	}

	public void setVary(Short vary) {
		this.vary = vary;
	}

	public Integer getProjectType() {
		return projectType;
	}

	public void setProjectType(Integer projectType) {
		this.projectType = projectType;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((weekPriId == null) ? 0 : weekPriId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		WeekPlanPri other = (WeekPlanPri) obj;
		if (weekPriId == null) {
			if (other.weekPriId != null)
				return false;
		} else if (!weekPriId.equals(other.weekPriId))
			return false;
		return true;
	}	

}
