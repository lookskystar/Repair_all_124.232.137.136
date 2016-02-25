package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 机车试验项目
 * @author Administrator
 *
 */
public class JcExperimentItem implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8036411357509409998L;
	//机车试验项目ID
	private Long jceiId;
	//机务段代码
	private String jwdCode;
	//节点ID
	private JCFixflow nodeId;
	//项目名称
	private String itemName;
	//项目顺序号
	private Long itemMsn;
	//父级项目ID
	private Integer parentId;
	//试验条件
	private String condition;
	//技术要求及标准
	private String techStandard;
	//项目填报默认值
	private String fillDefaVal;
	//最小值
	private Float eIMin;
	//最大值
	private Float eIMax;
	//单位
	private String unit;
    //项目拼音简写
	private String itemPy;
	//项目卡控人员:0：工长不控 1：工长卡控
	private Short itemCtrlLead;
    //项目卡控人员 ：0：交车工长不控 1：交车工长卡控
	private Short itemCtrlComLd;
	//项目卡控人员：0：质检员不控 1：质检验卡控
	private Short itemCtrlQi;
	//项目卡控人员：0：技术员不控 1：技术员卡控
	private Short itemCtrlTech;
	//项目卡控人员：0：验收员不控 1：验收员卡控
	private Short itemCtrlAcce;
	//适用车型：DF4、SS3...
	private String jcsType;
	//修程修次：F1、X1...
	private String xcxc;
	//检次：每次、双辅...
	private String jc;
	//班组编号
	private long proTeam;
	//预设分工大类ID
	private PresetDivision ysId;
	public Long getJceiId() {
		return jceiId;
	}
	public void setJceiId(Long jceiId) {
		this.jceiId = jceiId;
	}
	public String getJwdCode() {
		return jwdCode;
	}
	public void setJwdCode(String jwdCode) {
		this.jwdCode = jwdCode;
	}
	public JCFixflow getNodeId() {
		return nodeId;
	}
	public void setNodeId(JCFixflow nodeId) {
		this.nodeId = nodeId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public Long getItemMsn() {
		return itemMsn;
	}
	public void setItemMsn(Long itemMsn) {
		this.itemMsn = itemMsn;
	}
	
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getTechStandard() {
		return techStandard;
	}
	public void setTechStandard(String techStandard) {
		this.techStandard = techStandard;
	}
	public String getFillDefaVal() {
		return fillDefaVal;
	}
	public void setFillDefaVal(String fillDefaVal) {
		this.fillDefaVal = fillDefaVal;
	}
	public Float geteIMin() {
		return eIMin;
	}
	public void seteIMin(Float eIMin) {
		this.eIMin = eIMin;
	}
	public Float geteIMax() {
		return eIMax;
	}
	public void seteIMax(Float eIMax) {
		this.eIMax = eIMax;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getItemPy() {
		return itemPy;
	}
	public void setItemPy(String itemPy) {
		this.itemPy = itemPy;
	}
	public Short getItemCtrlLead() {
		return itemCtrlLead;
	}
	public void setItemCtrlLead(Short itemCtrlLead) {
		this.itemCtrlLead = itemCtrlLead;
	}
	public Short getItemCtrlComLd() {
		return itemCtrlComLd;
	}
	public void setItemCtrlComLd(Short itemCtrlComLd) {
		this.itemCtrlComLd = itemCtrlComLd;
	}
	public Short getItemCtrlQi() {
		return itemCtrlQi;
	}
	public void setItemCtrlQi(Short itemCtrlQi) {
		this.itemCtrlQi = itemCtrlQi;
	}
	public Short getItemCtrlTech() {
		return itemCtrlTech;
	}
	public void setItemCtrlTech(Short itemCtrlTech) {
		this.itemCtrlTech = itemCtrlTech;
	}
	public Short getItemCtrlAcce() {
		return itemCtrlAcce;
	}
	public void setItemCtrlAcce(Short itemCtrlAcce) {
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
	public long getProTeam() {
		return proTeam;
	}
	public void setProTeam(long proTeam) {
		this.proTeam = proTeam;
	}
	public PresetDivision getYsId() {
		return ysId;
	}
	public void setYsId(PresetDivision ysId) {
		this.ysId = ysId;
	}
	public Float getEIMin() {
		return eIMin;
	}
	public void setEIMin(Float min) {
		eIMin = min;
	}
	public Float getEIMax() {
		return eIMax;
	}
	public void setEIMax(Float max) {
		eIMax = max;
	}
}
