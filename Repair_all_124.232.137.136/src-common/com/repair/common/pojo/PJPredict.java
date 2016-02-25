package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;
/**
 * 配件检修报活
 * @author xiaolong
 *
 */
public class PJPredict implements Serializable {

	private static final long serialVersionUID = -8646706670078250347L;
	/**
	 * 主键
	 */
	private long predictId;
	/**
	 * 配件
	 */
	private PJDynamicInfo pjDynamicInfo;
	/**
	 * 当前产生报活的检修项目的记录
	 */
	private PJFixRecord pjFixRecord;
	/**
	 * 报活指定的班组
	 */
	private Long bzId;
	/**
	 * 班组名
	 */
	private String bzName;
	/**
	 * 报活的故障描述
	 */
	private String description;
	/**
	 * 报活人id
	 */
	private long makerId;
	/**
	 * 报活人名字
	 */
	private String maker;
	/**
	 * 报活时间
	 */
	private Date makeDate;
	/**
	 * 审批人id
	 */
	private Long approverId;
	/**
	 * 审批人
	 */
	private String approver;
	/**
	 * 审批时间
	 */
	private Date approveDate;
	/**
	 * 当前报活产生的配件检修记录id
	 */
	private Long pjFixRecId;
	/**
	 * 是否需要审批:0不需要审批，1需要未批，2需要已批
	 */
	private int needApprove;
	/**
	 * 工人接活时间
	 */
	private Date accepttime;
	/**
	 * 检修人id
	 */
	private Long fixempid;
	/**
	 * 检修人名字
	 */
	private String fixemp;
	/**
	 * 检修人签认时间
	 */
	private Date empaffirmtime;
	/**
	 * 检修情况
	 */
	private String fixsituation;
	/*
	 * 工长id
	 */
	private Long leadid;
	/**
	 * 工长名字
	 */
	private String lead;
	/**
	 * 工长验收时间
	 */
	private Date ldaffirmtime;
	/**
	 * 交车工长id
	 */
	private Long commitleadid;
	/**
	 * 交车工长名字
	 */
	private String commitlead;
	/**
	 * 交车工长验收时间
	 */
	private Date comldaffitime;
	/**
	 * 技术员id
	 */
	private Long techId;
	/**
	 * 技术员名字
	 */
	private String techName;
	/**
	 * 技术员签认时间
	 */
	private Date techTime;
	/**
	 * 质检员id
	 */
	private Long qiid;
	/**
	 * 质检员名字
	 */
	private String qi;
	/**
	 * 质检员验收时间
	 */
	private Date qiaffitime;
	/**
	 * 验收员id
	 */
	private Long accepterid;
	/**
	 * 验收员名字
	 */
	private String accepter;
	/**
	 * 验收员验收时间
	 */
	private Date acceaffitime;
	/**
	 * 状态：0未完成，1派工完成，2工人签认，3工长签认（暂时不涉及其他角色签认，到此报活签认完成）
	 */
	private int status;
	public long getPredictId() {
		return predictId;
	}
	public void setPredictId(long predictId) {
		this.predictId = predictId;
	}
	public PJDynamicInfo getPjDynamicInfo() {
		return pjDynamicInfo;
	}
	public void setPjDynamicInfo(PJDynamicInfo pjDynamicInfo) {
		this.pjDynamicInfo = pjDynamicInfo;
	}
	public PJFixRecord getPjFixRecord() {
		return pjFixRecord;
	}
	public void setPjFixRecord(PJFixRecord pjFixRecord) {
		this.pjFixRecord = pjFixRecord;
	}
	public Long getBzId() {
		return bzId;
	}
	public void setBzId(Long bzId) {
		this.bzId = bzId;
	}
	public String getBzName() {
		return bzName;
	}
	public void setBzName(String bzName) {
		this.bzName = bzName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public long getMakerId() {
		return makerId;
	}
	public void setMakerId(long makerId) {
		this.makerId = makerId;
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
	public Long getApproverId() {
		return approverId;
	}
	public void setApproverId(Long approverId) {
		this.approverId = approverId;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	public Date getApproveDate() {
		return approveDate;
	}
	public void setApproveDate(Date approveDate) {
		this.approveDate = approveDate;
	}
	public Long getPjFixRecId() {
		return pjFixRecId;
	}
	public void setPjFixRecId(Long pjFixRecId) {
		this.pjFixRecId = pjFixRecId;
	}
	public int getNeedApprove() {
		return needApprove;
	}
	public void setNeedApprove(int needApprove) {
		this.needApprove = needApprove;
	}
	public Date getAccepttime() {
		return accepttime;
	}
	public void setAccepttime(Date accepttime) {
		this.accepttime = accepttime;
	}
	public Long getFixempid() {
		return fixempid;
	}
	public void setFixempid(Long fixempid) {
		this.fixempid = fixempid;
	}
	public String getFixemp() {
		return fixemp;
	}
	public void setFixemp(String fixemp) {
		this.fixemp = fixemp;
	}
	public Date getEmpaffirmtime() {
		return empaffirmtime;
	}
	public void setEmpaffirmtime(Date empaffirmtime) {
		this.empaffirmtime = empaffirmtime;
	}
	public String getFixsituation() {
		return fixsituation;
	}
	public void setFixsituation(String fixsituation) {
		this.fixsituation = fixsituation;
	}
	public Long getLeadid() {
		return leadid;
	}
	public void setLeadid(Long leadid) {
		this.leadid = leadid;
	}
	public String getLead() {
		return lead;
	}
	public void setLead(String lead) {
		this.lead = lead;
	}
	public Date getLdaffirmtime() {
		return ldaffirmtime;
	}
	public void setLdaffirmtime(Date ldaffirmtime) {
		this.ldaffirmtime = ldaffirmtime;
	}
	public Long getCommitleadid() {
		return commitleadid;
	}
	public void setCommitleadid(Long commitleadid) {
		this.commitleadid = commitleadid;
	}
	public String getCommitlead() {
		return commitlead;
	}
	public void setCommitlead(String commitlead) {
		this.commitlead = commitlead;
	}
	public Date getComldaffitime() {
		return comldaffitime;
	}
	public void setComldaffitime(Date comldaffitime) {
		this.comldaffitime = comldaffitime;
	}
	public Long getTechId() {
		return techId;
	}
	public void setTechId(Long techId) {
		this.techId = techId;
	}
	public String getTechName() {
		return techName;
	}
	public void setTechName(String techName) {
		this.techName = techName;
	}
	public Date getTechTime() {
		return techTime;
	}
	public void setTechTime(Date techTime) {
		this.techTime = techTime;
	}
	public Long getQiid() {
		return qiid;
	}
	public void setQiid(Long qiid) {
		this.qiid = qiid;
	}
	public String getQi() {
		return qi;
	}
	public void setQi(String qi) {
		this.qi = qi;
	}
	public Date getQiaffitime() {
		return qiaffitime;
	}
	public void setQiaffitime(Date qiaffitime) {
		this.qiaffitime = qiaffitime;
	}
	public Long getAccepterid() {
		return accepterid;
	}
	public void setAccepterid(Long accepterid) {
		this.accepterid = accepterid;
	}
	public String getAccepter() {
		return accepter;
	}
	public void setAccepter(String accepter) {
		this.accepter = accepter;
	}
	public Date getAcceaffitime() {
		return acceaffitime;
	}
	public void setAcceaffitime(Date acceaffitime) {
		this.acceaffitime = acceaffitime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}