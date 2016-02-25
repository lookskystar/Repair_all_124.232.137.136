package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车油水化验子项目表
 * 
 * @author zx
 * 
 */
public class OilAssaySubItem implements Serializable {

	private static final long serialVersionUID = -6193737056297944196L;
	// 化验子项目ID
	private Integer subItemId;
	// 化验项目ID
	private OilAssayItem reportItemId;
	// 化验子项目名称
	private String subItemTitle;
	// 化验子项目拼音代码
	private String subItemPy;
	// 顺序号
	private Integer frequency;
	// 是否启用：0-不启用，1-启用
	private Short isused;
	// 是否常用：0-不常用， 1-常用
	private Short isusual;
	// 最大值
	private Float maxVal;
	// 最小值
	private Float minVal;
	// 填报默认值
	private String fillDefVal;
	// 机车型号
	private String jcsTypeVal;
	
	public OilAssaySubItem() {
		
	}

	public Integer getSubItemId() {
		return subItemId;
	}

	public void setSubItemId(Integer subItemId) {
		this.subItemId = subItemId;
	}

	public OilAssayItem getReportItemId() {
		return reportItemId;
	}

	public void setReportItemId(OilAssayItem reportItemId) {
		this.reportItemId = reportItemId;
	}

	public String getSubItemTitle() {
		return subItemTitle;
	}

	public void setSubItemTitle(String subItemTitle) {
		this.subItemTitle = subItemTitle;
	}

	public String getSubItemPy() {
		return subItemPy;
	}

	public void setSubItemPy(String subItemPy) {
		this.subItemPy = subItemPy;
	}

	public Integer getFrequency() {
		return frequency;
	}

	public void setFrequency(Integer frequency) {
		this.frequency = frequency;
	}

	public Short getIsused() {
		return isused;
	}

	public void setIsused(Short isused) {
		this.isused = isused;
	}

	public Short getIsusual() {
		return isusual;
	}

	public void setIsusual(Short isusual) {
		this.isusual = isusual;
	}

	public Float getMaxVal() {
		return maxVal;
	}

	public void setMaxVal(Float maxVal) {
		this.maxVal = maxVal;
	}

	public Float getMinVal() {
		return minVal;
	}

	public void setMinVal(Float minVal) {
		this.minVal = minVal;
	}

	public String getFillDefVal() {
		return fillDefVal;
	}

	public void setFillDefVal(String fillDefVal) {
		this.fillDefVal = fillDefVal;
	}

	public String getJcsTypeVal() {
		return jcsTypeVal;
	}

	public void setJcsTypeVal(String jcsTypeVal) {
		this.jcsTypeVal = jcsTypeVal;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((subItemId == null) ? 0 : subItemId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OilAssaySubItem other = (OilAssaySubItem) obj;
		if (subItemId == null) {
			if (other.subItemId != null)
				return false;
		} else if (!subItemId.equals(other.subItemId))
			return false;
		return true;
	}
}
