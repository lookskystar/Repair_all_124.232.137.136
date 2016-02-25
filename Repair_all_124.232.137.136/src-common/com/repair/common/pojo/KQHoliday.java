package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 节假日表
 * 
 * @author txf
 * 
 */
public class KQHoliday implements Serializable {


	private static final long serialVersionUID = 9194401675498511430L;
	
	/**
	 * ID
	 */
	private long id;
	/**
	 * 节日名
	 */
	private String holidayName;
	/**
	 * 开始时间
	 */
	private String startTime;
	/**
	 * 结束时间
	 */
	private String endTime;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getHolidayName() {
		return holidayName;
	}
	public void setHolidayName(String holidayName) {
		this.holidayName = holidayName;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
