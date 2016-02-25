package com.repair.common.pojo;

import java.io.Serializable;
/**
 * 机车检修记录
 * @author Administrator
 *
 */
public class JCFixrec implements Serializable{

	private static final long serialVersionUID = -7543586123430879278L;
	/**
	 * 表主键:机车检修记录ID
	 */
	private long jcRecId;
	/**
	 * 段代码
	 */
	private String jwdCode;
	/**
	 * 机车类型
	 */
	private String jcType;
	/**
	 * 日计划记录ID	连接日计划记录ID
	 */
	private DatePlanPri datePlanPri;
	/**
	 * 机车号
	 */
	private String jcNum;
	/**
	 * 下车配件条码
	 */
	private String doPjBarcode;
	/**
	 * 下车配件编号
	 */
	private String downPjNum;
	/**
	 * 上车配件条码
	 */
	private String upPjBarcode;
	/**
	 * 上车配件编号
	 */
	private String upPjNum;
	/**
	 * 检修项目
	 */
	private JCFixitem fixitem;
	/**
	 * 项目名称
	 */
	private String itemName;
	/**
	 * 配件ID
	 */
	private PJStaticInfo pjStaticInfo;
	/**
	 * 配件名称
	 */
	private String pjName;
	/**
	 * 检修I端(左端)
	 */
	private String leadMargin;
	/**
	 * 检修II端(右端)
	 */
	private String rightMargin;
	/**
	 * 检修情况	逗号分割填报值
	 */
	private String fixSituation;
	/**
	 * 工长分配检修人ID 多个逗号隔开
	 */
	private String fixEmpId;
	/**
	 * 检修人多个逗号隔开
	 */
	private String fixEmp;
	/**
	 * 检修人签名时间	
	 */
	private String empAfformTime;
	/**
	 * 工长
	 */
	private String lead;
	/**
	 * 工长签名时间
	 */
	private String ldAffirmTime;
	/**
	 * 交车工长
	 */
	private String commitLead;
	/**
	 * 交车工长签名时间
	 */
	private String comLdAffiTime;
	/**
	 * 质检员
	 */
	private String qi;
	/**
	 * 质检员签名时间
	 */
	private String qiAffiTime;
	/**
	 * 技术员
	 */
	private String tech;
	/**
	 * 技术员签名时间
	 */
	private String techAffiTime;
	/**
	 * 验收员
	 */
	private String accepter;
	/**
	 * 验收员签名时间
	 */
	private String acceAffiTime;
	/**
	 * 班组
	 */
	private Long banzuId;
	/**
	 * 单位
	 */
	private String unit;
	/**
	 * 接活时间
	 */
	private String jhTime;
	/**
	 * 检查项目或检测项目 (0:检查项目 1：检测项目)
	 */
	private Short itemType;
	/**
	 * 记录状态 0 - 新建、1 - 检修人签认、 2 - 工长签字、3 - 技术员+质检员、4 - 交车工长签字、5-验收员签字
	 */
	private Short recStas;
	/**
	 * 检修项目时长
	 */
	private int duration;
	
