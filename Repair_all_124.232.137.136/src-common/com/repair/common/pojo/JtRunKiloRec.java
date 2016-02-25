package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * 机车修行走行公里记录表--按机车修行走行公里记录存放
 * 
 * @author zx
 * 
 */
public class JtRunKiloRec implements Serializable {
	private static final long serialVersionUID = 2850397757293323759L;
	// 走行公里记录ID
	private Long runId;
	// 机务段代码
	private String jwdCode;
	// 日期(yyyy-mm-dd)
	private Date nowDate;
	// 机车类型
	private String jcType;
	// 机车编号
	private String jcNum;
	// 当日走行公里
	private String dayRunKilo;
	// 辅修走行公里
	private String minorRunKilo;
	// 小修走行
	private String smaRunKilo;
	// 中修走行
	private String midRunKilo;
	// 大修走行
	private String larRunKilo;
	// 总走行
	private String totalRunKilo;
	// 登记人
	private String registRant;
	// 登记时间
	private Date registTime;
	// 变化
	private Short vary;

	public JtRunKiloRec() {
		
	}

	public Long getRunId() {
		return runId;
	}

	public void setRunId(Long runId) {
		this.runId = runId;
	}

	public String getJwdCode() {
		return jwdCode;
	}

	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}

	public Date getNowDate() {
		return nowDate;
	}

	public void setNowDate(Date nowDate) {
		this.nowDate = nowDate;
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

	public String getDayRunKilo() {
		return dayRunKilo;
	}

	public void setDayRunKilo(String dayRunKilo) {
		this.dayRunKilo = dayRunKilo;
	}

	public String getMinorRunKilo() {
		return minorRunKilo;
	}

	public void setMinorRunKilo(String minorRunKilo) {
		this.minorRunKilo = minorRunKilo;
	}

	public String getSmaRunKilo() {
		return smaRunKilo;
	}

	public void setSmaRunKilo(String smaRunKilo) {
		this.smaRunKilo = smaRunKilo;
	}

	public String getMidRunKilo() {
		return midRunKilo;
	}

	public void setMidRunKilo(String midRunKilo) {
		this.midRunKilo = midRunKilo;
	}

	public String getLarRunKilo() {
		return larRunKilo;
	}

	public void setLarRunKilo(String larRunKilo) {
		this.larRunKilo = larRunKilo;
	}

	public String getTotalRunKilo() {
		return totalRunKilo;
	}

	public void setTotalRunKilo(String totalRunKilo) {
		this.totalRunKilo = totalRunKilo;
	}

	public String getRegistRant() {
		return registRant;
	}

	public void setRegistRant(String registRant) {
		this.registRant = registRant;
	}

	public Date getRegistTime() {
		return registTime;
	}

	public void setRegistTime(Date registTime) {
		this.registTime = registTime;
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
		result = prime * result + ((runId == null) ? 0 : runId.hashCode());
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
		JtRunKiloRec other = (JtRunKiloRec) obj;
		if (runId == null) {
			if (other.runId != null)
				return false;
		} else if (!runId.equals(other.runId))
			return false;
		return true;
	}
}
