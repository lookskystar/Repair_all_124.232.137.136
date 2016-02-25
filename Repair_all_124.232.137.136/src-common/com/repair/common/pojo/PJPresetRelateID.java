package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 配件预设分类和项目
 * @author Administrator
 *
 */
public class PJPresetRelateID implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6718275270816829112L;
	
	//主键ID
	private Long pjRelateId;
	//配件预设分类ID
	private PJPresetDivision pjPresetId;
	//配件项目
	private PJFixItem pjFixItemId;
	
	public Long getPjRelateId() {
		return pjRelateId;
	}
	public void setPjRelateId(Long pjRelateId) {
		this.pjRelateId = pjRelateId;
	}
	public PJFixItem getPjFixItemId() {
		return pjFixItemId;
	}
	public void setPjFixItemId(PJFixItem pjFixItemId) {
		this.pjFixItemId = pjFixItemId;
	}
	public PJPresetDivision getPjPresetId() {
		return pjPresetId;
	}
	public void setPjPresetId(PJPresetDivision pjPresetId) {
		this.pjPresetId = pjPresetId;
	}
}
