package com.repair.common.pojo;

import java.io.Serializable;

public class KQSignRec implements Serializable{
	
	/**
	 * 签到表
	 */

	private static final long serialVersionUID = -5806540941982432190L;
	
	
	private Long signId;
	//班组ID
	private Long proteamId;
	//签到时间A~H
	private String signtimeA;
	private String signtimeB;
	private String signtimeC;
	private String signtimeD;
	//补签标识符,一二次补签用,1,2,    二四次补签 ,2,4,
	private String signFlag;
	//应出勤时间
	private Double attendance;
	//实出勤时间
	private Double realAttendance;
	//是否迟到
	private Integer islate;
	//是否早退
	private Integer isgoearly;
	//是否旷工
	private Integer isabsenteeism;
	//是否加班
	private Integer isovertime;
	//是否补签
	private Integer isresign;
	//补签类型
	private Long reSignTypeId;
	//工号
	private String gonghao;
	//姓名
	private String xm;
	//请假开始时间
    private String noworkBegintime;
    //请假结束时间
    private String noworkEndtime;
    //补签操作人
    private String operator;
    //补签时间
    private String operatorTime;
    //补签原因
    private String resignReason;
    //日期,哪一天
    private String day;
    //签到次数,1签两次2四次
	private Integer signCount;
	//下午是否迟到
	private Integer islateB;
	//下午是否早退
	private Integer isgoearlyB;
    
	public Long getSignId() {
		return signId;
	}
	public void setSignId(Long signId) {
		this.signId = signId;
	}
	public Long getProteamId() {
		return proteamId;
	}
	public void setProteamId(Long proteamId) {
		this.proteamId = proteamId;
	}
	public String getSigntimeA() {
		return signtimeA;
	}
	public void setSigntimeA(String signtimeA) {
		this.signtimeA = signtimeA;
	}
	public String getSigntimeB() {
		return signtimeB;
	}
	public void setSigntimeB(String signtimeB) {
		this.signtimeB = signtimeB;
	}
	public String getSigntimeC() {
		return signtimeC;
	}
	public void setSigntimeC(String signtimeC) {
		this.signtimeC = signtimeC;
	}
	public String getSigntimeD() {
		return signtimeD;
	}
	public void setSigntimeD(String signtimeD) {
		this.signtimeD = signtimeD;
	}
	
	public String getSignFlag() {
		return signFlag;
	}
	public void setSignFlag(String signFlag) {
		this.signFlag = signFlag;
	}
	
	public Double getAttendance() {
		return attendance;
	}
	public void setAttendance(Double attendance) {
		this.attendance = attendance;
	}
	public Double getRealAttendance() {
		return realAttendance;
	}
	public void setRealAttendance(Double realAttendance) {
		this.realAttendance = realAttendance;
	}
	public Integer getIslate() {
		return islate;
	}
	public void setIslate(Integer islate) {
		this.islate = islate;
	}
	public Integer getIsgoearly() {
		return isgoearly;
	}
	public void setIsgoearly(Integer isgoearly) {
		this.isgoearly = isgoearly;
	}
	public Integer getIsabsenteeism() {
		return isabsenteeism;
	}
	public void setIsabsenteeism(Integer isabsenteeism) {
		this.isabsenteeism = isabsenteeism;
	}
	public Integer getIsovertime() {
		return isovertime;
	}
	public void setIsovertime(Integer isovertime) {
		this.isovertime = isovertime;
	}
	public Integer getIsresign() {
		return isresign;
	}
	public void setIsresign(Integer isresign) {
		this.isresign = isresign;
	}
	public Long getReSignTypeId() {
		return reSignTypeId;
	}
	public void setReSignTypeId(Long reSignTypeId) {
		this.reSignTypeId = reSignTypeId;
	}
	public String getGonghao() {
		return gonghao;
	}
	public void setGonghao(String gonghao) {
		this.gonghao = gonghao;
	}
	public String getXm() {
		return xm;
	}
	public void setXm(String xm) {
		this.xm = xm;
	}
	public String getNoworkBegintime() {
		return noworkBegintime;
	}
	public void setNoworkBegintime(String noworkBegintime) {
		this.noworkBegintime = noworkBegintime;
	}
	public String getNoworkEndtime() {
		return noworkEndtime;
	}
	public void setNoworkEndtime(String noworkEndtime) {
		this.noworkEndtime = noworkEndtime;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getOperatorTime() {
		return operatorTime;
	}
	public void setOperatorTime(String operatorTime) {
		this.operatorTime = operatorTime;
	}
	public String getResignReason() {
		return resignReason;
	}
	public void setResignReason(String resignReason) {
		this.resignReason = resignReason;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public Integer getSignCount() {
		return signCount;
	}
	public void setSignCount(Integer signCount) {
		this.signCount = signCount;
	}
	public Integer getIslateB() {
		return islateB;
	}
	public void setIslateB(Integer islateB) {
		this.islateB = islateB;
	}
	public Integer getIsgoearlyB() {
		return isgoearlyB;
	}
	public void setIsgoearlyB(Integer isgoearlyB) {
		this.isgoearlyB = isgoearlyB;
	}
	
 

	
}
