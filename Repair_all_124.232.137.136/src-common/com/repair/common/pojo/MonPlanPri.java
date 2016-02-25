package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车检修月计划主表--按机车检修月计划记录存放
 * @author zx
 * 
 */
public class MonPlanPri implements Serializable {
	private static final long serialVersionUID = 898995351773786517L;
	// 月计划ID
	private Integer monPlanId;
	// 机务段代码
	private String jwdCode;
	// 区域代码
	private Integer areaId;
	// 计划类型（0-月计划，1-半月计划，2-旬计划）
	private Short planType;
	// 计划月份（yyyy-mm-01）
	private String planTime;
	// 审核人
	private UsersPrivs verifier = null;
	// 审核日期
	private String verifyDate;
	// 编制人
	private UsersPrivs fmtPeople;
	// 编制日期
	private String fmtDate;
	// 状态（-1-作废，0-预编制，1-正式计划，2-审核，3-发布，4-完成）
	private Short status;
	//项目类型  0：小辅修 1:中修
	private Integer projectType;
	
	public Integer getProjectType() {
		return projectType;
	}

	public void setProjectType(Integer projectType) {
		this.projectType = projectType;
	}

	public MonPlanPri() {
		
	}
	
	public MonPlanPri(Integer monPlanId) {
		super();
		this.monPlanId = monPlanId;
	}

	public Integer getMonPlanId() {
		return monPlanId;
	}

	public void setMonPlanId(Integer monPlanId) {
		this.monPlanId = monPlanId;
	}

	public String getJwdCode() {
		return jwdCode;
	}

	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}

	public Integer getAreaId() {
		return areaId;
	}

	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}

	public Short getPlanType() {
		return planType;
	}

	public void setPlanType(Short planType) {
		this.planType = planType;
	}

	public String getPlanTime() {
		return planTime;
	}

	public void setPlanTime(String planTime) {
		this.planTime = planTime;
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

	public UsersPrivs getFmtPeople() {
		return fmtPeople;
	}

	public void setFmtPeople(UsersPrivs fmtPeople) {
		this.fmtPeople = fmtPeople;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((monPlanId == null) ? 0 : monPlanId.hashCode());
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
		MonPlanPri other = (MonPlanPri) obj;
		if (monPlanId == null) {
			if (other.monPlanId != null)
				return false;
		} else if (!monPlanId.equals(other.monPlanId))
			return false;
		return true;
	}
}
