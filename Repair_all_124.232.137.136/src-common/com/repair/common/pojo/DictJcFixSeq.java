package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车修程修程
 * 
 * @author zx
 * 
 */
public class DictJcFixSeq implements Serializable {

	private static final long serialVersionUID = -2377792408893990589L;
	// 修程ID
	private Integer fixId;
	// 修程值
	private String fixValue;
	// 修程说明
	private String flowVal;

	public DictJcFixSeq() {
		
	}

	public Integer getFixId() {
		return fixId;
	}

	public void setFixId(Integer fixId) {
		this.fixId = fixId;
	}

	public String getFixValue() {
		return fixValue;
	}

	public void setFixValue(String fixValue) {
		this.fixValue = fixValue;
	}

	public String getFlowVal() {
		return flowVal;
	}

	public void setFlowVal(String flowVal) {
		this.flowVal = flowVal;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fixId == null) ? 0 : fixId.hashCode());
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
		DictJcFixSeq other = (DictJcFixSeq) obj;
		if (fixId == null) {
			if (other.fixId != null)
				return false;
		} else if (!fixId.equals(other.fixId))
			return false;
		return true;
	}
	
}
