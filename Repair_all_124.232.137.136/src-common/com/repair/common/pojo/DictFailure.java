package com.repair.common.pojo;
/**
 * 故障词典
 * @author Administrator
 *
 */
public class DictFailure {
	
	private int id;
	/**
	 * 一级部件名称
	 */
	private String firstUnitName;
	/**
	 * 二级部件名称
	 */
	private String secUnitName;
	/**
	 * 三级部件名称
	 */
	private String thirdUnitName;
	/**
	 * 故障内容
	 */
	private String content;
	/**
	 * 解决办法
	 */
	private String fixContent;
	/**
	 * 故障分值
	 */
	private Integer score;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstUnitName() {
		return firstUnitName;
	}
	public void setFirstUnitName(String firstUnitName) {
		this.firstUnitName = firstUnitName;
	}
	public String getSecUnitName() {
		return secUnitName;
	}
	public void setSecUnitName(String secUnitName) {
		this.secUnitName = secUnitName;
	}
	public String getThirdUnitName() {
		return thirdUnitName;
	}
	public void setThirdUnitName(String thirdUnitName) {
		this.thirdUnitName = thirdUnitName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFixContent() {
		return fixContent;
	}
	public void setFixContent(String fixContent) {
		this.fixContent = fixContent;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
}
