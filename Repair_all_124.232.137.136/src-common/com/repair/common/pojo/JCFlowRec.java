package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * 流程记录表
 * @author Administrator
 *
 */
public class JCFlowRec implements Serializable{
	
	private static final long serialVersionUID = 3214091929533126318L;
	/**
	 * 主键ID
	 */
	public Long jcFlowRecId;
	/**
	 * 检修流程
	 */
	public JCFixflow fixflow;
	/**
	 * 班组
	 */
	public DictProTeam proTeam; 
	/**
	 * 完成状态 0：未完成 1：已完成
	 */
	public int finishStatus;
	/**
	 * 完成时间
	 */
	public Date finishTime;
	/**
	 * 日计划
	 */
	public DatePlanPri datePlanPri;
	public Long getJcFlowRecId() {
		return jcFlowRecId;
	}
	public void setJcFlowRecId(Long jcFlowRecId) {
		this.jcFlowRecId = jcFlowRecId;
	}
	public JCFixflow getFixflow() {
		return fixflow;
	}
	public void setFixflow(JCFixflow fixflow) {
		this.fixflow = fixflow;
	}
	public DictProTeam getProTeam() {
		return proTeam;
	}
	public void setProTeam(DictProTeam proTeam) {
		this.proTeam = proTeam;
	}
	public int getFinishStatus() {
		return finishStatus;
	}
	public void setFinishStatus(int finishStatus) {
		this.finishStatus = finishStatus;
	}
	public Date getFinishTime() {
		return finishTime;
	}
	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}
	public DatePlanPri getDatePlanPri() {
		return datePlanPri;
	}
	public void setDatePlanPri(DatePlanPri datePlanPri) {
		this.datePlanPri = datePlanPri;
	}
}
