package com.repair.common.pojo;

import java.io.Serializable;
/**
 * 项目预设分类表
 * @author Administrator
 *
 */
public class PresetDivision implements Serializable{

	private static final long serialVersionUID = 2414983419890855423L;
	/**
	 * 表主键：项目预设分类表
	 */
	private Integer proSetId;
	/**
	 * 机务段
	 */
	private String jwdCode;
	/**
	 * 预设分类名称
	 */
	private String clsName;
	/**
	 * 班组
	 */
	private DictProTeam proTeam;
	/**
	 * 机车类型
	 */
	private String jcValue;
	/**
	 * 节点ID
	 * @return
	 */
	private Integer nodeId;
	/**
	 * 检修人ID,如",1,2,"
	 * @return
	 */
	private String fixEmpIds;
	/**
	 * 检修人姓名,如",张三,李四,"
	 * @return
	 */
	private String fixEmpNames;
	
	public Integer getProSetId() {
		return proSetId;
	}
	public void setProSetId(Integer proSetId) {
		this.proSetId = proSetId;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public String getClsName() {
		return clsName;
	}
	public void setClsName(String clsName) {
		this.clsName = clsName;
	}
	public DictProTeam getProTeam() {
		return proTeam;
	}
	public void setProTeam(DictProTeam proTeam) {
		this.proTeam = proTeam;
	}
	public String getJcValue() {
		return jcValue;
	}
	public void setJcValue(String jcValue) {
		this.jcValue = jcValue;
	}
	public Integer getNodeId() {
		return nodeId;
	}
	public void setNodeId(Integer nodeId) {
		this.nodeId = nodeId;
	}
	public String getFixEmpIds() {
		return fixEmpIds;
	}
	public void setFixEmpIds(String fixEmpIds) {
		this.fixEmpIds = fixEmpIds;
	}
	public String getFixEmpNames() {
		return fixEmpNames;
	}
	public void setFixEmpNames(String fixEmpNames) {
		this.fixEmpNames = fixEmpNames;
	}
}
