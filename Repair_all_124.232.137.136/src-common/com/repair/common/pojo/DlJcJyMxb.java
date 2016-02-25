package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 电力机车交车检测项目明细表
 * 
 * @author zx
 * 
 */
public class DlJcJyMxb implements Serializable {
	private static final long serialVersionUID = -7210353967372289946L;
	// 交车检测项目明细ID
	private Integer jymxId;
	// 交车记录主表ID
	private DlJcJyZb jyzId;
	// 交车检测拼音
	private String jcpy;
	// 交车检测项目
	private String jcxm;
	// 项目检测情况
	private String jcqk;
	//项目检修检测人
	private String fixEmp;
	// 交车工长工号
	private String jcgz;
	// 质检员工号
	private String zj;
	// 验收员工号
	private String ys;
	//交车工长姓名
	private String jcgzxm;
	//质检姓名
	private String zjxm;
	//验收员姓名
	private String ysxm;
	//质检技术签认时间
	private String zjQrTime;
	//验收签认时间
	private String ysQrTime;
	//状态 0：未签认完  1：签认完成
	private short status;
	
	public DlJcJyMxb() {
		
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public String getJcgzxm() {
		return jcgzxm;
	}

	public void setJcgzxm(String jcgzxm) {
		this.jcgzxm = jcgzxm;
	}

	public String getZjxm() {
		return zjxm;
	}

	public void setZjxm(String zjxm) {
		this.zjxm = zjxm;
	}

	public String getYsxm() {
		return ysxm;
	}

	public void setYsxm(String ysxm) {
		this.ysxm = ysxm;
	}

	public Integer getJymxId() {
		return jymxId;
	}

	public void setJymxId(Integer jymxId) {
		this.jymxId = jymxId;
	}

	public DlJcJyZb getJyzId() {
		return jyzId;
	}

	public void setJyzId(DlJcJyZb jyzId) {
		this.jyzId = jyzId;
	}

	public String getJcxm() {
		return jcxm;
	}

	public void setJcxm(String jcxm) {
		this.jcxm = jcxm;
	}

	public String getJcqk() {
		return jcqk;
	}

	public void setJcqk(String jcqk) {
		this.jcqk = jcqk;
	}

	public String getJcgz() {
		return jcgz;
	}

	public void setJcgz(String jcgz) {
		this.jcgz = jcgz;
	}

	public String getZj() {
		return zj;
	}

	public void setZj(String zj) {
		this.zj = zj;
	}

	public String getYs() {
		return ys;
	}

	public void setYs(String ys) {
		this.ys = ys;
	}
	
	public String getFixEmp() {
		return fixEmp;
	}

	public void setFixEmp(String fixEmp) {
		this.fixEmp = fixEmp;
	}

	public String getJcpy() {
		return jcpy;
	}

	public void setJcpy(String jcpy) {
		this.jcpy = jcpy;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((jymxId == null) ? 0 : jymxId.hashCode());
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
		DlJcJyMxb other = (DlJcJyMxb) obj;
		if (jymxId == null) {
			if (other.jymxId != null)
				return false;
		} else if (!jymxId.equals(other.jymxId))
			return false;
		return true;
	}

	public String getZjQrTime() {
		return zjQrTime;
	}

	public void setZjQrTime(String zjQrTime) {
		this.zjQrTime = zjQrTime;
	}

	public String getYsQrTime() {
		return ysQrTime;
	}

	public void setYsQrTime(String ysQrTime) {
		this.ysQrTime = ysQrTime;
	}
	
	
}
