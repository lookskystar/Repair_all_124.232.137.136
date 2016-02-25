package com.repair.common.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * RolePrivs entity. @author MyEclipse Persistence Tools
 */

public class RolePrivs implements java.io.Serializable {

	/**
	 * 主键
	 */
	private Long roleid;
	/**
	 * 角色名
	 */
	private String rolename;
	/**
	 * 角色拼音
	 */
	private String py;
	/**
	 * 角色说明
	 */
	private String rolenote;
	/**
	 * 角色对应的用户
	 */
	private Set<UsersPrivs> usersPrivs=new HashSet<UsersPrivs>();
	
	public Set<UsersPrivs> getUsersPrivs() {
		return usersPrivs;
	}

	public void setUsersPrivs(Set<UsersPrivs> usersPrivs) {
		this.usersPrivs = usersPrivs;
	}

	public Long getRoleid() {
		return roleid;
	}

	public void setRoleid(Long roleid) {
		this.roleid = roleid;
	}

	public String getRolename() {
		return this.rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	public String getPy() {
		return this.py;
	}

	public void setPy(String py) {
		this.py = py;
	}

	public String getRolenote() {
		return this.rolenote;
	}

	public void setRolenote(String rolenote) {
		this.rolenote = rolenote;
	}


}