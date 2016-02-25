package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车竣工交验单表
 * 备注：1、签字人是 对象UsersPrivs还是String
 * 	     2、检修记录主表ID是否应该是检修流程节点ID		
 * @author zx
 * 
 */
public class SignedForFinish implements Serializable {

	private static final long serialVersionUID = -7080739622875492339L;
	// ID标识
	private Integer jgId;
	// 日计划ID
	private Integer dpId;
	// 车型
	private String jclx;
	// 车号
	private String jch;
	// 修程修次
	private String xcxc;
	// 检修开始时间
	private String kssj;
	// 检修结束时间
	private String jssj;
	// 交车工长卡号
	private String jcgzid;
	// 交车工长姓名
	private String jcgzxm;
	// 检修主任卡号
	private String jxzrid;
	// 检修主任xm
	private String jxzrxm;
	// 验收员卡号
	private String ysyid;
	// 验收员xm
	private String ysyxm;
	// 段长卡号
	private String dzid;
	// 段长xm
	private String dzxm;
	//类型标识 0：强制交车  1：正常交车
	private short type;
	//配属段区
	private String blongArea;
	//检修段区
	private String fixArea;
	//强制交车理由
	private String reason;
	
	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public SignedForFinish() {
		
	}

	public Integer getJgId() {
		return jgId;
	}

	public void setJgId(Integer jgId) {
		this.jgId = jgId;
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

	public String getKssj() {
		return kssj;
	}

	public void setKssj(String kssj) {
		this.kssj = kssj;
	}

	public String getJssj() {
		return jssj;
	}

	public void setJssj(String jssj) {
		this.jssj = jssj;
	}

	public String getJcgzid() {
		return jcgzid;
	}

	public void setJcgzid(String jcgzid) {
		this.jcgzid = jcgzid;
	}

	public String getJcgzxm() {
		return jcgzxm;
	}

	public void setJcgzxm(String jcgzxm) {
		this.jcgzxm = jcgzxm;
	}

	public String getJxzrid() {
		return jxzrid;
	}

	public void setJxzrid(String jxzrid) {
		this.jxzrid = jxzrid;
	}

	public String getJxzrxm() {
		return jxzrxm;
	}

	public void setJxzrxm(String jxzrxm) {
		this.jxzrxm = jxzrxm;
	}

	public String getYsyid() {
		return ysyid;
	}

	public void setYsyid(String ysyid) {
		this.ysyid = ysyid;
	}

	public String getYsyxm() {
		return ysyxm;
	}

	public void setYsyxm(String ysyxm) {
		this.ysyxm = ysyxm;
	}

	public String getDzid() {
		return dzid;
	}

	public void setDzid(String dzid) {
		this.dzid = dzid;
	}

	public String getDzxm() {
		return dzxm;
	}

	public void setDzxm(String dzxm) {
		this.dzxm = dzxm;
	}

	public String getBlongArea() {
		return blongArea;
	}

	public void setBlongArea(String blongArea) {
		this.blongArea = blongArea;
	}

	public String getFixArea() {
		return fixArea;
	}

	public void setFixArea(String fixArea) {
		this.fixArea = fixArea;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((jgId == null) ? 0 : jgId.hashCode());
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
		SignedForFinish other = (SignedForFinish) obj;
		if (jgId == null) {
			if (other.jgId != null)
				return false;
		} else if (!jgId.equals(other.jgId))
			return false;
		return true;
	}
}
