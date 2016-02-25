package com.repair.common.pojo;

import java.io.Serializable;

public class SystemParameter implements Serializable{

	private static final long serialVersionUID = -1116784840935603842L;
	
	private int id;
	
	/**
	 * 参数名字
	 */
	private String parameterName;
	
	/**
	 * 参数值
	 */
	private String parameterValue;
	
	/**
	 * 备注
	 */
	private String remark;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getParameterName() {
		return parameterName;
	}

	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}

	public String getParameterValue() {
		return parameterValue;
	}

	public void setParameterValue(String parameterValue) {
		this.parameterValue = parameterValue;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}
