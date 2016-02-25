package com.repair.common.pojo;

/**
 * 信息公告表
 * @author dell
 *
 */
public class KQNoticeInfo {
	
	//主键
	private Long id;
	//公告标题
	private String noticeTitle;
	//公告内容
	private String noticeContent;
	//公告时间
	private String noticeTime;
	//开始时间
	private String startTime;
	//结束时间
	private String endTime;
	//公告部门
	private String noticeDept;
	//公告人
	private String noticePerson;
	//状态 0：公告  1：不公告 2:公告失效
	private Integer noticeStatus;
	//排序
	private Integer noticeOrder;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public String getNoticeTime() {
		return noticeTime;
	}
	public void setNoticeTime(String noticeTime) {
		this.noticeTime = noticeTime;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getNoticeDept() {
		return noticeDept;
	}
	public void setNoticeDept(String noticeDept) {
		this.noticeDept = noticeDept;
	}
	public String getNoticePerson() {
		return noticePerson;
	}
	public void setNoticePerson(String noticePerson) {
		this.noticePerson = noticePerson;
	}
	public Integer getNoticeStatus() {
		return noticeStatus;
	}
	public void setNoticeStatus(Integer noticeStatus) {
		this.noticeStatus = noticeStatus;
	}
	public Integer getNoticeOrder() {
		return noticeOrder;
	}
	public void setNoticeOrder(Integer noticeOrder) {
		this.noticeOrder = noticeOrder;
	}
}
