package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车油水化记录明细表 -- 按机车油水化验记录明细存放
 * 
 * @author zx
 * 
 */
public class OilAssayDetailRecorer implements Serializable {

	private static final long serialVersionUID = -7087252603889576666L;
	// 油水化验记录明细表ID
	private Long recDetailId;
	// 油水化验记录主表ID
	private OilAssayPriRecorder recPriId;
	// 化验子项目ID
	private OilAssaySubItem subItemId;
	// 化验子项目名称
	private String subItemTitle;
	// 送样人
	private String sentsamPeo;
	// 检验人
	private String receiptPeo;
	// 接收待化验样品时间
	private String recesamTime;
	// 化验完成时间
	private String finTime;
	// 实测数据
	private Float realdeteVal;
	// 化验情况(合格、不合格...)
	private String quaGrade;
	// 处理意见（更换（变压器油：滤油））
	private String dealAdvice;
	// 合格情况（合格、不合格）
	private String quasituation;
	// 化验状态：0-待化验，1-化验完成，-1-作废
	private Short assayStatus;
	
	public OilAssayDetailRecorer() {
		
	}

	public Long getRecDetailId() {
		return recDetailId;
	}

	public void setRecDetailId(Long recDetailId) {
		this.recDetailId = recDetailId;
	}

	public OilAssayPriRecorder getRecPriId() {
		return recPriId;
	}

	public void setRecPriId(OilAssayPriRecorder recPriId) {
		this.recPriId = recPriId;
	}

	public OilAssaySubItem getSubItemId() {
		return subItemId;
	}

	public void setSubItemId(OilAssaySubItem subItemId) {
		this.subItemId = subItemId;
	}

	public String getSubItemTitle() {
		return subItemTitle;
	}

	public void setSubItemTitle(String subItemTitle) {
		this.subItemTitle = subItemTitle;
	}

	public String getSentsamPeo() {
		return sentsamPeo;
	}

	public void setSentsamPeo(String sentsamPeo) {
		this.sentsamPeo = sentsamPeo;
	}

	public String getReceiptPeo() {
		return receiptPeo;
	}

	public void setReceiptPeo(String receiptPeo) {
		this.receiptPeo = receiptPeo;
	}

	public String getRecesamTime() {
		return recesamTime;
	}

	public void setRecesamTime(String recesamTime) {
		this.recesamTime = recesamTime;
	}

	public String getFinTime() {
		return finTime;
	}

	public void setFinTime(String finTime) {
		this.finTime = finTime;
	}

	public Float getRealdeteVal() {
		return realdeteVal;
	}

	public void setRealdeteVal(Float realdeteVal) {
		this.realdeteVal = realdeteVal;
	}

	public String getQuaGrade() {
		return quaGrade;
	}

	public void setQuaGrade(String quaGrade) {
		this.quaGrade = quaGrade;
	}

	public String getDealAdvice() {
		return dealAdvice;
	}

	public void setDealAdvice(String dealAdvice) {
		this.dealAdvice = dealAdvice;
	}

	public String getQuasituation() {
		return quasituation;
	}

	public void setQuasituation(String quasituation) {
		this.quasituation = quasituation;
	}

	public Short getAssayStatus() {
		return assayStatus;
	}

	public void setAssayStatus(Short assayStatus) {
		this.assayStatus = assayStatus;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((recDetailId == null) ? 0 : recDetailId.hashCode());
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
		OilAssayDetailRecorer other = (OilAssayDetailRecorer) obj;
		if (recDetailId == null) {
			if (other.recDetailId != null)
				return false;
		} else if (!recDetailId.equals(other.recDetailId))
			return false;
		return true;
	}
}
