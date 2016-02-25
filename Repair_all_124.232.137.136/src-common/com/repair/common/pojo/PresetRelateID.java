package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 预设分类和分解组装项目关系表
 * @author Administrator
 *
 */
public class PresetRelateID implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long relateId;//主键ID
	private PresetDivision presetId;//预设分类ID
	private JCZXFixItem jcZXFixItemId;//分解(组装)项目ID
	private JCFixitem fixitem; //车上检修项目
//	private //秋整、春鉴项目
	
	private String thirds;
	
	public Long getRelateId() {
		return relateId;
	}
	public void setRelateId(Long relateId) {
		this.relateId = relateId;
	}
	public PresetDivision getPresetId() {
		return presetId;
	}
	public void setPresetId(PresetDivision presetId) {
		this.presetId = presetId;
	}
	public String getThirds() {
		return thirds;
	}
	public void setThirds(String thirds) {
		this.thirds = thirds;
	}
	public JCZXFixItem getJcZXFixItemId() {
		return jcZXFixItemId;
	}
	public void setJcZXFixItemId(JCZXFixItem jcZXFixItemId) {
		this.jcZXFixItemId = jcZXFixItemId;
	}
	public JCFixitem getFixitem() {
		return fixitem;
	}
	public void setFixitem(JCFixitem fixitem) {
		this.fixitem = fixitem;
	}
}
