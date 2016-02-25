package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;
/**
 * 机车检修备品配送计划
 * @author Administrator
 *
 */
public class JCBpDeliverPlan implements Serializable{

	private static final long serialVersionUID = 3925091357923561420L;
	/**
	 * 表主键：备品配送计划表
	 */
	private int jcBPDeliId;
	/**
	 * 段代码
	 */
	private String jwdCode;
	/**
	 * 机车型号
	 */
	private String jcNum;
	/**
	 * 机车号
	 */
	private JCCurriculum jcCurriculum;
	/**
	 * 日计划主表ID
	 */
	private DatePlanPri dyPlanId;
	/**
	 * 修程修次
	 */
	private String xcxc;
	/**
	 * 下车配件条形码	
	 */
	private String doPjBarOrder;
	/**
	 * 上车配件ID	指向配件静态信息表配件ID
	 */
	private PJStaticInfo scPjId;
	/**
	 * 下车配件ID	指向配件静态信息表配件ID
	 */
	private PJStaticInfo xcPjId;
	/**
	 * 下车配件出厂编码
	 */
	private String doPjFacNum;
	/**
	 * 上车配件条码	上车条码允许修改
	 */
	private String upPjBarOrder;
	/**
	 * 上车配件出厂编码
	 */
	private String upPjFacNum;
	/**
	 * 交件人
	 */
	private String comunitPeo;
	/**
	 * 交件时间
	 */
	private Date comTime;
	/**
	 * 接件人
	 */
	private String receiptPeo;
	/**
	 * 接件时间
	 */
	private Date receunitTime;
	/**
	 * 配件名
	 */
	private String pjname;
	/**
	 * 配件所在部位名
	 */
	private String locationName;
	
	/**
	 * 分解组装项目标识
	 */
	private String partAssFlag;
	/**
	 * 状态：0表示修程范围内、1表示报活、2表示中修、3表示检修完成
	 */
	private Integer isbhflag;
	
	public int getJcBPDeliId() {
		return jcBPDeliId;
	}
	public void setJcBPDeliId(int jcBPDeliId) {
		this.jcBPDeliId = jcBPDeliId;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public String getJcNum() {
		return jcNum;
	}
	public void setJcNum(String jcNum) {
		this.jcNum = jcNum;
	}
	public JCCurriculum getJcCurriculum() {
		return jcCurriculum;
	}
	public void setJcCurriculum(JCCurriculum jcCurriculum) {
		this.jcCurriculum = jcCurriculum;
	}
	public DatePlanPri getDyPlanId() {
		return dyPlanId;
	}
	public void setDyPlanId(DatePlanPri dyPlanId) {
		this.dyPlanId = dyPlanId;
	}
	public String getXcxc() {
		return xcxc;
	}
	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}
	public String getDoPjBarOrder() {
		return doPjBarOrder;
	}
	public void setDoPjBarOrder(String doPjBarOrder) {
		this.doPjBarOrder = doPjBarOrder;
	}
	public PJStaticInfo getScPjId() {
		return scPjId;
	}
	public void setScPjId(PJStaticInfo scPjId) {
		this.scPjId = scPjId;
	}
	public PJStaticInfo getXcPjId() {
		return xcPjId;
	}
	public void setXcPjId(PJStaticInfo xcPjId) {
		this.xcPjId = xcPjId;
	}
	public String getDoPjFacNum() {
		return doPjFacNum;
	}
	public void setDoPjFacNum(String doPjFacNum) {
		this.doPjFacNum = doPjFacNum;
	}
	public String getUpPjBarOrder() {
		return upPjBarOrder;
	}
	public void setUpPjBarOrder(String upPjBarOrder) {
		this.upPjBarOrder = upPjBarOrder;
	}
	public String getUpPjFacNum() {
		return upPjFacNum;
	}
	public void setUpPjFacNum(String upPjFacNum) {
		this.upPjFacNum = upPjFacNum;
	}
	public String getComunitPeo() {
		return comunitPeo;
	}
	public void setComunitPeo(String comunitPeo) {
		this.comunitPeo = comunitPeo;
	}
	public Date getComTime() {
		return comTime;
	}
	public void setComTime(Date comTime) {
		this.comTime = comTime;
	}
	public Date getReceunitTime() {
		return receunitTime;
	}
	public void setReceunitTime(Date receunitTime) {
		this.receunitTime = receunitTime;
	}
	public String getReceiptPeo() {
		return receiptPeo;
	}
	public void setReceiptPeo(String receiptPeo) {
		this.receiptPeo = receiptPeo;
	}
	public String getPjname() {
		return pjname;
	}
	public void setPjname(String pjname) {
		this.pjname = pjname;
	}
	public String getLocationName() {
		return locationName;
	}
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	public String getPartAssFlag() {
		return partAssFlag;
	}
	public void setPartAssFlag(String partAssFlag) {
		this.partAssFlag = partAssFlag;
	}
	public Integer getIsbhflag() {
		return isbhflag;
	}
	public void setIsbhflag(Integer isbhflag) {
		this.isbhflag = isbhflag;
	}
	
}
