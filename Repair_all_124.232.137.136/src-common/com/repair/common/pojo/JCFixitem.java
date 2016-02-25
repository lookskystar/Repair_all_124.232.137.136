package com.repair.common.pojo;

import java.io.Serializable;
/**
 * 机车检修项目表
 * @author Administrator
 *
 */
public class JCFixitem implements Serializable{

	private static final long serialVersionUID = 9149804772614482922L;
	/**
	 * 表主键:机车检修项目ID	
	 */
	private int thirdUnitId;
	/**
	 * 段代码
	 */
	private String jwdCode;
	/**
	 * 节点ID	和机车检修流程表对应
	 */
	private JCFixflow jcFixflow;
	/**
	 * 大部件ID
	 */
	private Integer firstUnitId;
	/**
	 * 大部件编号
	 */
	private String unitNum;
	/**
	 * 大部件名称
	 */
	private String unitName;
	/**
	 * 二级部件ID
	 */
	private Integer secUnitId;
	/**
	 * 二级部件编号
	 */
	private String secUnitNum;
	/**
	 * 二级部件名称	
	 */
	private String secUnitName;
	/**
	 * 部位编号
	 */
	private String posiNum;
	/**
	 * 部位名称
	 */
	private String posiName;
	/**
	 * 检修项目名称
	 */
	private String itemName;
	/**
	 * 项目顺序号
	 */
	private Integer itemOrder;
	/**
	 * 技术要求及标准
	 */
	private String techStanderd;
	/**
	 * 项目填报默认值
	 */
	private String fillDefaVal;
	/**
	 * 最小值
	 */
	private Double min;
	/**
	 * 最大值
	 */
	private Double max;
	/**
	 * 单位
	 */
	private String unit;
	/**
	 * 检查次数
	 */
	private Integer checkTimes;
	/**
	 * 是否启用
	 */
	private Short isUsed;
	/**
	 * 项目在查询报表显示状态：0-不显示；1-显示
	 */
	private Short queryShw;
	/**
	 * 检修项目拼音简写
	 */
	private String itemPy;
	/**
	 * 大部件拼音简写	
	 */
	private String unitPy;
	/**
	 * 二级部件拼音简写
	 */
	private String secUnitPy;
	/**
	 * 项目卡控人员：0-工长不控；1-工长卡控
	 */
	private int itemCtrlLead;
	/**
	 * 项目卡控人员：0-交车工长不控；1-交车工长卡控
	 */
	private int itemCtrlComLd;
	/**
	 * 项目卡控人员：0-质检员不控；1-质检员卡控
	 */
	private int itemCtrlQI;
	/**
	 * 项目卡控人员：0-技术员不控；1-技术员卡控
	 */
	private int itemCtrlTech;
	/**
	 * 项目卡控人员：0-验收员不控；1-验收员卡控
	 */
	private int itemCtrlAcce;
	/**
	 * 适用车型：填写说明：DF4,SS3,SS3B
	 */
	private String jcsType;
	/**
	 * 修程修次：填写说明: F1,F2,F3,F4,X1
	 */
	private String xcxc;
	/**
	 * 检次：每次、双辅等
	 */
	private String jc;
	/**
	 * 班组
	 */
	private DictProTeam banzuId;
	/**
	 * 预设分工大类	
	 */
	private PresetDivision presetDivision;
	/**
	 * 预设时长
	 * @return
	 */
	private int duration;
	
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public int getThirdUnitId() {
		return thirdUnitId;
	}
	public void setThirdUnitId(int thirdUnitId) {
		this.thirdUnitId = thirdUnitId;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public JCFixflow getJcFixflow() {
		return jcFixflow;
	}
	public void setJcFixflow(JCFixflow jcFixflow) {
		this.jcFixflow = jcFixflow;
	}
	public Integer getFirstUnitId() {
		return firstUnitId;
	}
	public void setFirstUnitId(Integer firstUnitId) {
		this.firstUnitId = firstUnitId;
	}
	public String getUnitNum() {
		return unitNum;
	}
	public void setUnitNum(String unitNum) {
		this.unitNum = unitNum;
	}
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	public Integer getSecUnitId() {
		return secUnitId;
	}
	public void setSecUnitId(Integer secUnitId) {
		this.secUnitId = secUnitId;
	}
	public String getSecUnitNum() {
		return secUnitNum;
	}
	public void setSecUnitNum(String secUnitNum) {
		this.secUnitNum = secUnitNum;
	}
	public String getSecUnitName() {
		return secUnitName;
	}
	public void setSecUnitName(String secUnitName) {
		this.secUnitName = secUnitName;
	}
	public String getPosiNum() {
		return posiNum;
	}
	public void setPosiNum(String posiNum) {
		this.posiNum = posiNum;
	}
	public String getPosiName() {
		return posiName;
	}
	public void setPosiName(String posiName) {
		this.posiName = posiName;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public Integer getItemOrder() {
		return itemOrder;
	}
	public void setItemOrder(Integer itemOrder) {
		this.itemOrder = itemOrder;
	}
	public String getTechStanderd() {
		return techStanderd;
	}
	public void setTechStanderd(String techStanderd) {
		this.techStanderd = techStanderd;
	}
	public String getFillDefaVal() {
		return fillDefaVal;
	}
	public void setFillDefaVal(String fillDefaVal) {
		this.fillDefaVal = fillDefaVal;
	}
	public Double getMin() {
		return min;
	}
	public void setMin(Double min) {
		this.min = min;
	}
	public Double getMax() {
		return max;
	}
	public void setMax(Double max) {
		this.max = max;
	}
	public Integer getCheckTimes() {
		return checkTimes;
	}
	public void setCheckTimes(Integer checkTimes) {
		this.checkTimes = checkTimes;
	}
	public Short getIsUsed() {
		return isUsed;
	}
	public void setIsUsed(Short isUsed) {
		this.isUsed = isUsed;
	}
	public Short getQueryShw() {
		return queryShw;
	}
	public void setQueryShw(Short queryShw) {
		this.queryShw = queryShw;
	}
	public String getItemPy() {
		return itemPy;
	}
	public void setItemPy(String itemPy) {
		this.itemPy = itemPy;
	}
	public String getUnitPy() {
		return unitPy;
	}
	public void setUnitPy(String unitPy) {
		this.unitPy = unitPy;
	}
	public String getSecUnitPy() {
		return secUnitPy;
	}
	public void setSecUnitPy(String secUnitPy) {
		this.secUnitPy = secUnitPy;
	}
	public int getItemCtrlLead() {
		return itemCtrlLead;
	}
	public void setItemCtrlLead(int itemCtrlLead) {
		this.itemCtrlLead = itemCtrlLead;
	}
	public int getItemCtrlComLd() {
		return itemCtrlComLd;
	}
	public void setItemCtrlComLd(int itemCtrlComLd) {
		this.itemCtrlComLd = itemCtrlComLd;
	}
	public int getItemCtrlQI() {
		return itemCtrlQI;
	}
	public void setItemCtrlQI(int itemCtrlQI) {
		this.itemCtrlQI = itemCtrlQI;
	}
	public int getItemCtrlTech() {
		return itemCtrlTech;
	}
	public void setItemCtrlTech(int itemCtrlTech) {
		this.itemCtrlTech = itemCtrlTech;
	}
	public int getItemCtrlAcce() {
		return itemCtrlAcce;
	}
	public void setItemCtrlAcce(int itemCtrlAcce) {
		this.itemCtrlAcce = itemCtrlAcce;
	}
	public String getJcsType() {
		return jcsType;
	}
	public void setJcsType(String jcsType) {
		this.jcsType = jcsType;
	}
	public String getXcxc() {
		return xcxc;
	}
	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}
	public String getJc() {
		return jc;
	}
	public void setJc(String jc) {
		this.jc = jc;
	}
	public PresetDivision getPresetDivision() {
		return presetDivision;
	}
	public void setPresetDivision(PresetDivision presetDivision) {
		this.presetDivision = presetDivision;
	}
	public DictProTeam getBanzuId() {
		return banzuId;
	}
	public void setBanzuId(DictProTeam banzuId) {
		this.banzuId = banzuId;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
}
