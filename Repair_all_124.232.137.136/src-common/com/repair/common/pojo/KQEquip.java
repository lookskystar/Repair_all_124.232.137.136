package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 设备表
 * 
 * @author txf
 * 
 */
public class KQEquip implements Serializable {


	private static final long serialVersionUID = 9194401675498511430L;
	
	/**
	 * ID
	 */
	private long id;
	/**
	 * 设备名称
	 */
	private String equipName;
	/**
	 * 设备型号
	 */
	private String equipType;
	/**
	 * 设备编号
	 */
	private String equipNum;
	/**
	 * 使用位置
	 */
	private String equipPosition;
	/**
	 * 设备ip
	 */
	private String equipIp;
	/**
	 * 状态
	 */
	private String equipState;
	/**
	 * 端口号
	 */
	private String equipPort;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getEquipName() {
		return equipName;
	}
	public void setEquipName(String equipName) {
		this.equipName = equipName;
	}
	public String getEquipType() {
		return equipType;
	}
	public void setEquipType(String equipType) {
		this.equipType = equipType;
	}
	public String getEquipNum() {
		return equipNum;
	}
	public void setEquipNum(String equipNum) {
		this.equipNum = equipNum;
	}
	public String getEquipPosition() {
		return equipPosition;
	}
	public void setEquipPosition(String equipPosition) {
		this.equipPosition = equipPosition;
	}
	public String getEquipIp() {
		return equipIp;
	}
	public void setEquipIp(String equipIp) {
		this.equipIp = equipIp;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getEquipState() {
		return equipState;
	}
	public void setEquipState(String equipState) {
		this.equipState = equipState;
	}
	public String getEquipPort() {
		return equipPort;
	}
	public void setEquipPort(String equipPort) {
		this.equipPort = equipPort;
	}
	
}
