package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 主计划详情表
 * @author dell
 *
 */
public class MainPlanDetail implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -476950316364983490L;
	//主键ID
	private Long id;
	//对应的主计划
	private MainPlan mainPlanId;
	//计划日期
    private String planTime;
    //对应日期下星期几
    private String planWeek;
    //序号
    private Integer num;
    //车型
    private String jcType;
    //车号
    private String jcNum;
    //修程修次
    private String xcxc;
    //机车计划走行公里
    private String kilometre;
    //机车实际走行公里
    private String realKilometre;
    //扣修地点
    private String kcArea;
    //备注
    private String comments;
    //是否兑现 0：未兑现 1：日兑现 2:周兑现
    private Integer isCash;
    //未兑现原因
    private String cashReason;
    //计划兑现时关联的日计划ID
    private Integer rjhmId;
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public MainPlan getMainPlanId() {
		return mainPlanId;
	}
	public void setMainPlanId(MainPlan mainPlanId) {
		this.mainPlanId = mainPlanId;
	}
	public String getPlanTime() {
		return planTime;
	}
	public void setPlanTime(String planTime) {
		this.planTime = planTime;
	}
	public String getPlanWeek() {
		return planWeek;
	}
	public void setPlanWeek(String planWeek) {
		this.planWeek = planWeek;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getJcType() {
		return jcType;
	}
	public void setJcType(String jcType) {
		this.jcType = jcType;
	}
	public String getJcNum() {
		return jcNum;
	}
	public void setJcNum(String jcNum) {
		this.jcNum = jcNum;
	}
	public String getXcxc() {
		return xcxc;
	}
	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}
	public String getKilometre() {
		return kilometre;
	}
	public void setKilometre(String kilometre) {
		this.kilometre = kilometre;
	}
	public String getRealKilometre() {
		return realKilometre;
	}
	public void setRealKilometre(String realKilometre) {
		this.realKilometre = realKilometre;
	}
	public String getKcArea() {
		return kcArea;
	}
	public void setKcArea(String kcArea) {
		this.kcArea = kcArea;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Integer getIsCash() {
		return isCash;
	}
	public void setIsCash(Integer isCash) {
		this.isCash = isCash;
	}
	public String getCashReason() {
		return cashReason;
	}
	public void setCashReason(String cashReason) {
		this.cashReason = cashReason;
	}
	public Integer getRjhmId() {
		return rjhmId;
	}
	public void setRjhmId(Integer rjhmId) {
		this.rjhmId = rjhmId;
	}
}
