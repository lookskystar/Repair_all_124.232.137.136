package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 股道
 * 
 * @author Administrator
 * 
 */
public class DictGuDao implements Serializable{
	private static final long serialVersionUID = -6866967623051663013L;
	// 股道ID
	private Integer guDaoId;
	// 股道名
	private String gdName;
	// 股道号
	private Short gdNum;
	// 台位号
	private Short twNum;

	public DictGuDao() {

	}

	public Integer getGuDaoId() {
		return guDaoId;
	}

	public void setGuDaoId(Integer guDaoId) {
		this.guDaoId = guDaoId;
	}

	public String getGdName() {
		return gdName;
	}

	public void setGdName(String gdName) {
		this.gdName = gdName;
	}

	public Short getGdNum() {
		return gdNum;
	}

	public void setGdNum(Short gdNum) {
		this.gdNum = gdNum;
	}

	public Short getTwNum() {
		return twNum;
	}

	public void setTwNum(Short twNum) {
		this.twNum = twNum;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((guDaoId == null) ? 0 : guDaoId.hashCode());
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
		DictGuDao other = (DictGuDao) obj;
		if (guDaoId == null) {
			if (other.guDaoId != null)
				return false;
		} else if (!guDaoId.equals(other.guDaoId))
			return false;
		return true;
	}
}
