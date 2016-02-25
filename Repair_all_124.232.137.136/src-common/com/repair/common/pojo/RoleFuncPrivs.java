package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 角色资源类
 * @author cuisine
 *
 */
public class RoleFuncPrivs implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1498705627994352645L;
	/**
	 * 主键
	 */
	private Long id;
	private RolePrivs role;
	private FunctionPrivs function;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public RolePrivs getRole() {
		return role;
	}
	public void setRole(RolePrivs role) {
		this.role = role;
	}
	public FunctionPrivs getFunction() {
		return function;
	}
	public void setFunction(FunctionPrivs function) {
		this.function = function;
	}
	
}