	//关联检修项目字段
	/**
	 * 大部件ID
	 */
	private Integer firstUnitId;
	/**
	 * 大部件名称
	 */
	private String unitName;
	/**
	 * 二级部件名称	
	 */
	private String secUnitName;
	/**
	 * 部位名称
	 */
	private String posiName;
	/**
	 * 项目卡控人员：0-工长不控；1-工长卡控
	 */
	private int itemCtrlLead;
	/**
	 * 项目卡控人员：0-交车工长不控；1-交车工长卡控
	 */
	private int itemCtrlComLd;
	/**
	 * 项目卡控人员：0-质检员不控；1-质检员卡控
	 */
	private int itemCtrlQI;
	/**
	 * 项目卡控人员：0-技术员不控；1-技术员卡控
	 */
	private int itemCtrlTech;
	/**
	 * 项目卡控人员：0-验收员不控；1-验收员卡控
	 */
	private int itemCtrlAcce;
	
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public long getJcRecId() {
		return jcRecId;
	}
	public void setJcRecId(long jcRecId) {
		this.jcRecId = jcRecId;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public String getJcType() {
		return jcType;
	}
	public void setJcType(String jcType) {
		this.jcType = jcType;
	}
	public DatePlanPri getDatePlanPri() {
		return datePlanPri;
	}
	public void setDatePlanPri(DatePlanPri datePlanPri) {
		this.datePlanPri = datePlanPri;
	}
	public String getDoPjBarcode() {
		return doPjBarcode;
	}
	public void setDoPjBarcode(String doPjBarcode) {
		this.doPjBarcode = doPjBarcode;
	}
	public String getDownPjNum() {
		return downPjNum;
	}
	public void setDownPjNum(String downPjNum) {
		this.downPjNum = downPjNum;
	}
	public String getUpPjBarcode() {
		return upPjBarcode;
	}
	public void setUpPjBarcode(String upPjBarcode) {
		this.upPjBarcode = upPjBarcode;
	}
	public String getUpPjNum() {
		return upPjNum;
	}
	public void setUpPjNum(String upPjNum) {
		this.upPjNum = upPjNum;
	}
	public JCFixitem getFixitem() {
		return fixitem;
	}
	public void setFixitem(JCFixitem fixitem) {
		this.fixitem = fixitem;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
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
	public String getLeadMargin() {
		return leadMargin;
	}
	public void setLeadMargin(String leadMargin) {
		this.leadMargin = leadMargin;
	}
	public String getRightMargin() {
		return rightMargin;
	}
	public void setRightMargin(String rightMargin) {
		this.rightMargin = rightMargin;
	}
	public String getFixSituation() {
		return fixSituation;
	}
	public void setFixSituation(String fixSituation) {
		this.fixSituation = fixSituation;
	}
	public String getFixEmp() {
		return fixEmp;
	}
	public void setFixEmp(String fixEmp) {
		this.fixEmp = fixEmp;
	}
	public String getEmpAfformTime() {
		return empAfformTime;
	}
	public void setEmpAfformTime(String empAfformTime) {
		this.empAfformTime = empAfformTime;
	}
	public String getLead() {
		return lead;
	}
	public void setLead(String lead) {
		this.lead = lead;
	}
	public String getLdAffirmTime() {
		return ldAffirmTime;
	}
	public void setLdAffirmTime(String ldAffirmTime) {
		this.ldAffirmTime = ldAffirmTime;
	}
	public String getCommitLead() {
		return commitLead;
	}
	public void setCommitLead(String commitLead) {
		this.commitLead = commitLead;
	}
	public String getComLdAffiTime() {
		return comLdAffiTime;
	}
	public void setComLdAffiTime(String comLdAffiTime) {
		this.comLdAffiTime = comLdAffiTime;
	}
	public String getQi() {
		return qi;
	}
	public void setQi(String qi) {
		this.qi = qi;
	}
	public String getQiAffiTime() {
		return qiAffiTime;
	}
	public void setQiAffiTime(String qiAffiTime) {
		this.qiAffiTime = qiAffiTime;
	}
	public String getAccepter() {
		return accepter;
	}
	public void setAccepter(String accepter) {
		this.accepter = accepter;
	}
	public String getAcceAffiTime() {
		return acceAffiTime;
	}
	public void setAcceAffiTime(String acceAffiTime) {
		this.acceAffiTime = acceAffiTime;
	}
	public Short getRecStas() {
		return recStas;
	}
	public void setRecStas(Short recStas) {
		this.recStas = recStas;
	}
	public String getJcNum() {
		return jcNum;
	}
	public void setJcNum(String jcNum) {
		this.jcNum = jcNum;
	}
	public Long getBanzuId() {
		return banzuId;
	}
	public void setBanzuId(Long banzuId) {
		this.banzuId = banzuId;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getJhTime() {
		return jhTime;
	}
	public void setJhTime(String jhTime) {
		this.jhTime = jhTime;
	}
	public String getFixEmpId() {
		return fixEmpId;
	}
	public void setFixEmpId(String fixEmpId) {
		this.fixEmpId = fixEmpId;
	}
	public Short getItemType() {
		return itemType;
	}
	public void setItemType(Short itemType) {
		this.itemType = itemType;
	}
	public String getTech() {
		return tech;
	}
	public void setTech(String tech) {
		this.tech = tech;
	}
	public String getTechAffiTime() {
		return techAffiTime;
	}
	public void setTechAffiTime(String techAffiTime) {
		this.techAffiTime = techAffiTime;
	}
	public Integer getFirstUnitId() {
		return firstUnitId;
	}
	public void setFirstUnitId(Integer firstUnitId) {
		this.firstUnitId = firstUnitId;
	}
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	public String getSecUnitName() {
		return secUnitName;
	}
	public void setSecUnitName(String secUnitName) {
		this.secUnitName = secUnitName;
	}
	public String getPosiName() {
		return posiName;
	}
	public void setPosiName(String posiName) {
		this.posiName = posiName;
	}
	public int getItemCtrlLead() {
		return itemCtrlLead;
	}
	public void setItemCtrlLead(int itemCtrlLead) {
		this.itemCtrlLead = itemCtrlLead;
	}
	public int getItemCtrlComLd() {
		return itemCtrlComLd;
	}
	public void setItemCtrlComLd(int itemCtrlComLd) {
		this.itemCtrlComLd = itemCtrlComLd;
	}
	public int getItemCtrlQI() {
		return itemCtrlQI;
	}
	public void setItemCtrlQI(int itemCtrlQI) {
		this.itemCtrlQI = itemCtrlQI;
	}
	public int getItemCtrlTech() {
		return itemCtrlTech;
	}
	public void setItemCtrlTech(int itemCtrlTech) {
		this.itemCtrlTech = itemCtrlTech;
	}
	public int getItemCtrlAcce() {
		return itemCtrlAcce;
	}
	public void setItemCtrlAcce(int itemCtrlAcce) {
		this.itemCtrlAcce = itemCtrlAcce;
	}
}
