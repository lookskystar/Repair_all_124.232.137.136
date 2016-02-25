/**
 * 
 */
package com.repair.common.pojo;

import java.io.Serializable;

/**
 * @author eleven
 *
 */
public class ExaminRec implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4455895748462723075L;
	//ID
	private Long id;
	//考试类型 1.模拟考试 2.分类练习3.顺序练习4.随机练习
	private String examinType;
	//专业
	private DictProTeam type;
	//考试人
	private UsersPrivs examiner;
	//考试日期
	private String examinDate;
	//标准考试时间
	private String standExaminTime;
	//实际考试时间
	private String actualExaminTime;
	private String currectPoints;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getExaminType() {
		return examinType;
	}
	public void setExaminType(String examinType) {
		this.examinType = examinType;
	}
	public UsersPrivs getExaminer() {
		return examiner;
	}
	public void setExaminer(UsersPrivs examiner) {
		this.examiner = examiner;
	}
	public String getExaminDate() {
		return examinDate;
	}
	public void setExaminDate(String examinDate) {
		this.examinDate = examinDate;
	}
	public String getActualExaminTime() {
		return actualExaminTime;
	}
	public void setActualExaminTime(String actualExaminTime) {
		this.actualExaminTime = actualExaminTime;
	}
	public String getStandExaminTime() {
		return standExaminTime;
	}
	public void setStandExaminTime(String standExaminTime) {
		this.standExaminTime = standExaminTime;
	}
	public String getCurrectPoints() {
		return currectPoints;
	}
	public void setCurrectPoints(String currectPoints) {
		this.currectPoints = currectPoints;
	}
	public DictProTeam getType() {
		return type;
	}
	public void setType(DictProTeam type) {
		this.type = type;
	}
}
