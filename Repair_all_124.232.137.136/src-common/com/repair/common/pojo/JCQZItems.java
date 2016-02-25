package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 秋整、春鉴项目表
 * @author Administrator
 *
 */
public class JCQZItems implements Serializable{

	private static final long serialVersionUID = 5265983863885435245L;
	/**
	 * 项目ID
	 */
	private int id;
	/**
	 * 段代码
	 */
	private String jwdCode;
	/**
	 * 大部件ID
	 */
	private Integer firstUnitid;
	/**
	 * 大部件编号
	 */
	private String unitNum;
	/**
	 * 大部件名称
	 */
	private String unitName;
	/**
	 * 项目顺序号
	 */
	private Integer xh;
	/**
	 * 检修项目名称
	 */
	private String itemName;
	/**
	 * 技术要求及标准
	 */
	private String techStanderd;
	/**
	 * 项目填报默认值
	 */
	private String fillDefaVal;
	/**
	 * 最小值
	 */
	private Double min;
	/**
	 * 最大值
	 */
	private Double max;
	/**
	 * 修次
	 */
	private String xiuci;
	/**
	 * 电力机车、内燃机车
	 */
	private String jcsType;
	/**
	 * 班组
	 */
	private DictProTeam banzuId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public Integer getFirstUnitid() {
		return firstUnitid;
	}
	public void setFirstUnitid(Integer firstUnitid) {
		this.firstUnitid = firstUnitid;
	}
	public String getUnitNum() {
		return unitNum;
	}
	public void setUnitNum(String unitNum) {
		this.unitNum = unitNum;
	}
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	public Integer getXh() {
		return xh;
	}
	public void setXh(Integer xh) {
		this.xh = xh;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getTechStanderd() {
		return techStanderd;
	}
	public void setTechStanderd(String techStanderd) {
		this.techStanderd = techStanderd;
	}
	public String getFillDefaVal() {
		return fillDefaVal;
	}
	public void setFillDefaVal(String fillDefaVal) {
		this.fillDefaVal = fillDefaVal;
	}
	public Double getMin() {
		return min;
	}
	public void setMin(Double min) {
		this.min = min;
	}
	public Double getMax() {
		return max;
	}
	public void setMax(Double max) {
		this.max = max;
	}
	public String getXiuci() {
		return xiuci;
	}
	public void setXiuci(String xiuci) {
		this.xiuci = xiuci;
	}
	public String getJcsType() {
		return jcsType;
	}
	public void setJcsType(String jcsType) {
		this.jcsType = jcsType;
	}
	public DictProTeam getBanzuId() {
		return banzuId;
	}
	public void setBanzuId(DictProTeam banzuId) {
		this.banzuId = banzuId;
	}
}
