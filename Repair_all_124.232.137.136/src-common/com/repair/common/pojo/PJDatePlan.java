package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;
/**
 * 配件检修日计划
 * @author cuisine
 *
 */
public class PJDatePlan implements Serializable {

	private static final long serialVersionUID = -8192180853799100931L;
	/**
	 * 主键
	 */
	private Long planId;
	/**
	 * 计划制定者
	 */
	private String maker;
	/**
	 * 制定时间
	 */
	private Date makeDate;
	/**
	 * 静态配件
	 */
	private PJStaticInfo pjStaticInfo;
	/**
	 * 配件名
	 */
	private String pjName;
	/**
	 * 检修数量
	 */
	private int amount;
	/**
	 * 接件时间
	 */
	private Date acceptDate;
	/**
	 * 交件时间
	 */
	private Date payDate;
	/**
	 * 计划开工时间
	 */
	private Date planStartWorkDate;
	/**
	 * 计划完工时间
	 */
	private Date planEndWorkDate;
	/**
	 * 状态：0-新建，1-完成选择检修的配件，2-计划完成
	 */
	private short status;
	public Long getPlanId() {
		return planId;
	}
	public void setPlanId(Long planId) {
		this.planId = planId;
	}
	public String getMaker() {
		return maker;
	}
	public void setMaker(String maker) {
		this.maker = maker;
	}
	public Date getMakeDate() {
		return makeDate;
	}
	public void setMakeDate(Date makeDate) {
		this.makeDate = makeDate;
	}
	public PJStaticInfo getPjStaticInfo() {
		return pjStaticInfo;
	}
	public void setPjStaticInfo(PJStaticInfo pjStaticInfo) {
		this.pjStaticInfo = pjStaticInfo;
	}
	public String getPjName() {
		return pjName;
	}
	public void setPjName(String pjName) {
		this.pjName = pjName;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
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
	public short getStatus() {
		return status;
	}
	public void setStatus(short status) {
		this.status = status;
	}
	
}
