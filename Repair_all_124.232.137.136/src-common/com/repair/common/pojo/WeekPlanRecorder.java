package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车检修周计划记录表
 * 
 * @author zx
 * 
 */
public class WeekPlanRecorder implements Serializable {
	private static final long serialVersionUID = 1770578430463322736L;
	// 周计划记录ID
	private Long wekPrecId;
	// 周计划主表ID
	private WeekPlanPri wekPriId;
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
	// 计划状态（-1-作废，0-预编，1-发布，2-改期，3-补充，4-实施，5-完成）
	private Short planStatus;
	// 变化
	private Short vary;

	public Long getWekPrecId() {
		return wekPrecId;
	}

	public void setWekPrecId(Long wekPrecId) {
		this.wekPrecId = wekPrecId;
	}

	public WeekPlanPri getWekPriId() {
		return wekPriId;
	}

	public void setWekPriId(WeekPlanPri wekPriId) {
		this.wekPriId = wekPriId;
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
				+ ((wekPrecId == null) ? 0 : wekPrecId.hashCode());
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
		WeekPlanRecorder other = (WeekPlanRecorder) obj;
		if (wekPrecId == null) {
			if (other.wekPrecId != null)
				return false;
		} else if (!wekPrecId.equals(other.wekPrecId))
			return false;
		return true;
	}
}
