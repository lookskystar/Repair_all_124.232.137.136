package com.repair.common.pojo;

import java.sql.Timestamp;

/**
 * 加改项目-机车走行公里
 * @Date 2015年10月30日15:02:15
 */
public class JgxmRunKiloRec {
	/** @Fields		id：主键*/
	private Integer id;
	
	/** @Fields		jgxm：加改项目对象*/
	private JgJgxm jgxm;
	
	
	/** @Fields		jtRunKiloRec：机车走行公里*/
	private JtRunKiloRec jtRunKiloRec;
	
	/** @Fields		transformFlag：是否改造：0不改，1改造*/
	private Integer transformFlag;
	
	/** @Fields		transformStatus：是否改造完成：0没完成，1完成*/
	private Integer transformStatus;
	
	/** @Fields		formUsers：填报人*/
	private UsersPrivs formUsers;
	
	/** @Fields		formTime：填报时间*/
	private Timestamp formTime;
	
	/** @Fields		remark：备注*/
	private String remark;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public JgJgxm getJgxm() {
		return jgxm;
	}

	public void setJgxm(JgJgxm jgxm) {
		this.jgxm = jgxm;
	}

	public JtRunKiloRec getJtRunKiloRec() {
		return jtRunKiloRec;
	}

	public void setJtRunKiloRec(JtRunKiloRec jtRunKiloRec) {
		this.jtRunKiloRec = jtRunKiloRec;
	}

	public Integer getTransformFlag() {
		return transformFlag;
	}

	public void setTransformFlag(Integer transformFlag) {
		this.transformFlag = transformFlag;
	}

	public Integer getTransformStatus() {
		return transformStatus;
	}

	public void setTransformStatus(Integer transformStatus) {
		this.transformStatus = transformStatus;
	}

	public UsersPrivs getFormUsers() {
		return formUsers;
	}

	public void setFormUsers(UsersPrivs formUsers) {
		this.formUsers = formUsers;
	}

	public Timestamp getFormTime() {
		return formTime;
	}

	public void setFormTime(Timestamp formTime) {
		this.formTime = formTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
