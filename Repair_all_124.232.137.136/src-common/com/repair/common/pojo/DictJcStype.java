package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车型号
 * @author zx
 *
 */
public class DictJcStype implements Serializable{
	private static final long serialVersionUID = -7668362775405923803L;
	// 机车型号ID
	private Integer jcNumId;
	// 机车类型
	private DictJcType jcTypeId;
	// 机车型号值
	private String jcStypeValue;

	public DictJcStype() {
	}

	public Integer getJcNumId() {
		return jcNumId;
	}

	public void setJcNumId(Integer jcNumId) {
		this.jcNumId = jcNumId;
	}

	public DictJcType getJcTypeId() {
		return jcTypeId;
	}

	public void setJcTypeId(DictJcType jcTypeId) {
		this.jcTypeId = jcTypeId;
	}

	public String getJcStypeValue() {
		return jcStypeValue;
	}

	public void setJcStypeValue(String jcStypeValue) {
		this.jcStypeValue = jcStypeValue;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((jcNumId == null) ? 0 : jcNumId.hashCode());
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
		DictJcStype other = (DictJcStype) obj;
		if (jcNumId == null) {
			if (other.jcNumId != null)
				return false;
		} else if (!jcNumId.equals(other.jcNumId))
			return false;
		return true;
	}
}
