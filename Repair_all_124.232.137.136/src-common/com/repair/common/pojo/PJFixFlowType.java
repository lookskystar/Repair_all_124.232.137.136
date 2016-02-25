package com.repair.common.pojo;

import java.io.Serializable;

public class PJFixFlowType implements Serializable {

	private static final long serialVersionUID = -3545237648766018221L;
	/**
	 * 类型id
	 */
	private int flowTypeId;
	/**
	 * 类型名
	 */
	private String flowTypeName;
	/**
	 * 机务段编号
	 */
	private String jwdCode;
	public int getFlowTypeId() {
		return flowTypeId;
	}
	public void setFlowTypeId(int flowTypeId) {
		this.flowTypeId = flowTypeId;
	}
	public String getFlowTypeName() {
		return flowTypeName;
	}
	public void setFlowTypeName(String flowTypeName) {
		this.flowTypeName = flowTypeName;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	
}
