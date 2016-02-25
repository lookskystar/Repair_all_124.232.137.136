package com.repair.common.pojo;

import java.io.Serializable;
/**
 * 水阻试验除工人外的签认记录
 * @author jxl
 *
 */
public class JcExpSignRec implements Serializable{

	private static final long serialVersionUID = 6504333627192837715L;
	/**
	 * 表主键
	 */
	private Long recId;
	/**
	 * 段代码
	 */
	private String jwdCode;
	/**
	 * 机车Id
	 */
	private String jcnum;
	/**
	 * 日计划记录ID
	 */
	private DatePlanPri datePlan;
	/**
	 * 修程
	 */
	private String xc;
	/**
	 * 机车试验
	 */
	private JcExperimentItem experiment;
	/**
	 * 项目标识
	 */
	private String itemName;
	/**
	 * 工长ID
	 */
	private Integer leadId;
	/**
	 * 工长名字
	 */
	private String leader;
	/**
	 * 工长签名时间
	 */
	private String ldAffirmTime;
	/**
	 * 技术员ID
	 */
	private Integer teachId;
	/**
	 * 技术员名字
	 */
	private String teachName;
	/**
	 * 技术员签认时间
	 */
	private String teachFiTime;
	/**
	 * 质检员ID
	 */
	private Integer qiId;
	/**
	 * 质检员名字
	 */
	private String qi;
	/**
	 * 质检员签认时间
	 */
	private String qiAffiTime;
	/**
	 * 交车工长ID
	 */
	private Integer commitLeadId;
	/**
	 * 交车工长名字
	 */
	private String commitLead;
	/**
	 * 交车工长签名时间
	 */
	private String comLdAffiTime;
	/**
	 * 验收员ID
	 */
	private Integer accepterId;
	/**
	 * 验收员名字
	 */
	private String accepter;
	/**
	 * 验收员签名时间
	 */
	private String acceAffiTime;
	/**
	 * 记录状态:1工长签认、2质检签认、3技术签认、4交车工长签认、5完成（验收员签认）
	 */
	private Short recStas;
	public Long getRecId() {
		return recId;
	}
	public void setRecId(Long recId) {
		this.recId = recId;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public String getJcnum() {
		return jcnum;
	}
	public void setJcnum(String jcnum) {
		this.jcnum = jcnum;
	}
	public DatePlanPri getDatePlan() {
		return datePlan;
	}
	public void setDatePlan(DatePlanPri datePlan) {
		this.datePlan = datePlan;
	}
	public String getXc() {
		return xc;
	}
	public void setXc(String xc) {
		this.xc = xc;
	}
	public JcExperimentItem getExperiment() {
		return experiment;
	}
	public void setExperiment(JcExperimentItem experiment) {
		this.experiment = experiment;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public Integer getLeadId() {
		return leadId;
	}
	public void setLeadId(Integer leadId) {
		this.leadId = leadId;
	}
	public String getLeader() {
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
	public String getLdAffirmTime() {
		return ldAffirmTime;
	}
	public void setLdAffirmTime(String ldAffirmTime) {
		this.ldAffirmTime = ldAffirmTime;
	}
	public Integer getTeachId() {
		return teachId;
	}
	public void setTeachId(Integer teachId) {
		this.teachId = teachId;
	}
	public String getTeachName() {
		return teachName;
	}
	public void setTeachName(String teachName) {
		this.teachName = teachName;
	}
	public String getTeachFiTime() {
		return teachFiTime;
	}
	public void setTeachFiTime(String teachFiTime) {
		this.teachFiTime = teachFiTime;
	}
	public Integer getQiId() {
		return qiId;
	}
	public void setQiId(Integer qiId) {
		this.qiId = qiId;
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
	public Integer getCommitLeadId() {
		return commitLeadId;
	}
	public void setCommitLeadId(Integer commitLeadId) {
		this.commitLeadId = commitLeadId;
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
	public Integer getAccepterId() {
		return accepterId;
	}
	public void setAccepterId(Integer accepterId) {
		this.accepterId = accepterId;
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
}
