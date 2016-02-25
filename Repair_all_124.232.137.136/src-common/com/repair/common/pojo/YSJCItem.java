package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 验收交车项目
 * @author Administrator
 *
 */
public class YSJCItem implements Serializable{

	private static final long serialVersionUID = -352561163139068745L;
	
	/**
	 * 主键ID
	 */
	private int itemId;
	/**
	 * 分类名称
	 */
	private String classify;
	/**
	 * 检修项目内容
	 */
	private String itemName;
	/**
	 * 排序号
	 */
	private Integer orderNo;
	/**
	 * 单位
	 */
	private String unit;
	/**
	 * 最大值
	 */
	private Float max;
	/**
	 * 最小值
	 */
	private Float min;
	/**
	 * 是否检测 1：检测 0：检查
	 */
	private Integer isCheck;
	/**
	 * 适用车型 ,DF4,DF5,
	 */
	private String jcType;
	/**
	 * 班组号
	 */
	private Long proteam;
	/**
	 * 是否启用 1启用    0不启用
	 */
	private Integer isUse;
	
	
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getClassify() {
		return classify;
	}
	public void setClassify(String classify) {
		this.classify = classify;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public Integer getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public Float getMax() {
		return max;
	}
	public void setMax(Float max) {
		this.max = max;
	}
	public Float getMin() {
		return min;
	}
	public void setMin(Float min) {
		this.min = min;
	}
	public Integer getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(Integer isCheck) {
		this.isCheck = isCheck;
	}
	public String getJcType() {
		return jcType;
	}
	public void setJcType(String jcType) {
		this.jcType = jcType;
	}
	public Long getProteam() {
		return proteam;
	}
	public void setProteam(Long proteam) {
		this.proteam = proteam;
	}
	public Integer getIsUse() {
		return isUse;
	}
	public void setIsUse(Integer isUse) {
		this.isUse = isUse;
	}

	
	
}
