package com.repair.common.pojo;

import java.io.Serializable;

public class KQWorkTimeCount implements Serializable{

	/**
	 * 工时统计表
	 */
	private static final long serialVersionUID = 7184098455900107231L;
	
	private Long id;
	//	工人姓名
	private String name;
	//	工号
	private String gonghao;
	//	班组
	private DictProTeam proteam;
	//	时间
	private String time;
	//	工种
	private String workType;
	//	工作内容
	private String workContent;
	//	工时得分
	private String workScore;
	//	备注
	private String workNote;
	//  状态	0未结转	1已结转
	private int status;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGonghao() {
		return gonghao;
	}
	public void setGonghao(String gonghao) {
		this.gonghao = gonghao;
	}
	public DictProTeam getProteam() {
		return proteam;
	}
	public void setProteam(DictProTeam proteam) {
		this.proteam = proteam;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getWorkType() {
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public String getWorkContent() {
		return workContent;
	}
	public void setWorkContent(String workContent) {
		this.workContent = workContent;
	}
	public String getWorkScore() {
		return workScore;
	}
	public void setWorkScore(String workScore) {
		this.workScore = workScore;
	}
	public String getWorkNote() {
		return workNote;
	}
	public void setWorkNote(String workNote) {
		this.workNote = workNote;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
