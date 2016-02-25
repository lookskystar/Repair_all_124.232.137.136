package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车备品互换要求
 * @author Administrator
 *
 */
public class JCBpReplace implements Serializable{

	private static final long serialVersionUID = 9206567856313475329L;
	
	/**
	 * 表主键：备品互换表
	 */
	private int bphhId;
	/**
	 * 机务段
	 */
	private String jwdCode;
	/**
	 * 机车型号（DF4）
	 */
	private String jcsTypeVal;
	/**
	 * 配件类型名字	指向配件静态信息表配件ID
	 */
	private String pjName;
	/**
	 * 修程修次集合	多个逗号隔开
	 */
	private String xcxc;
	/**
	 * 互换状态	0是必须换，1是可换可不换
	 */
	private int hhStats;
	/**
	 * 车上时间长度（月）
	 */
	private String cssjcd;
	/**
	 * 部位名称
	 */
	private String posiName;
	
	public int getBphhId() {
		return bphhId;
	}
	public void setBphhId(int bphhId) {
		this.bphhId = bphhId;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public String getJcsTypeVal() {
		return jcsTypeVal;
	}
	public void setJcsTypeVal(String jcsTypeVal) {
		this.jcsTypeVal = jcsTypeVal;
	}
	public String getPjName() {
		return pjName;
	}
	public void setPjName(String pjName) {
		this.pjName = pjName;
	}
	public String getXcxc() {
		return xcxc;
	}
	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}
	public int getHhStats() {
		return hhStats;
	}
	public void setHhStats(int hhStats) {
		this.hhStats = hhStats;
	}
	public String getCssjcd() {
		return cssjcd;
	}
	public void setCssjcd(String cssjcd) {
		this.cssjcd = cssjcd;
	}
	public String getPosiName() {
		return posiName;
	}
	public void setPosiName(String posiName) {
		this.posiName = posiName;
	}	
}
