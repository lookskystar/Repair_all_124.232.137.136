package com.repair.common.pojo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 配件检修计划表
 * @author jiangxiaolong
 *
 */
public class PJDatePlanPri {
	private static final long serialVersionUID = 8113340661802136874L;
	// 计划ID标识
	private Long pjDatePlanId;
	// 编制人
	private String formationPerson;
	// 编制时间
	private Date formationDate;
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
	// 状态（0-预编；1-正式；2-完成选择检修配件；3-完成）
	private Short status;
	
	public Long getPjDatePlanId() {
		return pjDatePlanId;
	}
	public void setPjDatePlanId(Long pjDatePlanId) {
		this.pjDatePlanId = pjDatePlanId;
	}
	public String getFormationPerson() {
		return formationPerson;
	}
	public void setFormationPerson(String formationPerson) {
		this.formationPerson = formationPerson;
	}
	public Date getFormationDate() {
		return formationDate;
	}
	public void setFormationDate(Date formationDate) {
		this.formationDate = formationDate;
	}
	public Short getStatus() {
		return status;
	}
	public void setStatus(Short status) {
		this.status = status;
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
	
}
