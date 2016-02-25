package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车检修月计划记录表--按机车检修月计划记录存放
 * 
 * @author zx
 * 
 */
public class MonPlanRecorder implements Serializable {
	private static final long serialVersionUID = 4025190469845968511L;
	// 月计划记录ID
	private Long monPrecId;
	// 机务段代码
	private String jwdCode;
	// 区域代码
	private String areaId;
	// 月计划主表ID
	private MonPlanPri monPlanId;
	// 机型
	private String jcType;
	// 机车号
	private String jcNum;
	// 计划检修日期
	private String planFixDate;
	// 上次检修日期
	private String befFixDate;
	// 修程次数
	private String fixFreque;
	// 修程走行公里
	private Integer runKilo;
	// 总走行公里
	private Integer totalRunKilo;
	// 估算走行公里
	private Integer guessRunKilo;
	// 计划状态（-1-作废，0-预编，1-正式，2-审核，3-发布，4-改期，5-补充，6-实施）
	private Short planStatus;
	// 变化
	private Short vary;
	
	public MonPlanRecorder() {

	}

	public Long getMonPrecId() {
		return monPrecId;
	}

	public void setMonPrecId(Long monPrecId) {
		this.monPrecId = monPrecId;
	}

	public String getJwdCode() {
		return jwdCode;
	}

	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}

	public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	public MonPlanPri getMonPlanId() {
		return monPlanId;
	}

	public void setMonPlanId(MonPlanPri monPlanId) {
		this.monPlanId = monPlanId;
	}

	public String getJcType() {
		return jcType;
	}

	public void setJcType(String jcType) {
		this.jcType = jcType;
	}

	public String getJcNum() {
		return jcNum;
	}

	public void setJcNum(String jcNum) {
		this.jcNum = jcNum;
	}

	public String getPlanFixDate() {
		return planFixDate;
	}

	public void setPlanFixDate(String planFixDate) {
		this.planFixDate = planFixDate;
	}

	public String getBefFixDate() {
		return befFixDate;
	}

	public void setBefFixDate(String befFixDate) {
		this.befFixDate = befFixDate;
	}

	public String getFixFreque() {
		return fixFreque;
	}

	public void setFixFreque(String fixFreque) {
		this.fixFreque = fixFreque;
	}

	public Integer getRunKilo() {
		return runKilo;
	}

	public void setRunKilo(Integer runKilo) {
		this.runKilo = runKilo;
	}

	public Integer getTotalRunKilo() {
		return totalRunKilo;
	}

	public void setTotalRunKilo(Integer totalRunKilo) {
		this.totalRunKilo = totalRunKilo;
	}

	public Integer getGuessRunKilo() {
		return guessRunKilo;
	}

	public void setGuessRunKilo(Integer guessRunKilo) {
		this.guessRunKilo = guessRunKilo;
	}

	public Short getPlanStatus() {
		return planStatus;
	}

	public void setPlanStatus(Short planStatus) {
		this.planStatus = planStatus;
	}

	public Short getVary() {
		return vary;
	}

	public void setVary(Short vary) {
		this.vary = vary;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((monPrecId == null) ? 0 : monPrecId.hashCode());
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
		MonPlanRecorder other = (MonPlanRecorder) obj;
		if (monPrecId == null) {
			if (other.monPrecId != null)
				return false;
		} else if (!monPrecId.equals(other.monPrecId))
			return false;
		return true;
	}
}
