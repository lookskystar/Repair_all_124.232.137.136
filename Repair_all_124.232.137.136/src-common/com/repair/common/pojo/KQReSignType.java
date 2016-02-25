package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 补签类型
 * @author L
 */
public class KQReSignType implements Serializable{
	
	private static final long serialVersionUID = 7611288772247575596L;
	
	// 类型ID
	private Long typeId;
	// 类型值
	private String typeName;
	
	
	
	
	public Long getTypeId() {
		return typeId;
	}
	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	
	
}
