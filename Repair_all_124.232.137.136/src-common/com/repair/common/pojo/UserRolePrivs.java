package com.repair.common.pojo;
/**
 * UserrolePrivs entity. @author MyEclipse Persistence Tools
 */

public class UserRolePrivs implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields
	private Long id;
	private UsersPrivs user;
	private RolePrivs role;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public UsersPrivs getUser() {
		return user;
	}
	public void setUser(UsersPrivs user) {
		this.user = user;
	}
	public RolePrivs getRole() {
		return role;
	}
	public void setRole(RolePrivs role) {
		this.role = role;
	}
}