package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 考勤规则表
 * 
 * @author txf
 * 
 */
public class KQRule implements Serializable {


	private static final long serialVersionUID = 9194401675498511430L;
	
	/**
	 * ID
	 */
	private long id;
	/**
	 * 班组
	 */
	private String bzid;
	/**
	 * 上班段数
	 */
	private String duration;
	/**
	 * 第一时段上班时间
	 */
	private String firstStartTime;
	/**
	 * 第一时段下班时间
	 */
	private String firstEndTime;
	/**
	 * 第二时段上班时间
	 */
	private String secStartTime;
	/**
	 * 第二时段下班时间
	 */
	private String secEndTime;
	/**
	 * 第三时段上班时间
	 */
	private String thirdStartTime;
	/**
	 * 第三时段下班时间
	 */
	private String thirdEndTime;
	/**
	 * 第四时段上班时间
	 */
	private String fourthStartTime;
	/**
	 * 第四时段下班时间
	 */
	private String fourthEndTime;
	/**
	 * 允许迟到时长
	 */
	private Integer lateValid;
	/**
	 * 多久内不算迟到
	 */
	private Integer lateNot;
	/**
	 * 允许早退时长
	 */
	private Integer afterValid;
	/**
	 * 多久内不算早退
	 */
	private Integer leaveEarly;
	/**
	 * 上班类型
	 */
	private String workType;
	/**
	 * 倒班数
	 */
	private Integer shiftCount;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getBzid() {
		return bzid;
	}
	public void setBzid(String bzid) {
		this.bzid = bzid;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getFirstStartTime() {
		return firstStartTime;
	}
	public void setFirstStartTime(String firstStartTime) {
		this.firstStartTime = firstStartTime;
	}
	public String getFirstEndTime() {
		return firstEndTime;
	}
	public void setFirstEndTime(String firstEndTime) {
		this.firstEndTime = firstEndTime;
	}
	public String getSecStartTime() {
		return secStartTime;
	}
	public void setSecStartTime(String secStartTime) {
		this.secStartTime = secStartTime;
	}
	public String getSecEndTime() {
		return secEndTime;
	}
	public void setSecEndTime(String secEndTime) {
		this.secEndTime = secEndTime;
	}
	public String getThirdStartTime() {
		return thirdStartTime;
	}
	public void setThirdStartTime(String thirdStartTime) {
		this.thirdStartTime = thirdStartTime;
	}
	public String getThirdEndTime() {
		return thirdEndTime;
	}
	public void setThirdEndTime(String thirdEndTime) {
		this.thirdEndTime = thirdEndTime;
	}
	public String getFourthStartTime() {
		return fourthStartTime;
	}
	public void setFourthStartTime(String fourthStartTime) {
		this.fourthStartTime = fourthStartTime;
	}
	public String getFourthEndTime() {
		return fourthEndTime;
	}
	public void setFourthEndTime(String fourthEndTime) {
		this.fourthEndTime = fourthEndTime;
	}
	public Integer getLateValid() {
		return lateValid;
	}
	public void setLateValid(Integer lateValid) {
		this.lateValid = lateValid;
	}
	public Integer getLateNot() {
		return lateNot;
	}
	public void setLateNot(Integer lateNot) {
		this.lateNot = lateNot;
	}
	public Integer getAfterValid() {
		return afterValid;
	}
	public void setAfterValid(Integer afterValid) {
		this.afterValid = afterValid;
	}
	public Integer getLeaveEarly() {
		return leaveEarly;
	}
	public void setLeaveEarly(Integer leaveEarly) {
		this.leaveEarly = leaveEarly;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getWorkType() {
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public Integer getShiftCount() {
		return shiftCount;
	}
	public void setShiftCount(Integer shiftCount) {
		this.shiftCount = shiftCount;
	}
	
	
}
