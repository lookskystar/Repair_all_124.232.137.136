package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车检修日计划记录表
 * 
 * @author zx
 * 
 */
public class DatePlanRecorder implements Serializable{
	private static final long serialVersionUID = 4907571560521977702L;
	// 日计划记录ID
	private Long rjhdId;
	// 日计划主表ID
	private DatePlanPri rjhmId;
	// 修理内容
	private String xlnr;
	// 承修班组
	private String banzu;

	public DatePlanRecorder() {
		
	}

	public Long getRjhdId() {
		return rjhdId;
	}

	public void setRjhdId(Long rjhdId) {
		this.rjhdId = rjhdId;
	}

	public DatePlanPri getRjhmId() {
		return rjhmId;
	}

	public void setRjhmId(DatePlanPri rjhmId) {
		this.rjhmId = rjhmId;
	}

	public String getXlnr() {
		return xlnr;
	}

	public void setXlnr(String xlnr) {
		this.xlnr = xlnr;
	}

	public String getBanzu() {
		return banzu;
	}

	public void setBanzu(String banzu) {
		this.banzu = banzu;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((rjhdId == null) ? 0 : rjhdId.hashCode());
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
		DatePlanRecorder other = (DatePlanRecorder) obj;
		if (rjhdId == null) {
			if (other.rjhdId != null)
				return false;
		} else if (!rjhdId.equals(other.rjhdId))
			return false;
		return true;
	}
}
