package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 配件检修流程
 */
public class PJFixFlow implements Serializable {

	private static final long serialVersionUID = -4591238796675491951L;
	/**
	 * 主键（检修流程节点id）
	 */
	private Long nodeId;
	/**
	 * 节点名称
	 */
	private String nodeName;
	/**
	 * 机务段编号
	 */
	private String jwdCode;
	/**
	 * 节点顺序号
	 */
	private Integer nodeOrder;
	/**
	 * 流程类型
	 */
	private PJFixFlowType pjFixFlowType;
	public Long getNodeId() {
		return nodeId;
	}
	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public Integer getNodeOrder() {
		return nodeOrder;
	}
	public void setNodeOrder(Integer nodeOrder) {
		this.nodeOrder = nodeOrder;
	}
	public PJFixFlowType getPjFixFlowType() {
		return pjFixFlowType;
	}
	public void setPjFixFlowType(PJFixFlowType pjFixFlowType) {
		this.pjFixFlowType = pjFixFlowType;
	}
	
}