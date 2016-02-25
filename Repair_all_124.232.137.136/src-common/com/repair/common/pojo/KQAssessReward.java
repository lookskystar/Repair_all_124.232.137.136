package com.repair.common.pojo;

/**
 * 考核奖励表
 * @author dell
 *
 */
public class KQAssessReward {
	
	//主键
	private Long id;
	//班组ID
	private DictProTeam proteam;
	//班组名称
	private String proteamName;
	//考核奖励日期
	private String rewardTime;
	//被奖核人
	private String rewardPerson;
	//内容-->奖核原因
	private String rewardContent;
	//加奖-->奖励
	private Integer rewardAdd;
	//扣奖-->考核
	private Integer rewardSub;
	//标化考核-->奖核类别
	private String rewardStandard;
	//提报人
	private String reportPerson;
	//提报日期
	private String reportTime;
	//备注
	private String rewardNote;
	//状态 0：新建 1：完善确认 2：审核完
	private Integer rewardStatus;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public DictProTeam getProteam() {
		return proteam;
	}
	public void setProteam(DictProTeam proteam) {
		this.proteam = proteam;
	}
	public String getProteamName() {
		return proteamName;
	}
	public void setProteamName(String proteamName) {
		this.proteamName = proteamName;
	}
	public String getRewardTime() {
		return rewardTime;
	}
	public void setRewardTime(String rewardTime) {
		this.rewardTime = rewardTime;
	}
	public String getRewardPerson() {
		return rewardPerson;
	}
	public void setRewardPerson(String rewardPerson) {
		this.rewardPerson = rewardPerson;
	}
	public String getRewardContent() {
		return rewardContent;
	}
	public void setRewardContent(String rewardContent) {
		this.rewardContent = rewardContent;
	}
	public Integer getRewardAdd() {
		return rewardAdd;
	}
	public void setRewardAdd(Integer rewardAdd) {
		this.rewardAdd = rewardAdd;
	}
	public Integer getRewardSub() {
		return rewardSub;
	}
	public void setRewardSub(Integer rewardSub) {
		this.rewardSub = rewardSub;
	}
	public String getRewardStandard() {
		return rewardStandard;
	}
	public void setRewardStandard(String rewardStandard) {
		this.rewardStandard = rewardStandard;
	}
	public String getReportPerson() {
		return reportPerson;
	}
	public void setReportPerson(String reportPerson) {
		this.reportPerson = reportPerson;
	}
	public String getReportTime() {
		return reportTime;
	}
	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}
	public String getRewardNote() {
		return rewardNote;
	}
	public void setRewardNote(String rewardNote) {
		this.rewardNote = rewardNote;
	}
	public Integer getRewardStatus() {
		return rewardStatus;
	}
	public void setRewardStatus(Integer rewardStatus) {
		this.rewardStatus = rewardStatus;
	}
}
