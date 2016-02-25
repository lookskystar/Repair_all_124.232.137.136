package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 主计划表
 * @author dell
 *
 */
public class MainPlan implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2372170607660972134L;
	//主键ID
	private Long id;
	//开始时间
	private String startTime;
	//结束时间
	private String endTime;
	//标题
	private String title;
	//编制人
	private String makePeople;
	//编制时间
	private String makeTime;
	//备注
	private String comments;
	//状态 0:计划可变 1：计划已经发布，不能进行相应操作
	private Integer status;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMakePeople() {
		return makePeople;
	}
	public void setMakePeople(String makePeople) {
		this.makePeople = makePeople;
	}
	public String getMakeTime() {
		return makeTime;
	}
	public void setMakeTime(String makeTime) {
		this.makeTime = makeTime;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
}
