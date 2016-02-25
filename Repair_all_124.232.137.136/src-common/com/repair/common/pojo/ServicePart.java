package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * 计划检修配件信息
 * 	
 * @author zx
 * */
public class ServicePart implements Serializable {

	private static final long serialVersionUID = -6745424223850513724L;

	// 配件检修标识
	private Long partServiceId;
	// 配件静态信息标识（ID）
	private PJStaticInfo partStaticId;
	// 配件名
	private String partName;
	// 修理数量
	private Integer amount;
	// 接件时间
	private Date acceptDate;
	// 交件时间
	private Date payDate;
	// 计划开工时间
	private Date planStartWorkDate;
	// 计划完工时间
	private Date planEndWorkDate;
	// 计划标识（ID）
	private PJDatePlanPri datePlanId;
	/**
	 * 日计划拟定配件，对应班组完成配件选择标识：0表示未完成，1表示已完成
	 */
	private Short status;

	public Long getPartServiceId() {
		return partServiceId;
	}

	public void setPartServiceId(Long partServiceId) {
		this.partServiceId = partServiceId;
	}

	public PJStaticInfo getPartStaticId() {
		return partStaticId;
	}

	public void setPartStaticId(PJStaticInfo partStaticId) {
		this.partStaticId = partStaticId;
	}

	public String getPartName() {
		return partName;
	}

	public void setPartName(String partName) {
		this.partName = partName;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Date getAcceptDate() {
		return acceptDate;
	}

	public void setAcceptDate(Date acceptDate) {
		this.acceptDate = acceptDate;
	}

	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public Date getPlanStartWorkDate() {
		return planStartWorkDate;
	}

	public void setPlanStartWorkDate(Date planStartWorkDate) {
		this.planStartWorkDate = planStartWorkDate;
	}

	public Date getPlanEndWorkDate() {
		return planEndWorkDate;
	}

	public void setPlanEndWorkDate(Date planEndWorkDate) {
		this.planEndWorkDate = planEndWorkDate;
	}

	public PJDatePlanPri getDatePlanId() {
		return datePlanId;
	}

	public void setDatePlanId(PJDatePlanPri datePlanId) {
		this.datePlanId = datePlanId;
	}

	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((partServiceId == null) ? 0 : partServiceId.hashCode());
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
		ServicePart other = (ServicePart) obj;
		if (partServiceId == null) {
			if (other.partServiceId != null)
				return false;
		} else if (!partServiceId.equals(other.partServiceId))
			return false;
		return true;
	}

}
