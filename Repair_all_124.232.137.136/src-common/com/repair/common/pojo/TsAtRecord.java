package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 探伤记录表
 * 
 * */
public class TsAtRecord implements Serializable {

	private static final long serialVersionUID = -6567545509879882968L;
	/**
	 * 主键id
	 * */
	private Integer id;
	/**
	 * 车型
	 * */
	private String jcType;
	/**
	 * 车号
	 * */
	private String jcNum;
	/**
	 * 修程
	 * */
	private String xc;
	/**
	 * 修次
	 * */
	private String jcFixNum;
	/**
	 * 部件
	 * */
	private String unitName;
	/**
	 * 数量
	 * */
	private String unitCount;
	/**
	 * 编号
	 * */
	private String unitNum;
	/**
	 * 报活时间
	 * */
	private String atTime;
	/**
	 * 接活时间
	 * */
	private String fixTime;
	/**
	 * 报活人
	 * */
	private String atWorker;
	/**
	 * 主探者
	 * */
	private String firstWorker;
	/**
	 * 复探者
	 * */
	private String secondWorker;
	/**
	 * 状态 0 新建 1 已派工 2 已完成
	 * */
	private String status;
	/**
	 * 探伤结果
	 * */
	private String tsResult;
	/**
	 * 处理结果
	 * */
	private String tsDeal;
	/**
	 * 探伤方法
	 * */
	private String tsMethod;
	/**
	 * 探伤时间
	 * */
	private String tsTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getXc() {
		return xc;
	}

	public void setXc(String xc) {
		this.xc = xc;
	}

	public String getJcFixNum() {
		return jcFixNum;
	}

	public void setJcFixNum(String jcFixNum) {
		this.jcFixNum = jcFixNum;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getUnitCount() {
		return unitCount;
	}

	public void setUnitCount(String unitCount) {
		this.unitCount = unitCount;
	}

	public String getUnitNum() {
		return unitNum;
	}

	public void setUnitNum(String unitNum) {
		this.unitNum = unitNum;
	}

	public String getAtTime() {
		return atTime;
	}

	public void setAtTime(String atTime) {
		this.atTime = atTime;
	}

	public String getFixTime() {
		return fixTime;
	}

	public void setFixTime(String fixTime) {
		this.fixTime = fixTime;
	}

	public String getAtWorker() {
		return atWorker;
	}

	public void setAtWorker(String atWorker) {
		this.atWorker = atWorker;
	}

	public String getFirstWorker() {
		return firstWorker;
	}

	public void setFirstWorker(String firstWorker) {
		this.firstWorker = firstWorker;
	}

	public String getSecondWorker() {
		return secondWorker;
	}

	public void setSecondWorker(String secondWorker) {
		this.secondWorker = secondWorker;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTsResult() {
		return tsResult;
	}

	public void setTsResult(String tsResult) {
		this.tsResult = tsResult;
	}

	public String getTsDeal() {
		return tsDeal;
	}

	public void setTsDeal(String tsDeal) {
		this.tsDeal = tsDeal;
	}

	public String getTsMethod() {
		return tsMethod;
	}

	public void setTsMethod(String tsMethod) {
		this.tsMethod = tsMethod;
	}

	public String getTsTime() {
		return tsTime;
	}

	public void setTsTime(String tsTime) {
		this.tsTime = tsTime;
	}

}
