package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 电力机车交车检测项目主表--存放电力机车交车检测项目信息
 *  备注：检修记录主表ID是否应该是检修流程节点ID	
 * @author zx
 * 
 */
public class DlJcJyZb implements Serializable {
	private static final long serialVersionUID = -6200497703101141039L;
	// 交车检测项目主表ID
	private Integer jyzId;
	// 日计划ID
	private Integer dpId;//与日计划属于一对一关系
	// 车型
	private String jclx;
	// 车号
	private String jch;
	// 修程修次
	private String xcxc;
	// 交车时间
	private String jcsj;

	public DlJcJyZb() {
		
	}

	public Integer getJyzId() {
		return jyzId;
	}

	public void setJyzId(Integer jyzId) {
		this.jyzId = jyzId;
	}

	public Integer getDpId() {
		return dpId;
	}

	public void setDpId(Integer dpId) {
		this.dpId = dpId;
	}

	public String getJclx() {
		return jclx;
	}

	public void setJclx(String jclx) {
		this.jclx = jclx;
	}

	public String getJch() {
		return jch;
	}

	public void setJch(String jch) {
		this.jch = jch;
	}

	public String getXcxc() {
		return xcxc;
	}

	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}

	public String getJcsj() {
		return jcsj;
	}

	public void setJcsj(String jcsj) {
		this.jcsj = jcsj;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((jyzId == null) ? 0 : jyzId.hashCode());
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
		DlJcJyZb other = (DlJcJyZb) obj;
		if (jyzId == null) {
			if (other.jyzId != null)
				return false;
		} else if (!jyzId.equals(other.jyzId))
			return false;
		return true;
	}
}
