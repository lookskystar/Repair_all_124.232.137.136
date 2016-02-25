package com.repair.common.pojo;

import java.util.Date;

/**
 * 配件配送计划类
 */

public class PJDeliveryPlan implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	/**
	 * 主键
	 */
	private Long pjdeliid;
	/**
	 *下车配件条形码
	 */
	private String downpjbarcode;
	/**
	 * 配件名
	 */
	private String pjname;
	/**
	 * 下车配件出厂编号
	 */
	private String downpjfacnum;
	/**
	 * 上车配件条形码
	 */
	private String uppjbarcode;
	/**
	 * 上车配件编号
	 */
	private String uppjfacnum;
	/**
	 * 日计划
	 */
	private DatePlanPri datePlan;
	/**
	 * 交件人
	 */
	private String comunitpeo;
	/**
	 * 交件时间
	 */
	private Date comtime;
	/**
	 * 接件人
	 */
	private String receiptpeo;
	/**
	 * 接件时间
	 */
	private Date receunittime;
	/**
	 * 上车配件
	 */
	private PJDynamicInfo pjDynamicInfoS;
	/**
	 * 下车配件
	 */
	private PJStaticInfo pJStaticInfoX;
	/**
	 * 计划状态：0-新计划；1-完成
	 */
	private Integer planstas;
	
	public Long getPjdeliid() {
		return pjdeliid;
	}
	public void setPjdeliid(Long pjdeliid) {
		this.pjdeliid = pjdeliid;
	}
	public String getDownpjbarcode() {
		return downpjbarcode;
	}
	public void setDownpjbarcode(String downpjbarcode) {
		this.downpjbarcode = downpjbarcode;
	}
	public String getPjname() {
		return pjname;
	}
	public void setPjname(String pjname) {
		this.pjname = pjname;
	}
	public String getDownpjfacnum() {
		return downpjfacnum;
	}
	public void setDownpjfacnum(String downpjfacnum) {
		this.downpjfacnum = downpjfacnum;
	}
	public String getUppjbarcode() {
		return uppjbarcode;
	}
	public void setUppjbarcode(String uppjbarcode) {
		this.uppjbarcode = uppjbarcode;
	}
	public String getUppjfacnum() {
		return uppjfacnum;
	}
	public void setUppjfacnum(String uppjfacnum) {
		this.uppjfacnum = uppjfacnum;
	}
	public DatePlanPri getDatePlan() {
		return datePlan;
	}
	public void setDatePlan(DatePlanPri datePlan) {
		this.datePlan = datePlan;
	}
	public String getComunitpeo() {
		return comunitpeo;
	}
	public void setComunitpeo(String comunitpeo) {
		this.comunitpeo = comunitpeo;
	}
	public Date getComtime() {
		return comtime;
	}
	public void setComtime(Date comtime) {
		this.comtime = comtime;
	}
	public String getReceiptpeo() {
		return receiptpeo;
	}
	public void setReceiptpeo(String receiptpeo) {
		this.receiptpeo = receiptpeo;
	}
	public Date getReceunittime() {
		return receunittime;
	}
	public void setReceunittime(Date receunittime) {
		this.receunittime = receunittime;
	}
	public Integer getPlanstas() {
		return planstas;
	}
	public void setPlanstas(Integer planstas) {
		this.planstas = planstas;
	}
	public PJDynamicInfo getPjDynamicInfoS() {
		return pjDynamicInfoS;
	}
	public void setPjDynamicInfoS(PJDynamicInfo pjDynamicInfoS) {
		this.pjDynamicInfoS = pjDynamicInfoS;
	}
	public PJStaticInfo getpJStaticInfoX() {
		return pJStaticInfoX;
	}
	public void setpJStaticInfoX(PJStaticInfo pJStaticInfoX) {
		this.pJStaticInfoX = pJStaticInfoX;
	}
	
}