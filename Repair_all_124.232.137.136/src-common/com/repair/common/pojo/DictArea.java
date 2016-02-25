package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 区域表
 * 
 * @author lll
 * 
 */
public class DictArea implements Serializable {


	private static final long serialVersionUID = 9194401675498511430L;
	/**
	 * 区域代码
	 */
	private String areaid;
	/**
	 * 区域名称
	 */
	private String name;
	/**
	 * 所属机务段
	 */
	private String jwdcode;
	/**
	 * 服务器IP
	 */
	private String ip;
	/**
	 * 数据库名
	 */
	private String dbname;
	/**
	 * 登录名
	 */
	private String loginname;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 拼音
	 */
	private String py;

	public String getAreaid() {
		return areaid;
	}

	public void setAreaid(String areaid) {
		this.areaid = areaid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getJwdcode() {
		return jwdcode;
	}

	public void setJwdcode(String jwdcode) {
		this.jwdcode = jwdcode;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getDbname() {
		return dbname;
	}

	public void setDbname(String dbname) {
		this.dbname = dbname;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPy() {
		return py;
	}

	public void setPy(String py) {
		this.py = py;
	}

	
	
}
