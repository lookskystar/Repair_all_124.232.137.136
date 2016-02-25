package com.repair.common.pojo;

import java.io.Serializable;

public class DictWZNum implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2063090884664299515L;
	//主键ID
	private Long id;
	//物资编号
	private String wzNum;
	//物资名称
	private String wzName;
	//规格型号
	private String wzType;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getWzNum() {
		return wzNum;
	}
	public void setWzNum(String wzNum) {
		this.wzNum = wzNum;
	}
	public String getWzName() {
		return wzName;
	}
	public void setWzName(String wzName) {
		this.wzName = wzName;
	}
	public String getWzType() {
		return wzType;
	}
	public void setWzType(String wzType) {
		this.wzType = wzType;
	}
}
