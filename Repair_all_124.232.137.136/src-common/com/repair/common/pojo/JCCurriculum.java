package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * 机车履历
 * @author Administrator
 *
 */
public class JCCurriculum implements Serializable{

	private static final long serialVersionUID = 4456245735019401471L;
	
	/**
	 * 表主键：机车ID
	 */
	private int jccurId;
	/**
	 * 机车编号
	 */
	private String jcId;
	/**
	 * 机车类型：电力、内燃
	 */
	private String jcType;
	/**
	 * 机车型号：DF4、SS3……
	 */
	private String jcNum;
	/**
	 * 配属机务段
	 */
	private String jcOwner;
	/**
	 * 支配机务段
	 */
	private String jcUser;
	/**
	 * 机车状态
	 */
	private int jcStas;
	/**
	 * 分队
	 */
	private String elment;
	/**
	 * 新造时间
	 * @return
	 */
	private Date madeTime;
	/**
	 * 配属时间
	 */
	private Date offeredTime;
	/**
	 * 原配单位
	 */
	private String orrerEntity;
	/**
	 * 改配单位
	 */
	private String alterOfferEntity;
	/**
	 * 调拨时间
	 */
	private Date transTime;
	/**
	 * 新造厂
	 */
	private String madeFrom;
	/**
	 * 调拨命令号
	 */
	private String transOrder;
	/**
	 * 区域编码
	 */
	private String areaCode;
	/**
	 * 轴报（0-非轴报，1-轴报）
	 */
	private int rollerrep;
	/**
	 * 客机（0-非客机，1-有权担当客运）
	 */
	private int airbus;
	/**
	 * 货机（0-非货机，1-有权担当货运）
	 */
	private int freight;
	/**
	 * 列车供电
	 */
	private String trainPower;
	/**
	 * 双管供风
	 */
	private String doublePipeWind;
	/**
	 * 列尾装置
	 */
	private String endDevice;
	/**
	 * 专特运
	 */
	private String speciTrans;
	/**
	 * 可以上驼峰
	 */
	private String upHump;
	/**
	 * 担当机车交路，中间用空格分
	 */
	private String jcInter;
	/**
	 * 更改时间
	 */
	private String alterTime;
	/**
	 * 是否启用(0-禁用，1-启用)
	 */
	private int isued;
	/**
	 * 是否变化（0无变化，1已修改）－用于动态更新
	 */
	private int isVary;
	
	public int getJccurId() {
		return jccurId;
	}
	public void setJccurId(int jccurId) {
		this.jccurId = jccurId;
	}
	public String getJcId() {
		return jcId;
	}
	public void setJcId(String jcId) {
		this.jcId = jcId;
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
	public String getJcOwner() {
		return jcOwner;
	}
	public void setJcOwner(String jcOwner) {
		this.jcOwner = jcOwner;
	}
	public String getJcUser() {
		return jcUser;
	}
	public void setJcUser(String jcUser) {
		this.jcUser = jcUser;
	}
	public int getJcStas() {
		return jcStas;
	}
	public void setJcStas(int jcStas) {
		this.jcStas = jcStas;
	}
	public String getElment() {
		return elment;
	}
	public void setElment(String elment) {
		this.elment = elment;
	}
	public Date getMadeTime() {
		return madeTime;
	}
	public void setMadeTime(Date madeTime) {
		this.madeTime = madeTime;
	}
	public Date getOfferedTime() {
		return offeredTime;
	}
	public void setOfferedTime(Date offeredTime) {
		this.offeredTime = offeredTime;
	}
	public String getOrrerEntity() {
		return orrerEntity;
	}
	public void setOrrerEntity(String orrerEntity) {
		this.orrerEntity = orrerEntity;
	}
	public String getAlterOfferEntity() {
		return alterOfferEntity;
	}
	public void setAlterOfferEntity(String alterOfferEntity) {
		this.alterOfferEntity = alterOfferEntity;
	}
	public Date getTransTime() {
		return transTime;
	}
	public void setTransTime(Date transTime) {
		this.transTime = transTime;
	}
	public String getMadeFrom() {
		return madeFrom;
	}
	public void setMadeFrom(String madeFrom) {
		this.madeFrom = madeFrom;
	}
	public String getTransOrder() {
		return transOrder;
	}
	public void setTransOrder(String transOrder) {
		this.transOrder = transOrder;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public int getRollerrep() {
		return rollerrep;
	}
	public void setRollerrep(int rollerrep) {
		this.rollerrep = rollerrep;
	}
	public int getAirbus() {
		return airbus;
	}
	public void setAirbus(int airbus) {
		this.airbus = airbus;
	}
	public int getFreight() {
		return freight;
	}
	public void setFreight(int freight) {
		this.freight = freight;
	}
	public String getTrainPower() {
		return trainPower;
	}
	public void setTrainPower(String trainPower) {
		this.trainPower = trainPower;
	}
	public String getDoublePipeWind() {
		return doublePipeWind;
	}
	public void setDoublePipeWind(String doublePipeWind) {
		this.doublePipeWind = doublePipeWind;
	}
	public String getEndDevice() {
		return endDevice;
	}
	public void setEndDevice(String endDevice) {
		this.endDevice = endDevice;
	}
	public String getSpeciTrans() {
		return speciTrans;
	}
	public void setSpeciTrans(String speciTrans) {
		this.speciTrans = speciTrans;
	}
	public String getUpHump() {
		return upHump;
	}
	public void setUpHump(String upHump) {
		this.upHump = upHump;
	}
	public String getJcInter() {
		return jcInter;
	}
	public void setJcInter(String jcInter) {
		this.jcInter = jcInter;
	}
	public String getAlterTime() {
		return alterTime;
	}
	public void setAlterTime(String alterTime) {
		this.alterTime = alterTime;
	}
	public int getIsued() {
		return isued;
	}
	public void setIsued(int isued) {
		this.isued = isued;
	}
	public int getIsVary() {
		return isVary;
	}
	public void setIsVary(int isVary) {
		this.isVary = isVary;
	}
}
