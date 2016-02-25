package com.repair.common.pojo;

import java.io.Serializable;

/**
 * 配件预设分类表
 * @author Administrator
 *
 */
public class PJPresetDivision implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4950137324859333422L;
	/**
	 * 主键ID
	 */
	private Long presetId;
	/**
	 * 预设分类名称
	 */
	private String presetName;
	/**
	 * 班组
	 */
	private DictProTeam proTeam;
	/**
	 * 机车类型
	 */
	private String jcType;
	/**
	 * 配件大类
	 */
	private PJStaticInfo pjsId;
	
	public Long getPresetId() {
		return presetId;
	}
	public void setPresetId(Long presetId) {
		this.presetId = presetId;
	}
	public String getPresetName() {
		return presetName;
	}
	public void setPresetName(String presetName) {
		this.presetName = presetName;
	}
	public DictProTeam getProTeam() {
		return proTeam;
	}
	public void setProTeam(DictProTeam proTeam) {
		this.proTeam = proTeam;
	}
	public String getJcType() {
		return jcType;
	}
	public void setJcType(String jcType) {
		this.jcType = jcType;
	}
	public PJStaticInfo getPjsId() {
		return pjsId;
	}
	public void setPjsId(PJStaticInfo pjsId) {
		this.pjsId = pjsId;
	}
}
