package com.repair.common.pojo;

import java.io.Serializable;
/**
 * 质检、技术、验收员和交车工长管辖班组
 * @author Administrator
 *
 */
public class JCCharge implements Serializable{

	private static final long serialVersionUID = -5284446450828843307L;
	/**
	 * 表主键：关联id	
	 */
	private int chargeId;
	/**
	 * 用户id	指向用户表
	 */
	private UsersPrivs user;
	/**
	 * 专业班组Id
	 */
	private DictProTeam proteamId;
	/**
	 * 项目id
	 */
	private JCFixitem fixitem;
	/**
	 * 状态--1电力--2内燃--3和谐
	 */
	private int status;
	public int getChargeId() {
		return chargeId;
	}
	public void setChargeId(int chargeId) {
		this.chargeId = chargeId;
	}
	public UsersPrivs getUser() {
		return user;
	}
	public void setUser(UsersPrivs user) {
		this.user = user;
	}
	
	public DictProTeam getProteamId() {
		return proteamId;
	}
	public void setProteamId(DictProTeam proteamId) {
		this.proteamId = proteamId;
	}
	public JCFixitem getFixitem() {
		return fixitem;
	}
	public void setFixitem(JCFixitem fixitem) {
		this.fixitem = fixitem;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
