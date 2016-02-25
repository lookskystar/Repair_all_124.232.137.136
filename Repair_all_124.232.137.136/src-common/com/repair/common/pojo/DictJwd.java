package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机务段表
 * @author lll
 *
 */
public class DictJwd implements Serializable{

	
	private static final long serialVersionUID = 4138998737280609204L;
	/**
	 * 机务段代码
	 */
	private String jwdcode;
	/**
	 * 机务段名称
	 */
	private String jwdmc;
	/**
	 * 拼音
	 */
	private String py;
	
	/**
	 * 是否启用 0:不启用  1：启用
	 */
	private Integer isUsed;
	
	/**
	 * 是否放在第一位 1：是
	 */
	private Integer isFirst;
	
	
	public String getJwdcode() {
		return jwdcode;
	}
	public void setJwdcode(String jwdcode) {
		this.jwdcode = jwdcode;
	}
	public String getJwdmc() {
		return jwdmc;
	}
	public void setJwdmc(String jwdmc) {
		this.jwdmc = jwdmc;
	}
	public String getPy() {
		return py;
	}
	public void setPy(String py) {
		this.py = py;
	}
	public Integer getIsUsed() {
		return isUsed;
	}
	public void setIsUsed(Integer isUsed) {
		this.isUsed = isUsed;
	}
	public Integer getIsFirst() {
		return isFirst;
	}
	public void setIsFirst(Integer isFirst) {
		this.isFirst = isFirst;
	}
}